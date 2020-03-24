package stx.assert.pack;

import stx.compare.Errors;

import stx.order.Enum in EnumOrder;

import haxe.Constraints;
import tink.core.Error;
import stx.types.*;


import Type;

using Std;

import stx.type.*;

using stx.Order;

import stx.Order.Ordered in O;

@:forward @:callable abstract Ord<T>(stx.data.Ord<T>){
	public function new<T>(ord:stx.data.Ord<T>){
	  this = ord;
	}
	public function c0(l:T){
		return this.bind(l);
	}
	public function wrap():Ord<T>{
		return @:access(stx.Ordered.wrap) Ordered.wrap(new Ord(this));
	}
	public function greaterThan(): Eq<T> {
    return function(v1, v2) return this(v1, v2) > 0;
  }

  public function gt(): Eq<T> {
     return function(v1, v2) return this(v1, v2) >= 0;
  }

  public function lt(): Eq<T> {
    return function(v1, v2) return this(v1, v2) < 0;
  }

  public function lteq(): Eq<T> {
     return function(v1, v2) return this(v1, v2) <= 0;
  }

  public function eq(): Eq<T> {
     return function(v1, v2) return this(v1, v2) == 0;
  }

  public function neq(): Eq<T> {
     return function(v1, v2) return this(v1, v2) != 0;
  }
}
class Order {
  /**
	 *	Returns a OrderFunction (T -> T -> Int). It works for any type expect TFunction.
   *  Custom Classes must provide a compare(other : T): Int method or an exception will be thrown.
   */
	static public function getOrder<T>(v:Dynamic):Ord<T>{
		return switch Tag.fromT(v) {
			case TTBool(b)				: new Ord(O.bool).wrap();
		  case TTInt(int)				: new Ord(O.int).wrap();
		  case TTFloat(f)				: new Ord(O.float).wrap();
		  case TTNull						: new Ord(O.nil);
		  case TTFunction(fn)		: new Ord(O.fun).wrap();
			case TTClass(String,_): new Ord(O.string).wrap();
			case TTClass(Array,_) : new Ord(O.array).wrap();
		  case TTClass(cls,v)		: new Ord(O.type.bind(cls)).wrap();
		  case TTEnum(enm,v)		: new Ord(O.enumeration).wrap();
		  case TTUnknown				: new Ord(O.unknown).wrap();
		  case TTObject(v)			: new Ord(O.object).wrap();
		};
	}
}
class Ordered{
	static public function wrap<T>(ord:Ord<T>):Ord<T>{
		return new Ord(function(a,b){
			return if(a == b || (a == null && b == null)) 0;
				else if(a == null) -1;
				else if(b == null) 1;
				else ord(a, b);
		});
	};
	static public function bool(l:Bool,r:Bool){
		return if (!l && r) -1 else if (l && !r) 1 else 0;
	}
	static public function int(l:Int,r:Int){
		return if (l < r) -1 else if (l > r) 1 else 0;
	}
	static public function float(l:Float,r:Float){
		return if (l < r) -1 else if (l > r) 1 else 0;
	}
	static public function unknown<T>(a : T, b : T) {
		return (a == b) ? 0 : ((cast a) > (cast b) ? 1 : -1);
	}
	static public function object(l:Dynamic,r:Dynamic){
		for(key in Reflect.fields(l)) {
			var va = Reflect.field(l, key);
			var vb = Reflect.field(r, key);
			var v  = Order.getOrder(va)(va, vb);
			if(0 != v)
				return v;
		}
		return 0;
	}
	static public function fun(l:Function,r:Function){
		throw Errors.compareFunctionError();
		return 0;
	}
	static public function nil<T>(l:Null<T>,r:Null<T>){
		return l == null && r == null ? 0 : l != null ? -1 : 1;
	}
	static public function type<T>(type:Class<T>,l:T,r:T){
		return if(Type.getInstanceFields(type).remove("order")) {
			(cast l).order(r);
		}else {
			throw Errors.noImplementation();
			0;
		}
	}
	static public function enumeration(l,r){
		return stx.order.Enum.order(l,r);
	}
	static public function string(l,r){
		return (l == r) ? 0 : (l > r ? 1 : -1);
	}
	static public function array(l,r){
		return stx.order.Array.order(l,r);
	}
}
