package stx.assert.predicate.term;

class Or<T,E> extends Open<T,E>{
  var l : Predicate<T,E>;
  var r : Predicate<T,E>;

  public function new(l,r,?pos){
    super(pos);
    this.l = l;
    this.r = r;
  }
  override public function applyI(v:T):Report<E>{
    var resI  = l.applyI(v);
    var resII = r.applyI(v);
    return if(resI.is_defined() && resII.is_defined()){
      resI.merge(resII);
    }else{
      Report.unit();
    }
  }
}