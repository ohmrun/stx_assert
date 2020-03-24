package stx.assert.pack.eq.term;

class Float implements EqApi<StdFloat> extends Clazz{
  public function applyII(a:StdFloat,b:StdFloat):Equaled{
    return a == b ? AreEqual : NotEqual;
  }
}