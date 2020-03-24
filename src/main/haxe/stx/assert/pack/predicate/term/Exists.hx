package stx.assert.pack.predicate.term;

class Exists<T> extends Base<T>{
  public function new(?pos){
    super(pos);
  }
  override public function applyI(v:T){
    var bool = __.option(v).map(_ -> true).defv(false);
    return bool.report(this.error());
  }
}