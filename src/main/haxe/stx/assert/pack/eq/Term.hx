package stx.assert.pack.eq;

import stx.assert.pack.eq.term.*;
import stx.assert.pack.eq.term.Int;
import stx.assert.pack.eq.term.Couple;

class Term extends Clazz{
  public function int():Eq<StdInt>{
    return new Int();
  }
  public function string():Eq<StdString>{
    return new String();
  }
  public function couple<L,R>(l:Eq<L>,r:Eq<R>):Eq<StdCouple<L,R>>{
    return new Couple(l,r);
  }
}