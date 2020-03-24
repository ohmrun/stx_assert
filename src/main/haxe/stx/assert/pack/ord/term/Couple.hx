package stx.assert.pack.ord.term;

class Couple<L,R> implements OrdApi<StdCouple<L,R>>{
  var l : Ord<L>;
  var r : Ord<R>;

  public function new(l,r){
    this.l = l;
    this.r = r;
  }
  public function applyII(a:StdCouple<L,R>,b:StdCouple<L,R>):Ordered{
    return a.decouple((l0,r0) -> b.decouple((l1,r1)-> l.applyII(l0,l1) || r.applyII(r0,r1)));
  }
}