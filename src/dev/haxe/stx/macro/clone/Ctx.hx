package stx.macro.clone;

using thx.Options;
import stx.macro.clone.data.PathNode;
import thx.ReadonlyArray;
using stx.macro.Package;

using thx.Iterables;
using tink.macro.Exprs;
using thx.Arrays;
using thx.Maps;
using thx.Iterables;


import thx.fp.List;
import thx.fp.KTree;
import thx.fp.ktree.Zipper;

import Map;

import haxe.ds.StringMap;

import stx.macro.CloneHelpers;

@:allow(stx.macro.Ctx) class Ctx{

  static public function create(?items,?path,?tree){
    return new Ctx(items,path,tree);
  }
  function new(?items,?path,?tree){
    this.path   = path  == null   ? new Path()      : path;
    this.items  = items == null   ? new StringMap() : items;
    this.tree   = tree  == null   ? Empty           : tree;
  }
  public function contains(type:Type){
    return items.exists(
      type.identify()
    );
  }
  public function withPath(path){
    var next = copy();
        next.path = path;
    return next;
  }
  function copy(){
    var next        = new Ctx();
        next.items  = this.items.copy();
        next.path   = this.path.copy();
        next.cursor = this.cursor;
        next.tree   = this.tree;
    return next;
  }
  public function withNode(node:ObjectTreeNode){
    //trace('withNode: ${node.id}');
    ////trace('SEARCH ${this.path.up()}');
    var next      = copy();
    var head :  Zipper<ObjectTreeNode>     = next.tree.root().selectDF(
      function(x){
        var out = x.path.equals(this.path.up());
        if(out){
          ////trace('FOUND ${x.path}');
        }
        return out;
      }
    );
    switch(head){
      default:
        //trace('no node found for node "${node.type} at $node"');
        head = next.tree.update(
          Branch(node,thx.fp.List.empty())
        );
      case Cons(fst,xs) :
        //trace('node found for node "${node.type} at $node"');
        //trace('HEAD SET: ${fst}');
        var prev :  Zipper<ObjectTreeNode>     = next.tree.root().selectDF(
          function(x){
            var out = x.path.equals(this.path);
            if(out){
              //trace('FOUND ${x.path}');
            }
            return out;
          }
        );
        //trace(prev.head());
        head = head.remChildNode(prev.head()).addChild(node)._1;
    }
        next.tree = head;
    //trace(head);
    return next;
  }
  public function withCursor(cursor:CloneItem){
    var next        = copy();
        next.cursor = cursor;
    return next;
  }
  public function withItem(ci:CloneItem){
    var next        = copy();
        next.items  = this.items.add(ci);
    return next;
  }

  public var path(default,null)   : Path;
  public var items(default,null)  : Repo;
  public var cursor(default,null) : CloneItem;
  public var tree(default,null)   : Zipper<ObjectTreeNode>;

  public function reply(){
    //trace("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    var out     = Ctxs.applytree.toTree(),this.items);
    //trace(new Printer().printExpr(out));
    //return macro {};
    return out;
  }
  public function toString(){
    return 'Ctx($path)';
  }
  public function stackString(){
    return this.items.map(
      function(x){
        return '
        (${x.name},
          ${x.id},

        )';
      }
    ).join(',');
  }
}
class Ctxs{
  static public function apply(v:KTree<ObjectTreeNode>,items:Repo){
    function handler(tree:KTree<ObjectTreeNode>,path:Path){
      //trace('handler $path');
      //trace('${items.ids()}');
      return switch(tree){
        case Branch(v,leaves) :
          //trace(v.id);
          //trace(v.type);
          var item = items.get(v.id);
          //trace(item);
          switch([v.type,item.recursive]){
            case [TAnonymous(_),false] :
              var expr = handle_anon(leaves,handler,path);
              expr;
            case [TInst(t,_),false] if(v.type.isString()) :
              handle_default(path);
            case [TInst(t,_),false] if(v.type.isNativeArray()) :
              var out = handle_array(leaves,handler,path);
              //trace(printer.printExpr(out));
              out;
            case [TInst(_,_),false] :
              var constructor_type  = v.type.toComplex().toString();
              var ctype             = v.type.toComplex();
              var name              = v.type.path().get();
              var constructor       = macro var new_val : $ctype = Type.createEmptyInstance(${name.toEFieldPath()});
              var exprs             = handle_class(leaves,handler,path);
              var out               = [constructor].concat(exprs).concat([macro new_val]).toMBlock();
              //trace(printer.printExpr(out));
              out;
            case [TInst(_,_),true] :
              if(v.recursion){
                var safeName          = v.type.safeName().join("_");
                var id                = 'clone_${safeName}';
                var path              = path.toNative().toEFieldPath();
                macro ${path} == input ? input : $i{id}(${path});
              }else{
                var constructor_type  = v.type.toComplex().toString();
                var ctype             = v.type.toComplex();
                var name              = v.type.path().get();
                var constructor       = macro var new_val : $ctype = Type.createEmptyInstance(${name.toEFieldPath()});

                var safeName          = v.type.safeName().join("_");
                var id                = 'clone_${safeName}';
                var ctype             = v.type.toComplex();
                var path              = v.path.toNative().toEFieldPath();
                if(v.path.isHead()){
                  path = "_".toEFieldPath();
                }
                var sub               = handle_recursive_class(leaves,handler,new Path().append(DotAccess("input")));


                var method : Expr     = macro function $id(input:$ctype):$ctype{
                  $constructor;
                  ${sub.toMBlock()};
                  return new_val;
                }(${path});
                //trace("recursive type");
                //trace(printer.printExpr(method));
                method;
              }
            default : handle_default(path);
          }
        default : handle_default(path);
      }
    }
    var ctype = v.value().type.toComplex();
    var expr  = handler(v,new Path().append(DotAccess("_")));
    return macro function(_:$ctype):$ctype{
      return $expr;
    }
  }
  static public function handle_recursive_class(ls:List<KTree<ObjectTreeNode>>,handler:KTree<ObjectTreeNode>->Path->Expr,path:Path){
    return handle_class(ls,handler,path);
  }
  static public function handle_default(path:Path){
    var identifier = path.toNative().toEFieldPath();
    return macro ${identifier};
  }
  static public function handle_anon(ls:List<KTree<ObjectTreeNode>>,handler:KTree<ObjectTreeNode>->Path->Expr,path:Path){
    var vals  = ls.map(
      function(x){
        var leaf = x.value().path.leaf();
        var expr = handler(x,path.append(leaf));
        return
        {
          field : leaf.asIdentifier(),
          expr  : expr
        };
      }
    ).array();
    var out   = { expr : EObjectDecl(vals), pos : Context.currentPos() };
    return out;
  }
  static public function handle_class(ls:List<KTree<ObjectTreeNode>>,handler:KTree<ObjectTreeNode>->Path->Expr, path:Path){
    //trace("handle_class");
    var vals = ls.map(
      function(x){
        var leaf  = x.value().path.leaf();
        var bin   = path.append(leaf);
        var lhs   = ([DotAccess("new_val"),leaf]:Path).toNative().toEFieldPath();
        var rhs   = handler(x,bin);
        var type  = x.value().type.toComplex().toString();
        var expr  = macro ${lhs} = $rhs;
        return expr;
      }
    );
    return vals;
  }
  static public function handle_array(ls:List<KTree<ObjectTreeNode>>,handler:KTree<ObjectTreeNode>->Path->Expr, path: Path){
    var node  = ls.head();
    var leaf  = node.value().path.leaf();
    var lhs   = path.toNative().toEFieldPath();
    var tp    = ls.head().value().type;
    return macro {
      var new_arr = [];
      var old_arr = ${lhs};
      for (i in 0...old_arr.length){
        var next_val = old_arr[i];
        var v = ${handler(node,new Path().append(DotAccess("next_val")))};
        new_arr.push(v);
      }
      new_arr;
    }
  }
  static public var printer = new Printer();
}
