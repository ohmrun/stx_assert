package stx.assert.pack.predicate.term;

class AssertationPredicate<T,E> implements PredicateApi<T,E>{
  var assertation : Assertation<T,E>;
  var data        : T;

  public function new(assertation,data){
    this.assertation  = assertation;
    this.data         = data;
  }
  public function applyI(v:T){
    return this.assertation.applyII(this.data,v).errata(
      (x) -> (x)
    );
  }
}