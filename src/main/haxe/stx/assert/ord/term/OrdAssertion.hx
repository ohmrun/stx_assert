package stx.assert.ord.term;

class OrdAssertion<T> extends stx.assert.assertion.term.Base<T>{
  var ord : Ord<T>;
  public function new(ord,?pos){
    super(pos);
    this.ord = ord;
  }
  override public function applyII(a:T,b:T):Report<AssertFailure>{
    return ord.applyII(a,b).toBool().expect(__.fault(pos).of(PredicateFailed(definition(),a,b)));
  }
}