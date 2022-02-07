package stx.assert.ord.term;

class Int64 implements OrdApi<haxe.Int64> extends Clazz{
  public function comply(a:haxe.Int64,b:haxe.Int64):Ordered{
    return a < b ? LessThan : NotLessThan;
  }
}