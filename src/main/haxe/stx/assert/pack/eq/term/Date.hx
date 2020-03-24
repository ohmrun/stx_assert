package stx.assert.pack.eq.term;


class Date implements EqApi<StdDate> extends Clazz{
  public function applyII(a:StdDate,b:StdDate):Equaled{
    return a.getTime() == b.getTime() ? AreEqual : NotEqual;
  }
}