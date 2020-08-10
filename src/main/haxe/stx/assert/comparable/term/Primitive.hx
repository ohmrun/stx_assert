package stx.assert.comparable.term;

import stx.nano.Primitive in PrimitiveT;

class Primitive implements ComparableApi<PrimitiveT> extends Clazz{
  public function eq() : Eq<PrimitiveT>{
    return Eq.Primitive();
  }
  public function lt():Ord<PrimitiveT>{
    return Ord.Primitive();
  }
}