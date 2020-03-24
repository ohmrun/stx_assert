package stx.assert.pack.assertation.term;

class LessThan<T> extends Base<T>{
  public function new(?pos){
    super(pos);
  }
  override public function applyII(a:T,b:T){
    var l : Dynamic = a;
    var r : Dynamic = b;
    return (l<r).report(error());
  }
}