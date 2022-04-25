package stx.assert.eq.term;

import stx.nano.Ident in IdentT;

class Ident extends EqCls<IdentT>{
  public function new(){}
  public function comply(thiz:IdentT,that:IdentT){
    var eq = Eq.String().comply(thiz.name,that.name);
    if(eq.is_ok()){
      eq = Eq.NullOr(Eq.Cluster(Eq.String())).comply(thiz.pack,that.pack);
    }
    return eq;
  }
}