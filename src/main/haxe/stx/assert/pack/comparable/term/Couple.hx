package stx.assert.pack.comparable.term;


class Couple<L,R> implements ComparableApi<StdCouple<L,R>>{
  var l : Comparable<L>;
  var r : Comparable<R>;

  public function new(l,r){
    this.l = l;
    this.r = r;
  }
  public function eq() : Eq<StdCouple<L,R>>{
    return Eq.couple(l.eq(),r.eq());
  }
  public function lt() : Ord<StdCouple<L,R>>{
    return Ord.couple(l.lt(),r.lt());
  }
}