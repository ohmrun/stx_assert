package stx.assert.pack.predicate.term;

class Never<T,E> extends Open<T,E>{

  public function new(?pos){
    super(pos);
  }
  override public function applyI(v:T):Report<E>{
    return Report.pure(error());
  }
}