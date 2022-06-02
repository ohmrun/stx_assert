package stx.assert.eq.term;

import stx.nano.Knuckle as TKnuckle;

class Knuckle extends EqCls<TKnuckle>{
  public function new(){}
  public function comply(lhs:TKnuckle,rhs:TKnuckle){
    return switch([lhs,rhs]){
      case [Ordinal(vI),Ordinal(vII)]          : vI == vII ? AreEqual : NotEqual;
      case [Nominal(vI),Nominal(vII)]          : Eq.String().comply(vI,vII);
      case [x,y]                               : Eq.EnumValueIndex().comply(x,y);
    }
  }
}
