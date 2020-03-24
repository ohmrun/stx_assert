package stx.assert.pack.predicate.term;

class Void<T> extends Base<T>{

  public function new(?pos){
    super(pos);
  }
  override public function applyI(v:T){
    return (v == null).report(error());
  }
}