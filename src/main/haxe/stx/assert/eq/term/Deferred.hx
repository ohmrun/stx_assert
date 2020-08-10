package stx.assert.eq.term;

class Deferred<T> implements EqApi<T>{
  var eq      : Eq<T>;

  public function new(){};

  public function applyII(a:T,b:T){
    if(eq == null){
      if(a == null){
        eq = Equal.getEqualFor(a);
      }else{
        eq = Equal.getEqualFor(b);
      }
    }
    return eq.applyII(a,b);
  }
}