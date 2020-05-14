package stx.assert.type;

interface EqApi<T>{
  public function applyII(lhs:T,rhs:T):Equaled;
}