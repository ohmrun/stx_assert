package stx.assert.pack.comparable.term;


class String implements ComparableApi<StdString> extends Clazz{
  public function eq() : Eq<StdString>{
    return Eq.term.string();
  }
  public function lt() : Ord<StdString>{
    return Ord.term.string();
  }
}