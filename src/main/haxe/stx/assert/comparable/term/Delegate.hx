package stx.assert.comparable.term;

class Delegate<T> implements ComparableApi<T>{
  public var inner     : Comparable<T>;
  public function new(?inner){
    this.inner = inner;
  }
  public function eq(){
    return this.inner.eq();
  }
  public function lt(){
    return this.inner.lt();
  }
}