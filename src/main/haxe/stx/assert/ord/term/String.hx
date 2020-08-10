package stx.assert.ord.term;

class String implements OrdApi<StdString> extends Clazz{
  public function applyII(a:StdString,b:StdString):Ordered{
    return a < b ? LessThan : NotLessThan;
  }
}