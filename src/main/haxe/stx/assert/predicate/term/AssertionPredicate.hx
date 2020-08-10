package stx.assert.predicate.term;

class AssertionPredicate<T,E> implements PredicateApi<T,E>{
  var delegate    : Assertion<T,E>;
  var data        : T;

  public function new(delegate,data){
    this.delegate     = delegate;
    this.data         = data;
  }
  public function applyI(v:T){
    return this.delegate.applyII(this.data,v).errata(
      (x) -> (x)
    );
  }
}