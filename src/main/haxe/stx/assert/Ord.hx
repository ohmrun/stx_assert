package stx.assert;

import stx.assert.ord.term.*;
import stx.assert.ord.term.Couple;
import stx.assert.ord.term.EnumValue;
import stx.assert.ord.term.Array;
import stx.assert.ord.term.Cluster;
import stx.assert.ord.term.String;
import stx.assert.ord.term.Int;
import stx.assert.ord.term.Int64;
import stx.assert.ord.term.Float;
import stx.assert.ord.term.Anon;
import stx.assert.ord.term.Primitive;

typedef NullT<T> = Null<T>;

interface OrdApi<T>{
  public function comply(lhs:T,rhs:T):Ordered;
  public function toOrdApi():OrdApi<T>;
}
abstract class OrdCls<T> implements OrdApi<T>{
  abstract public function comply(lhs:T,rhs:T):Ordered;
  public function toOrdApi():Ord<T>{
    return this;
  }
}

@:forward abstract Ord<T>(OrdApi<T>) from OrdApi<T> to OrdApi<T>{
  public function new(self){
    this = self;
  }
  @:to public function toAssertion():Assertion<T,AssertFailure>{
    return new OrdAssertion(this).asAssertionApi();
  } 
  @:noUsing static public function Int():Ord<StdInt>{
    return new Int();
  }
  @:noUsing static public function Int64():Ord<haxe.Int64>{
    return new Int64();
  }
  @:noUsing static public function Float():Ord<StdFloat>{
    return new Float();
  }
  @:noUsing static public function String():Ord<StdString>{
    return new String();
  }
  @:noUsing static public function Couple<L,R>(l,r):Ord<stx.nano.Couple<L,R>>{
    return new Couple(l,r);
  }
  @:noUsing static public function Anon<T>(fn:T->T->Ordered):Ord<T>{
    return new Anon(fn);
  }
  @:noUsing static public function Bool():Ord<StdBool>{
    return Anon(
      (lhs:StdBool,rhs:StdBool) -> lhs == rhs ? NotLessThan : lhs == false ? LessThan : NotLessThan
    );
  }
  @:noUsing static public function Primitive():Ord<stx.nano.Primitive>{
    return new Primitive();
  }
  @:noUsing static public function Array<T>(inner:Ord<T>):Ord<StdArray<T>>{
    return new Array(inner);
  }
  @:noUsing static public function Cluster<T>(inner:Ord<T>):Ord<stx.Cluster<T>>{
    return new Cluster(inner);
  }
  @:noUsing static public function Option<T>(inner:Ord<T>):Ord<StdOption<T>>{
    return new stx.assert.ord.term.Option(inner);
  }
  @:noUsing static public function NullOr<T>(inner:Ord<T>):Ord<Null<T>>{
    return new stx.assert.ord.term.NullOr(inner).toOrdApi();
  }
  @:noUsing static public function EnumValue():Ord<StdEnumValue>{
    return new EnumValue();
  }
  @:noUsing static public function EnumValue():Ord<Ident>{
    return new stx.assert.ord.term.Ident();
  }
}