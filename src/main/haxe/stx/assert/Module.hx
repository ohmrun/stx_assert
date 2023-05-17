package stx.assert;

class Module extends Clazz{
  var pos   : Pos;
  public function new(pos){
    super();
    this.pos = pos;
  }
  public function that(){
    return new stx.assert.module.Effect(pos);
  }
  public function expect(){
    return new stx.assert.module.Expect(pos);
  }
}