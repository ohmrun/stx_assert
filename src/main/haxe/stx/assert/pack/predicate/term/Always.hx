package stx.assert.pack.predicate.term;

class Always<T,E> extends Open<T,E>{
  override public function applyI(v:T){
    return None;
  }
}