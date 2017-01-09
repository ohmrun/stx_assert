package stx.macro.clone;


using haxe.macro.Tools;
using tink.MacroApi;
import haxe.Constraints.IMap;
import haxe.ds.BalancedTree;

using thx.Options;

typedef MethodsT    = Map<Kind,MethodMap>;
typedef MethodMapT  = Map<stx.macro.clone.data.Address,Method>;

@:forward abstract MethodMap(MethodMapT) from MethodMapT{
  public function new(?v:Map<stx.macro.clone.data.Address,Method>){
    if (v == null){
      v = new Map();
    }
    this = v;
  }
  public function count(){
    return T.count().reduceBy(this,0);
  }
}
class Methods extends BalancedTree<Kind, MethodMap> implements IMap<Kind, MethodMap> {
  public function count(){
    return T.count().reduceBy(this,0);
  }
  override function compare(k1:Kind, k2:Kind):Int {
    return switch([k1,k2]){
      case [Known(a),Known(b)]:
        switch a.getIndex() - b.getIndex() {
          case 0: Reflect.compare(a.toString(), b.toString());//TODO: this may be rather expensive and not very reliable
          case v: v;
        }
      case [Immutable,Immutable]      : 0;
      case [Unknown,Unknown]          : 0;
      case [Unknown,Immutable]        : 1;
      case [Immutable,Unknown]        : -1;
      case [Known(_),Unknown]         : -1;
      case [Unknown,Known(_)]         : 1;
      case [Anon(type0),Anon(type1)]  :
        var l = TypeTools.toComplexType(type0).toString();
        var r = TypeTools.toComplexType(type1).toString();
        trace('$l,$r');
         l == r ? 0 : l > r ? -1 : l < r ? 1 : 0;
      case [_,Anon(type)]             : 1;
      case [Anon(type),_]             : -1;
      default                         : 0;
    }
  }
  public function recursives(){
    var stack = [];
    for(methodmap in this){
      var count = 0;
      for(key in methodmap.keys()){
        count++;
      }
      var out = null;
      if( count > 1){
        for(val in methodmap){
          stack.push(val);
          break;
        }
      }
    }
    return stack;
  }
  public function getByType(type){
    return this.get(type);
  }
  public function setMethod(request:Request,method:Method){
    //trace('set: ${request.type} ${request.kind}');
    if(!this.exists(request.kind)){
      var map  = new MethodMap();
      this.set(request.kind, map);
    }
    var map = this.get(request.kind);
        map.set(request.address,method);
  }
  public function hasDefault(request:Request):Bool{
    return this.exists(request.kind) ? this.get(request.kind).exists(request.address.asDefault()) : false;
  }
  public function getMethod(request:Request){
    return if(!this.exists(request.kind)){
      null;
    }else{
      this.get(request.kind).get(request.address);
    }
  }
  public function getAny(request:Request):Null<Method>{
    return if(!this.exists(request.kind)){
      trace('method not found $request');
      null;
    }else{
      //trace('method found $request');
      var iterable : Iterable<Method> = {
        iterator : function(){
          return this.get(request.kind).iterator();
        }
      }
      var out = T.last().reduceBy(iterable,null);
      return out;
    }
  }

  public function getDefault(request:Request){
    return getMethod(request.asDefault());
  }
  public function has(req:Request):Bool{
    return if(this.exists(req.kind)){
      this.get(req.kind).exists(req.address);
    }else{
      false;
    }
  }
  public function hasAny(req:Request):Bool{
    return if(this.exists(req.kind)){
      var all = this.get(req.kind);
      return T.count().reduceBy(all,0) > 0;
    }else{
      false;
    }
  }
  override public function toString():String{
    var o = "(";
    for (key in this.keys()){
      var keystr = Kinds.toString(key);
      o+=' $keystr';
    }
    o+=")";
    return o;
  }
}
