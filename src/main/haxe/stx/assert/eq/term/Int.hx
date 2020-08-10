package stx.assert.eq.term;


class Int implements EqApi<StdInt> extends Clazz{
  public function applyII(a:StdInt,b:StdInt):Equaled{
    return a == b ? AreEqual : NotEqual;
  }
}