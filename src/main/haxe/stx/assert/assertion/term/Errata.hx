package stx.assert.assertion.term;

class Errata<T,E,EE> implements AssertionApi<T,EE> {
  
  final delegate  : AssertionApi<T,E>;
  final errata    : Err<E> -> Err<EE>;
  final pos       : Pos;
  
  public function new(delegate,errata,?pos:Pos){
    this.delegate = delegate;
    this.errata   = errata;
    this.pos      = pos;
  }
  public function applyII(lhs:T,rhs:T):Report<EE>{
    return delegate.applyII(lhs,rhs).errata(errata);
  }
  public function asAssertionApi():AssertionApi<T,EE>{
    return this;
  }
}