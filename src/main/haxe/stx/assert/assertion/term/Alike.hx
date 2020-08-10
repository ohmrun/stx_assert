package stx.assert.assertion.term;

class Alike extends Base<StdEnumValue>{
  public function new(?pos){
    super(pos);
  }
  override public function applyII(a:StdEnumValue,b:StdEnumValue){
    return (StdType.enumIndex(a) == StdType.enumIndex(b)).report(error());
  }
}