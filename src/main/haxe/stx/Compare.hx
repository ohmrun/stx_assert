package stx;

import stx.data.Predicate in TPredicate;

import stx.types.*;

import stx.Equal;
import stx.Order;


using stx.Pointwise;



/**
  This is a good class to use in conjuncture with stx.UnitTest, stx.test.Assert and filters.

  ```
  import stx.Compare;.*;

  arr.filter(eq(3)) // produces predicate that returns true if input equals 3.
  ```
  nice.

  Unlikely to screw with other global namespace stuff, but keep an eye on it.
**/
class Compare{
  /**
		Predicator for value v.
	**/
  @:noUsing static public inline function compare<T>(v:T){
    return new Predicator(v);
  }
  /**
		Always returns true, no matter the input.
	**/
  @:noUsing static public inline function always<T>():stx.Predicate<T>{
    return function(value:T){return true;}
  }
  /**
		Always returns false, no matter the input.
	**/
  @:noUsing static public inline function never<T>():Predicate<T>{
    return function(value:T){return false;}
  }
  /**
		Bools.isTrue
	**/
  @:noUsing static public inline function ok():Predicate<Bool>{
    return function(value:Bool){return value;}
  }
  /**
		Bools.isFalse
	**/
  @:noUsing static public inline function no():Predicate<Bool>{
    return function(value:Bool){return !value;}
  }
  @:noUsing static public inline function is<A>(cls:Class<A>):Predicate<A>{
    return Std.is.c1(cls);
  }
  @:noUsing static public inline function throws<A>(?type:Class<Dynamic>):Predicate<Void->Void>{
    return function(fn:Void->Void):Bool{
      var er = null;
      try{
        fn();
      }catch(e:Dynamic){
        er = e;
      }
      return !(er == null) && (type != null ? Std.is(er,type) : true);
    }
  }
  /**
		null-check
	**/
  @:noUsing static public inline function nil<T>():stx.Predicate<T>{
    return function(value:T) {return value == null;}
  }
  @:noUsing static public inline function alike(e1:EnumValue):stx.Predicate<EnumValue>{
    return function(e2){ return Type.enumIndex(e1) == Type.enumIndex(e2); }
  }
  @:noUsing static public inline function matches(reg:EReg):stx.Predicate<String>{
    return function(str:String){return reg.match(str);}
  }
  /**
		equals
	**/
  @:noUsing static public inline function eq<T>(p:T):stx.Predicate<T>{
    return Equal.getEqualFor(p).c0(p);
  }
  /**
		greater than
	**/
  @:noUsing static public inline function gt<T>(p:T):stx.Predicate<T>{
    return Order.getOrder(p).c0(p).then(function(x) return x >= 1);
  }
  /**
		greater than or equal
	**/
  @:noUsing static public inline function gteq<T>(p:T):stx.Predicate<T>{
    return Order.getOrder(p).c0(p).then(function(x) return x >= 0);
  }
  /**
		less than
	**/
  @:noUsing static public inline function lt<T>(p:T):stx.Predicate<T>{
    return Order.getOrder(p).c0(p).then(function(x) return x <= -1);
  }
  /**
		less than or equal
	**/
  @:noUsing static public inline function lteq<T>(p:T):stx.Predicate<T>{
    return Order.getOrder(p).c0(p).then(function(x) return x <= 0);
  }
}
