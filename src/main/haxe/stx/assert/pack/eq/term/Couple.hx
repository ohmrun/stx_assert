package stx.assert.pack.eq.term;

class Couple<L,R> implements EqApi<stx.core.pack.Couple<L,R>>{
  var l : Eq<L>;
  var r : Eq<R>;

  public function new(l,r){
    this.l = l;
    this.r = r;
  }

  public function applyII(a:StdCouple<L,R>,b:StdCouple<L,R>):Equaled{
    return a.decouple((l0,r0) -> b.decouple((l1,r1) -> l.applyII(l0,l1) && r.applyII(r0,r1)));
  }
}