package stx.assert.predicate.term;

class And<T,E> extends Open<T,E>{
  var l : Predicate<T,E>;
  var r : Predicate<T,E>;

  public function new(l,r,?pos){
    super(pos);
    this.l = l;
    this.r = r;
  }
  override public function applyI(v:T):Report<E>{
    var lr = l.applyI(v);
    var rr = new Report(None);

    if(!lr.is_defined()){
       rr = r.applyI(v);
    }

    return lr.merge(rr);
  }
}