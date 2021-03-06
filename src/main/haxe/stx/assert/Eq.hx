package stx.assert;

import stx.assert.eq.term.Primitive; 
import stx.assert.eq.term.Noise; 
import stx.assert.eq.term.Anon;
import stx.assert.eq.term.*;
import stx.assert.eq.term.Couple;
import stx.assert.eq.term.Int;
import stx.assert.eq.term.String;

interface EqApi<T>{
  public function comply(lhs:T,rhs:T):Equaled;
}

@:forward abstract Eq<T>(EqApi<T>) from EqApi<T> to EqApi<T>{
  public function new(self){
    this = self;
  }
  public function toAssertion(?pos:Pos):Assertion<T,AssertFailure>{
    return new EqAssertion(this,pos);
  } 
  @:noUsing static public function Int():Eq<StdInt>{
    return new Int();
  }
  @:noUsing static public function String():Eq<StdString>{
    return new String();
  }
  @:noUsing static public function Couple<L,R>(l:Eq<L>,r:Eq<R>):Eq<StdCouple<L,R>>{
    return new Couple(l,r);
  }
  @:noUsing static public function Anon<T>(fn:T->T->Equaled):Eq<T>{
    return new Anon(fn);
  }
  @:noUsing static public function Noise():Eq<tink.core.Noise>{
    return new Eq(new Noise());
  }
  @:noUsing static public function Bool():Eq<StdBool>{
    return Anon(
      (l,r) -> l == r ? AreEqual : NotEqual
    );
  }
  @:noUsing static public function Float():Eq<StdFloat>{
    return Anon(
      (l,r) -> l == r ? AreEqual : NotEqual
    );
  }
  @:noUsing static public function Array<T>(inner:Eq<T>):Eq<StdArray<T>>{
    return new Array(inner);
  }
  @:noUsing static public function Primitive():Eq<stx.nano.Primitive>{
    return new Primitive();
  }
  @:noUsing static public function Option<T>(inner:Eq<T>):Eq<Option<T>>{
    return new stx.assert.eq.term.Option(inner);
  }
}
