package stx.assert.ord.term;

class Int implements OrdApi<StdInt> extends Clazz{
  public function applyII(a:StdInt,b:StdInt):Ordered{
    return a < b ? LessThan : NotLessThan;
  }
}