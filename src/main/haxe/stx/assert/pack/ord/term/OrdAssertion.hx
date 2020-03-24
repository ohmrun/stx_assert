package stx.assert.pack.ord.term;

class OrdAssertion<T> implements AssertionApi<T>{
  var ord : Ord<T>;
  public function new(ord){
    this.ord = ord;
  }
  public function applyII(a:T,b:T):Bool{
    return ord.applyII(a,b).ok();
  }
}