package stx;

using stx.Pointwise;
using stx.Transducers;

import haxe.ds.Option;
import stx.types.*;

import haxe.ds.StringMap;

import Type;

using stx.Tuple;

class Equaled{

}
@:note('#0b1kn00b: The assumption that the right hand value is of the correct type could be questioned')
class Equal{
  static public function getEqualFor<T>(v:T):Eq<T>{
    return getEqualForType(Type.typeof(v));
  }
  static public function getEqualForType<T>(v: ValueType):Eq<T>{
    return switch (v){
      case TNull                                                        : NullEqual.equals;
      case TInt,TFloat,TBool                                            : __equals__(function(x,y) return x == y);
      case TFunction                                                    : __equals__(Reflect.compareMethods);
      case TClass( c ) if ( c == StringMap  )                           : __equals__(StringMapEqual.equals);
      case TClass( c ) if ( c == Array  )                               : __equals__(ArrayEqual.equals);
      case TClass( c ) if ( c == Date   )                               : __equals__(
        function(l:Date,r:Date){
          return l.getTime() == r.getTime();
        }
      );
      case TClass( c ) if ( c == String )                               : __equals__(
        function(l:String,r:String){
          return l == r;
        }
      );
      case TEnum(_)                                                     : __equals__(EnumEqual.equals);
      case TClass( c )                                                  :
        if(Type.getInstanceFields(c).remove("equals")){
          __equals__(EqualsEquals.equals);
        }else{
          __equals__(UnsupportedClassEqual.equals);
        }
      case TObject      : __equals__(ObjectEquals.equals);
      case TUnknown     : __equals__(
        function(x,y){
          return if(Reflect.hasField(x,'equals')){
            EqualsEquals.equals(x,y);
          }else{
            ObjectEquals.equals(x,y);
          }
        }
      );
    }
  }
  public static inline function  __equals__<A>(impl:Eq<Dynamic>):Eq<A> {
    return function(a:Dynamic, b:Dynamic) {
      return if(a == b || (a == null && b == null)) true;
        else if(a == null || b == null) false;
        else impl(a, b);
    };
  }
}
class UnsupportedClassEqual{
  @:noUsing static public inline function equals<T>(a:T,b:T):Bool{
    return ObjectEquals.equals(a,b) && (Type.getClass(a) == Type.getClass(b));
  }
}
class NullEqual{
  @:noUsing static public inline function equals<T:Null<Dynamic>>(a:T,b:T):Bool{
    return (a == null) && (b == null);
  }
}
class ObjectEquals{
  static public inline function equals<A>(a:Dynamic,b:Dynamic):Bool{
    var o = true;
    for(key in Reflect.fields(a)) {
      var va = Reflect.field(a, key);
      if(!Equal.getEqualFor(va)(va, Reflect.field(b, key))){
        o = false;break;
      }
    }
    return o;
  }
}
class OptionEqual{
  static public inline function equals<A>(op0:Option<A>,op1:Option<A>):Bool{
    return switch([op0,op1]){
      case [Some(l),Some(r)] : return Equal.getEqualFor(l)(l,r);
      default : false;
    }
  }
}

/*
class ProductEquals{
  static public inline function equals(a:Product,b:Product){
    var els0  = a.elements();
    var els1  = b.elements();
    var o     = true;
    if(els0.length != els1.length){ o  = false; }
    else{
      for (idx in 0...els0.length){
        var l = els0.element(idx);
        var r = els1.element(idx);
        if( Equal.getEqualFor(l)(l,r) == false){
          o = false;
          break;
        }
      }
    }
    return o;
  }
}*/
class StringMapEqual{
  static public inline function equals<A>(a:StringMap<A>,b:StringMap<A>):Bool{
    var allA = T.map(a.get.link())(T.toArray).reduceBy(a.keys(),[]);
    var allB = T.map(b.get.link())(T.toArray).reduceBy(b.keys(),[]);
    return ArrayEqual.equals(allA,allB);
  }
}
class MapEqual{
  static public inline function equals<K,V>(a:Map<K,V>,b:Map<K,V>):Bool{
    var ok = true;
    if(a.reduce(T.count(),0) !=b.reduce(T.count(),0)){
      ok = false;
    }
    if(ok){
      for (key in a.keys()){
        if(!Equal.getEqualFor(a.get(key))(a.get(key),b.get(key))){
          ok = false;
          break;
        }
      }
    }
    return ok;
  }
}
class EqualsEquals{
  static public inline function equals<A>(a:{ equals : A -> Bool },b:Dynamic):Bool{
    return a.equals(b);
  }
}
class EnumEqual{
  @:noUsing static public inline function equals(a:Dynamic,b:Dynamic):Bool{
    return if(0 != Type.enumIndex(a) - Type.enumIndex(b)){
      false;
    }else{
      var pa  = Type.enumParameters(a);
      var pb  = Type.enumParameters(b);
      var b   = true;
      for(i in 0...pa.length) {
        if(!Equal.getEqualFor(pa[i])(pa[i], pb[i]))
          b = false;
      }
      b;
    }
  }
}
class ArrayEqual {
  public static inline function equals<T>(v1: Array<T>, v2: Array<T>):Bool {
    return equalsWith(v1, v2, Equal.getEqualFor(v1[0]));
  }
  public static inline function equalsWith<T>(v1: Array<T>, v2: Array<T>, equal : Eq<T>) {
    var o = (equal != null);

    return if(!o){
      o;
    }else if (v1.length != v2.length) {
      false;
    }else if (v1.length == 0) {
      true;
    }else{
      for (i in 0...v1.length) {
        if (!equal(v1[i], v2[i])) {
          o = false;
          break;
        }
      }
      o;
    }
  }
}
