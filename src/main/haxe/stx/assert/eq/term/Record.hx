package stx.assert.eq.term;

import stx.nano.Record in RecordT;

class Record<T> extends EqCls<RecordT<T>>{
  public var inner(default,null):Eq<T>;
  public function new(inner){
    this.inner = inner;
  }
  public function comply(a:RecordT<T>,b:RecordT<T>):Equaled{
    return Eq.Cluster(
      Eq.Anon(
        (lhs:Field<Thunk<T>>,rhs:Field<Thunk<T>>) -> Eq.String().comply(lhs.fst(),rhs.fst()) && inner.comply(lhs.snd()(),rhs.snd()())
      )
    ).comply(a.prj(),b.prj());
  }
}
