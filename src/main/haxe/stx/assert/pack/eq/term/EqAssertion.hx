package stx.assert.pack.eq.term;

class EqAssertion<T> implements AssertionApi<T>{
  var eq      : Eq<T>;
  var fault   : Fault;

  public function new(eq,fault){
    this.eq     = eq;
    this.fault  = fault;
  }
  public function applyII(a:T,b:T):Bool{
    return eq.applyII(a,b).toBool();
  }
}