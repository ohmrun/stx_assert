package stx.assert.pack.comparable.term;

class Int implements ComparableApi<StdInt> extends Clazz{
  public function eq() : Eq<StdInt>{
    return Eq.int();
  }
  public function lt() : Ord<StdInt>{
    return Ord.int();
  }
}