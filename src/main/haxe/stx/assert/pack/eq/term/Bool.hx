package stx.assert.pack.eq.term;

class Bool implements EqApi<StdBool> extends Clazz{
  public function applyII(a:StdBool,b:StdBool):Equaled{
    return a == b ? AreEqual : NotEqual;
  }
}