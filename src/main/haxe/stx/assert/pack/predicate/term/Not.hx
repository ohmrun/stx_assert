package stx.assert.pack.predicate.term;

class Not<T,E> extends Open<T,E>{
  var predicate : Predicate<T,E>;
  
  public function new(predicate,?pos){
    super(pos);
    this.predicate = predicate;
  }
  override public function applyI(v:T){
    var bool = predicate.applyI(v).fold(
      (c) -> true,
      () -> false
    );
    return bool.report(error());
  }
}