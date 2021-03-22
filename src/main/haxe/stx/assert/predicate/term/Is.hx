package stx.assert.predicate.term;


class Is extends Base<Dynamic>{
  var type  : Class<Dynamic>;
  public function new(type:Class<Dynamic>,?pos){
    super(pos);
    this.type   = type;
  }
  override public function applyI(v:Dynamic){
    var bool  = std.Std.isOfType(v,type);
    var err   = __.fault().of(PredicateFailed(definition(),v));
    return bool.expect(err);
  }
}