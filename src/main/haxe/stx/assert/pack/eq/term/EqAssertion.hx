package stx.assert.pack.eq.term;

class EqAssertion<T> extends stx.assert.pack.assertion.term.Base<T>{
  var eq      : Eq<T>;

  public function new(eq:Eq<T>,?pos:Pos){
    super(pos);
    this.eq     = eq;
  }
  override public function applyII(a:T,b:T):Report<AssertFailure>{
    return eq.applyII(a,b).toBool().report(__.fault(pos).of(PredicateFailed(definition(),a,b)));
  }
}