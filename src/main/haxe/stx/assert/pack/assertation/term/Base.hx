package stx.assert.pack.assertation.term;

class Base<T> implements AssertationApi<T,AssertFailure> extends Clazz{
  var pos : Pos;
  public function new(?pos){
    super();
    this.pos = pos;
  }
  public function applyII(a:T,b:T){
    return Report.unit();
  }
  public function error(?l,?r,?pos:Pos){
    return __.fault(pos).of(PredicateFailed(definition(),l,r));
  }
}