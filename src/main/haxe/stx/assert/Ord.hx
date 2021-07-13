package stx.assert;

import stx.assert.ord.term.*;
import stx.assert.ord.term.Couple;
import stx.assert.ord.term.Array;
import stx.assert.ord.term.String;
import stx.assert.ord.term.Int;
import stx.assert.ord.term.Float;
import stx.assert.ord.term.Anon;
import stx.assert.ord.term.Primitive;

interface OrdApi<T>{
  public function comply(lhs:T,rhs:T):Ordered;
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
  @:noUsing static public function Option<T>(inner:Ord<T>):Ord<StdOption<T>>{
    return new stx.assert.ord.term.Option(inner);
  }
}