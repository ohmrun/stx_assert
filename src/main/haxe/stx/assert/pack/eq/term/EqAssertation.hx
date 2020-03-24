package stx.assert.pack.eq.term;

class EqAssertation<T> extends stx.assert.pack.assertation.term.Base<T>{
  var eq      : Eq<T>;
  var fault   : Fault;

  public function new(eq,fault,?pos){
    super(pos);
    this.eq     = eq;
    this.fault  = fault;
  }
  override public function applyII(a:T,b:T):Report<AssertFailure>{
    return eq.applyII(a,b).toBool().report(__.fault(pos).of(PredicateFailed(definition(),a,b)));
  }
}