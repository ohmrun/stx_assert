package stx.assert.pack.predicate.term;

class Base<T> implements PredicateApi<T,AssertFailure> extends Clazz{
  var pos : Pos;
  public function new(?pos){
    super();
    this.pos = pos;
  }
  public function applyI(v:T):Report<AssertFailure>{
    return None;
  }
  public function error(?l,?r,?pos:Pos){
    return __.fault(__.option(pos).defv(this.pos)).of(PredicateFailed(this.definition(),l,r));
  }
}