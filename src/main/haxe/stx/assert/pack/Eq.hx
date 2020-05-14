package stx.assert.pack;

import stx.assert.pack.eq.term.*;
import stx.assert.pack.eq.term.Couple;
import stx.assert.pack.eq.term.Int;
import stx.assert.pack.eq.term.String;

@:forward abstract Eq<T>(EqApi<T>) from EqApi<T> to EqApi<T>{
  public function new(self){
    this = self;
  }
  public function toAssertion(?pos:Pos):Assertion<T,AssertFailure>{
    return new EqAssertion(this,pos);
  } 
  @:noUsing static public function int():Eq<StdInt>{
    return new Int();
  }
  @:noUsing static public function string():Eq<StdString>{
    return new String();
  }
  @:noUsing static public function couple<L,R>(l:Eq<L>,r:Eq<R>):Eq<StdCouple<L,R>>{
    return new Couple(l,r);
  }
}