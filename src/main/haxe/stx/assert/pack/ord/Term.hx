package stx.assert.pack.ord;

import stx.assert.pack.ord.term.*;
import stx.assert.pack.ord.term.Int;
import stx.assert.pack.ord.term.String;
import stx.assert.pack.ord.term.Couple;

class Term extends Clazz{
  public function int():Ord<StdInt>{
    return new Int();
  }
  public function string():Ord<StdString>{
    return new String();
  }
  public function couple<L,R>(l,r):Ord<stx.core.pack.Couple<L,R>>{
    return new Couple(l,r);
  }
}