package stx.assert.predicate.term;

class Open<T,E> implements PredicateApi<T,E>{
  @:isVar var pos(get,null) : Pos;
  function get_pos(){
    return this.pos;
  }
  public function new(?pos){
    this.pos = pos;
  }
  public function apply(v:T):Report<E>{
    return Report.unit();
  }
  public function error():Rejection<E>{
    return __.fault(pos).explain(_ -> _.e_undefined());
  }
}