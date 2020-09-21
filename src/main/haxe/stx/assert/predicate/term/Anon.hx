package stx.assert.predicate.term;

class Anon<P,E> implements PredicateApi<P,E>{
  public var delegate(default,null): P -> Report<E>;
  public function new(delegate){
    this.delegate = delegate;
  }
  public function applyI(p:P):Report<E>{
    return delegate(p);
  }
}