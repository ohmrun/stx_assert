package stx.assert.ord.term;

import stx.nano.Primitive in PrimitiveT;

class Primitive implements OrdApi<PrimitiveT> extends Clazz{
  public function comply(lhs:PrimitiveT,rhs:PrimitiveT):Ordered{
    return switch([lhs,rhs]){
      case [PNull,PNull]                 : NotLessThan;
      case [PBool(lhs),PBool(rhs)]       : Ord.Bool().comply(lhs,rhs);
      case [PInt(lhs),PInt(rhs)]         : Ord.Int().comply(lhs,rhs);
      case [PFloat(lhs),PFloat(rhs)]     : Ord.Float().comply(lhs,rhs);
      case [PString(lhs),PString(rhs)]   : Ord.String().comply(lhs,rhs);
      default                            : StdType.enumIndex(lhs) < StdType.enumIndex(rhs) ? LessThan : NotLessThan;
    }
  }
}
