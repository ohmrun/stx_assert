package stx.assert.ord.term;

class EnumValue implements OrdApi<StdEnumValue> extends Clazz{
  public function comply(lhs:StdEnumValue,rhs:StdEnumValue){
    final l = lhs.lift();
    final r = rhs.lift();
    return l.index() < r.index() ? LessThan : NotLessThan; 
  }
}