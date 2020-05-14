package stx.assert.type;

import stx.assert.pack.Ordered in OrderedA;

interface OrdApi<T>{
  public function applyII(lhs:T,rhs:T):Ordered;
}
