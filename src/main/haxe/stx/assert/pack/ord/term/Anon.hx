package stx.assert.pack.ord.term;

class Anon<T> implements OrdApi<T>{
  var delegate : T -> T -> Ordered;
  public function new(delegate){
    this.delegate = delegate;
  }
  public function applyII(lhs:T,rhs:T):Ordered{
    return delegate(lhs,rhs);
  }
}