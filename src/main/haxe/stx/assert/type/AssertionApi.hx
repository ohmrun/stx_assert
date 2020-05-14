package stx.assert.type;

interface AssertionApi<P,E>{
  public function applyII(lhs:P,rhs:P):Report<E>;
  public function asAssertionApi():AssertionApi<P,E>;
}