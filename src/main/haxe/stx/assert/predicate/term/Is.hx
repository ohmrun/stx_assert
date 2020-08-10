package stx.assert.predicate.term;


class Is<T> extends Base<T>{
  var type  : Class<T>;
  public function new(type,?pos){
    super(pos);
    this.type   = type;
  }
  override public function applyI<E>(v:T){
    var bool  = std.Std.isOfType(v,type);
    var err   = __.fault().of(PredicateFailed(definition(),v));
    return bool.report(err);
  }
}