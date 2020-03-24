package stx.assert.pack.predicate.term;

class Transform<T,E,EE> extends Open<T,EE>{
  var transform : Err<E> -> Err<EE>;
  var delegate  : Predicate<T,E>;
  public function new(delegate,transform,?pos){
    super(pos);
    this.transform = transform;
    this.delegate  = delegate; 
  }
  override public function applyI(v:T):Report<EE>{
    return delegate.applyI(v).errata(transform);
  }
}