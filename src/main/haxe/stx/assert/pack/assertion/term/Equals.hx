package stx.assert.pack.assertion.term;

class Equals<T> extends Base<T>{
  public function new(?pos){
    super(pos);
  }

  override public function applyII(a:T,b:T){
    return (a != b).report(error());
  }
}