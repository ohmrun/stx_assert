package stx.assert.eq.term;

import stx.nano.Primitive in PrimitiveT;

class Primitive implements EqApi<PrimitiveT> extends Clazz{
  public function comply(lhs:PrimitiveT,rhs:PrimitiveT):Equaled{
    return switch([lhs,rhs]){
      case [PNull,PNull]                 : AreEqual;
      case [PBool(lhs),PBool(rhs)]       : Eq.Bool().comply(lhs,rhs);
      case [PInt(lhs),PInt(rhs)]         : Eq.Int().comply(lhs,rhs);
      case [PFloat(lhs),PFloat(rhs)]     : Eq.Float().comply(lhs,rhs);
      case [PString(lhs),PString(rhs)]   : Eq.String().comply(lhs,rhs);
      default                            : StdType.enumIndex(lhs) == StdType.enumIndex(rhs) ? AreEqual : NotEqual;
    }
  }
}