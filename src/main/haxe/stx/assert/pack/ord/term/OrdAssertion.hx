package stx.assert.pack.ord.term;

class OrdAssertion<T> extends stx.assert.pack.assertion.term.Base<T>{
  var ord : Ord<T>;
  public function new(ord,?pos){
    super(pos);
    this.ord = ord;
  }
  override public function applyII(a:T,b:T):Report<AssertFailure>{
    return ord.applyII(a,b).toBool().report(__.fault(pos).of(PredicateFailed(definition(),a,b)));
  }
}