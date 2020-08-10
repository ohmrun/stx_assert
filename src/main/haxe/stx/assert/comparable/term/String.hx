package stx.assert.comparable.term;


class String implements ComparableApi<StdString> extends Clazz{
  public function eq() : Eq<StdString>{
    return Eq.String();
  }
  public function lt() : Ord<StdString>{
    return Ord.String();
  }
}