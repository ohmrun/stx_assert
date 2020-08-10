package stx.assert.ord.term;

import stx.nano.Primitive in PrimitiveT;

class Primitive implements OrdApi<PrimitiveT> extends Clazz{
  public function applyII(lhs:PrimitiveT,rhs:PrimitiveT):Ordered{
    return switch([lhs,rhs]){
      case [PNull,PNull]                 : NotLessThan;
      case [PBool(lhs),PBool(rhs)]       : Ord.Bool().applyII(lhs,rhs);
      case [PInt(lhs),PInt(rhs)]         : Ord.Int().applyII(lhs,rhs);
      case [PFloat(lhs),PFloat(rhs)]     : Ord.Float().applyII(lhs,rhs);
      case [PString(lhs),PString(rhs)]   : Ord.String().applyII(lhs,rhs);
      default                            : StdType.enumIndex(lhs) < StdType.enumIndex(rhs) ? LessThan : NotLessThan;
    }
  }
}
