package stx.assert.ord.term;

class Float implements OrdApi<StdFloat> extends Clazz{
  public function comply(a:StdFloat,b:StdFloat):Ordered{
    return a < b ? LessThan : NotLessThan;
  }
}