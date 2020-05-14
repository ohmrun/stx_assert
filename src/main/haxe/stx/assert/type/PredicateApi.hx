package stx.assert.type;

interface PredicateApi<P,E>{
  public function applyI(p:P):Report<E>;
}
