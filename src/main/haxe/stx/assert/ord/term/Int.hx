package stx.assert.ord.term;

class Int implements OrdApi<StdInt> extends Clazz{
  public function comply(a:StdInt,b:StdInt):Ordered{
    return a < b ? LessThan : NotLessThan;
  }
}