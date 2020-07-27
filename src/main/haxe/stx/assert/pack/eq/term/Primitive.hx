package stx.assert.pack.eq.term;

import stx.core.pack.Primitive in PrimitiveT;

class Primitive implements EqApi<PrimitiveT> extends Clazz{
  public function applyII(lhs:PrimitiveT,rhs:PrimitiveT):Equaled{
    return switch([lhs,rhs]){
      case [PNull,PNull]                 : AreEqual;
      case [PBool(lhs),PBool(rhs)]       : Eq.Bool().applyII(lhs,rhs);
      case [PInt(lhs),PInt(rhs)]         : Eq.Int().applyII(lhs,rhs);
      case [PFloat(lhs),PFloat(rhs)]     : Eq.Float().applyII(lhs,rhs);
      case [PString(lhs),PString(rhs)]   : Eq.String().applyII(lhs,rhs);
      default                            : StdType.enumIndex(lhs) == StdType.enumIndex(rhs) ? AreEqual : NotEqual;
    }
  }
}