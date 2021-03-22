package stx.assert.assertion.term;

class GreaterThanOrEquals<T> extends Base<T>{
  public function new(?pos){
    super(pos);
  }
  override public function applyII(a:T,b:T){
    var l : Dynamic = a;
    var r : Dynamic = b;

    return (l >= r).expect(error());
  }
}
