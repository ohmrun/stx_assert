package stx.assert.pack.comparable.term;


import stx.assert.pack.eq.Term  in Eqs;
import stx.assert.pack.ord.Term in Ords;


class Int implements ComparableApi<StdInt> extends Clazz{
  public function eq() : Eq<StdInt>{
    return Eq.term.int();
  }
  public function lt() : Ord<StdInt>{
    return Ord.term.int();
  }
}