package stx.assert.predicate.term;


class Throws extends Base<Block>{
  public function new(?pos){
    super(pos);
  }
  override public function applyI(block:Block){
    try{
      block();
    }catch(e:Dynamic){
      return Report.unit();
    }
    return Report.pure(error());
  }
}