package stx.macro;

using thx.Iterables;

import thx.fp.State;

using stx.Pointwise;


using stx.macro.CloneHelpers;

using thx.Arrays;

#if macro
  import thx.Assert;
  import stx.macro.clone.ObjectTreeNode;
  import stx.macro.clone.Path;
  import stx.macro.clone.PathNode;
  import stx.macro.clone.Ctx;

  using tink.MacroApi;

class Item{
  public function new(type){
    this.type = type;
  }
  public var type : Type;
  //public var path : Path;
}
#end
class CloneHelpers{
  static var printer = new Printer();
  static public macro function apply(e:Expr):Expr{
    //var b = haxe.Timer.stamp();
    var d = 0;
    var type              = Context.typeof(e);
    /*
    trace(haxe.Timer.stamp()-b);
    b = haxe.Timer.stamp();*/
    var out               = loop(type,Ctx.create());
    /*trace(haxe.Timer.stamp()-b);
    b = haxe.Timer.stamp();*/
    ////trace(out.tree.toTree());
    var expr              = out.reply();

    /*trace(haxe.Timer.stamp()-b);
    b = haxe.Timer.stamp();*/

    ////trace(printer.printExpr(expr));
    return expr;
  }
  #if macro

  static public function loop(type:Null<Type>,ctx:Ctx):Ctx{
    //trace("_____________________________________");
    //trace('find ${type.identify()} at ${ctx.path}');
    var node                    = new ObjectTreeNode(ctx.path,type,type.identify());
    //trace('add $node');

    ctx = ctx.withNode(node);
    //trace('contains: ${type.identify()}? ${ctx.contains(type)}');
    if(ctx.contains(type)){
      if(!type.isTerminal()){
        //trace('type is recursive: $type');
        var item =  ctx.items.get(node.id);
                    ctx = ctx.withNode(node.withRecursion(true))
                             .withItem(item.withRecursive(true));

      }
      /*if(this.exists(ci.id) && !ci.type.isTerminal()){
        ci = ci.withRecursive(true);
      }*/
      return ctx;
    }else{

    }
    var clone_item              = new CloneItem(type);

    ctx = ctx
      .withCursor(clone_item)
      .withItem(clone_item);

    var algo : State<Ctx,Type> = State.pure(type);
    var handle                 = function(state:Ctx,value:Either<Type,Ctx>,handlers:Array<Ctx->Type->Either<Type,Ctx>>):Ctx{
      var o = handlers.foldLeft(
        value,
        function(memo:Either<Type,Ctx>,next:Ctx->Type->Either<Type,Ctx>){
          return switch(memo){
            case Left(type) : next(state,type);
            case Right(ctx) : Right(ctx);
          }
        }
      );
      return switch(o){
        case Left(t)    : state;
        case Right(ctx) : ctx;
      }

    }
    var next = algo.access(function(state,value){
      return collection_handler(state,value);
    }).refine(
      handle.bind(_,_,
        [primitive_handler,mono_handler,class_handler,anon_handler,default_handler]
      )
    );
    return next.runState(ctx);
  }
  static function mono_handler(ctx,type){
    return switch(type){
      case TMono(t) :
        //trace('mono: ${type.identify()}');
        var t_deeper = t.get();
        Right(loop(t.get(),ctx));
      default : Left(type);
    }
  }
  static function iterable_handler(ctx:Ctx,type:Type):Either<Type,Ctx>{
    return stx.macro.Types.isIterable(type) ? Right(ctx) : Left(type);
  }
  static function default_handler(ctx:Ctx,type:Type):Either<Type,Ctx>{
    //trace('default: ${type.identify()}');
    return Right(ctx);
  }
  static function primitive_handler(ctx:Ctx,type:Type){
    return switch type {
      case _.path() => Some("String") :
        //trace('primitive: ${type.identify()}');
        Right(ctx);
      default                         : Left(type);
    }
  }
  static function class_handler(ctx:Ctx,type:Type):Either<Type,Ctx>{
    return switch(type){
      case TInst(t,params) :
        //trace('class: ${type.identify()}');
        Right(type.getFields(true).sure()
         .filter(
           function(cf:ClassField){
             return switch cf.kind {
               case FVar(_,_):true;
               default: false;
             }
           }
         ).foldLeft(
          ctx.withCursor(ctx.cursor.withParams(params)),
          function(memo:Ctx,next:ClassField):Ctx{
            return field_handler(memo,next);
          }
        ));
      default : Left(type);
    }
  }
  static function anon_handler(ctx:Ctx,type:Type):Either<Type,Ctx>{
    //trace("anon_handler");
    return switch type {
      case TAnonymous(t):
        //trace('anon: ${type.identify()}');
        Right(type.getFields(true).sure().foldLeft(
          ctx,
          function(memo:Ctx,next:ClassField):Ctx{
            return field_handler(memo,next);
          }
        ));
      default:
        Left(type);
    }
  }
  static function collection_handler(ctx:Ctx,type:Type):Either<Type,Ctx>{
    //trace("collection_handler");
    return switch type {
      case _.path() => Some("Array"), _.path() => Some("List") :
        //trace('collection: ${type.identify()}');
        var item    = ctx.items.get(type.identify());
        var params  = item.type.getParams();
        ctx = ctx.withItem(
          item.withParams(params.toArray())
        );
        var path      = ctx.path;
        var path_next = path.add(ArrayAccess());

        var sub     = params[0];

        ctx         = loop(sub,ctx.withPath(path_next));

        var itm     = ctx.items.get(sub.identify());

        Assert.notNull(itm,'${sub.identify()}');

        var node      = new ObjectTreeNode(path_next,itm.type,itm.type.identify());

        ctx = ctx.withPath(path);

        Right(ctx);

      default: Left(type);
    }
  }
  static function field_handler(ctx:Ctx,field:ClassField):Ctx{
    var cursor    = ctx.cursor;
    var pre       = ctx.path;
    var next      = ctx.path.add(DotAccess(field.name));

    ctx           = loop(field.type,ctx.withPath(next));

    return ctx.withPath(pre)
         .withCursor(cursor);
  }
  #end
}
#if macro
@:allow(stx.macro.CloneItem) class CloneItem extends Item{
  static public function identify(type){
    var anon_type;
    var isAnon = (switch (type){
      case TAnonymous(at) :
        anon_type = at.get();
        true;
      default : false;
    });
    return if(isAnon){
      Context.signature(anon_type);
    }else{
      tink.macro.Types.toString(tink.macro.Types.toComplex(type));
    }
  }
  public function new(type,?recursive){
    super(type);
    this.parameters   = [];
    this.recursive    = recursive == null ? false : recursive;
    this.id           = identify(type);
  }
  public var recursive    : Bool;
  public var id           : String;
  public var name         : String;
  public var parent       : CloneItem;
  public var parameters   : Array<Type>;

  public function toString(){
    return '($id)';
  }
  public function copy(){
    var next             = new CloneItem(type);
        next.id          = this.id;
        next.name        = this.name;
        next.parent      = this.parent;
        next.parameters  = this.parameters;
        next.recursive   = this.recursive;
    return next;
  }
  public function withParams(params){
    var next = copy();
        next.parameters = params;
    return next;
  }
  public function withRecursive(recursive){
    var next = copy();
        next.recursive = recursive;
    return next;
  }
}
#end
