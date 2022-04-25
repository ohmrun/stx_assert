package stx.assert.eq.term;

import stx.nano.Ident in IdentT;

class Ident extends EqCls<IdentT>{
  public function comply(thiz:IdentT,that:IdentT){
    var eq = Eq.String(thiz,that);
    if(eq){
      eq = Eq.NullOr(Eq.Cluster(Eq.String())).comply(thiz.pack,that.pack);
    }
    return eq;
  }
}