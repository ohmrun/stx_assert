package stx;

import tink.core.Error;
import stx.types.*;

import Type;
import stx.Show;

using stx.Tuple;
using stx.Hash;

@:note("#0b1kn00b: My theory on this is very limited. How to implement minimal collisions.")
class Hash {
	static function __hash__<T>(impl : Dynamic->Int) {
    return function(v : T) {
      return null == v ? 0 : impl(v);
    }
  }
  /**
    Returns a HashFunction (T -> Int). It works for any type. For Custom Classes you should provide a hashCode()
   */
  public static function getHashFor<T>(t : T) : T->Int {
    return getHashForType(Type.typeof(t));
  }
  public static function getHashForType<T>(v: ValueType) : T->Int {
    return switch(v) {
      case TBool            : __hash__(BoolHash.hashCode);
      case TInt             : __hash__(IntHash.hashCode);
      case TFloat           : __hash__(FloatHash.hashCode);
      case TUnknown         : __hash__(function(v: T) {throw new Error(500,'can\'t retrieve hashcode for TUnknown: $v'); return 0;});
      case TObject          :
        __hash__(function(v){
        //var s = Show.getShowFor(v)(v);
				//too slow?
        var s = haxe.Serializer.run(v);
        return getHashFor(s)(s);
        });
      case TClass(String)   : __hash__(StringHash.hashCode);
      case TClass(Date)     : __hash__(DateHash.hashCode);
      case TClass(Array)    : __hash__(ArrayHash.hashCode);
      case TClass(c)        :
          if(Type.getInstanceFields(c).remove("hashCode")) {
            __hash__(function(v) return Reflect.callMethod(v, Reflect.field(v, "hashCode"), []));
          }else{
						var serialized = haxe.Serializer.run(v);
            __hash__(function(v) return StringHash.hashCode(serialized));
          }
      /*case TEnum(Tuple2)    : __hash__(Tuple2Hash.hashCode);
      	case TEnum(Tuple3)    : __hash__(Tuple3Hash.hashCode);
      	case TEnum(Tuple4)    : __hash__(Tuple4Hash.hashCode);
				case TEnum(Tuple5)    : __hash__(Tuple5Hash.hashCode);*/
      case TEnum(_)         :
        __hash__(
          function(v : T) {
            var hash = Type.enumConstructor(cast v).hashCode() * 6151;
            for(i in Type.enumParameters(cast v)){
              hash += Hash.getHashFor(i)(i) * 6151;
            }
            return hash;
        });
      case TFunction        : __hash__(function(v : T):Int {throw new Error(500,"function can't provide a hash code"); return 0;});
      case TNull            : nil;
    }
	}
  @:noUsing static public function nil<A>(v:A):Int { return 0;}
}
class ArrayHash {
	public static function hashCode<T>(v: Array<T>) {
    return hashCodeWith(v, Hash.getHashFor(v[0]));
  }
	public static function hashCodeWith<T>(v: Array<T>, hash : T->Int) {
    var h = 12289;
    if(v.length == 0) return h;
    for (i in 0...v.length) {
      h += hash(v[i]) * 12289;
    }
    return h;
  }
}
class StringHash {
	  public static function hashCode(v: String) {
    var hash = 49157;
    for (i in 0...v.length) {
#if neko
      hash += (24593 + v.charCodeAt(i)) * 49157;
#else
      hash += (24593 + untyped v.cca(i)) * 49157;
#end
    }
    return hash;
  }
}
class DateHash {
	  public static function hashCode(v: Date) {
    return Math.round((v.getTime() * 49157));
  }
}
class FloatHash {
	public static function hashCode(v: Float) {
    return Std.int(v * 98317);
	}
}
class IntHash {
	public static function hashCode(v: Int) : Int {
    return v * 196613;
  }
}
class BoolHash {
	public static function hashCode(v : Bool) : Int {
    return if (v) 786433 else 393241;
  }
}
/*
class ProductHash {
  static function __init__(){
    __baseHashes__
      = [
          [],
          [786433, 24593],
          [196613, 3079, 389],
          [1543, 49157, 196613, 97],
          [12289, 769, 393241, 193, 53]
        ];
  }
	static public function getHash(p:Product, i : Int) {
    return Hash.getHashFor(p.element(i));
  }
  static var __baseHashes__ : Array<Array<Int>>;

  public static function hashCode(p:Product) : Int {
    var h         = 0;
    var __hash__  = ProductHash.__baseHashes__[p.length-1];
    for(i in 0...p.length){
      h += __hash__[i] * getHash(p,i)(p.element(i));
    }
    return h;
  }
}*/
/*
class Tuple2Hash{
  public static function hashCode(tp:Tuple2<Dynamic,Dynamic>){
    var prd : Product = Product.fromTuple2(tp);
    return ProductHash.hashCode(prd);
  }
}

class Tuple3Hash{
  public static function hashCode(tp:Tuple3<Dynamic,Dynamic,Dynamic>){
    var prd : Product = Product.fromTuple3(tp);
    return ProductHash.hashCode(prd);
  }
}
class Tuple4Hash{
  public static function hashCode(tp:Tuple4<Dynamic,Dynamic,Dynamic,Dynamic>){
    var prd : Product = Product.fromTuple4(tp);
    return ProductHash.hashCode(prd);
  }
}
class Tuple5Hash{
  public static function hashCode(tp:Tuple5<Dynamic,Dynamic,Dynamic,Dynamic,Dynamic>){
    var prd : Product = Product.fromTuple5(tp);
    return ProductHash.hashCode(prd);
  }
}*/
