package stx;


typedef AssertFailure           = stx.assert.pack.AssertFailure;

typedef AssertionApi<P,E>       = stx.assert.pack.Assertion.AssertionApi<P,E>;
typedef Assertion<P,E>          = stx.assert.pack.Assertion<P,E>;

typedef ComparableApi<P>        = stx.assert.pack.Comparable.ComparableApi<P>;
typedef Comparable<P>           = stx.assert.pack.Comparable<P>;

typedef Equal                   = stx.assert.pack.Equal;

typedef EqApi<T>                = stx.assert.pack.Eq.EqApi<T>;
typedef Eq<T>                   = stx.assert.pack.Eq<T>;

typedef EqualableApi<T>         = stx.assert.pack.Equalable.EqualableApi<T>;
typedef Equalable<T>            = stx.assert.pack.Equalable<T>;

typedef EqualedSum              = stx.assert.pack.Equaled.EqualedSum;
typedef Equaled                 = stx.assert.pack.Equaled;

typedef OrdApi<T>               = stx.assert.pack.Ord.OrdApi<T>;
typedef Ord<T>                  = stx.assert.pack.Ord<T>;

typedef OrderableApi<T>         = stx.assert.pack.Orderable.OrderableApi<T>;
typedef Orderable<T>            = stx.assert.pack.Orderable<T>;

typedef OrderedSum              = stx.assert.pack.Ordered.OrderedSum;
typedef Ordered                 = stx.assert.pack.Ordered;

typedef PredicateApi<T,E>       = stx.assert.pack.Predicate.PredicateApi<T,E>;
typedef Predicate<T,E>          = stx.assert.pack.Predicate<T,E>;

typedef AssertError             = stx.assert.pack.AssertError;

typedef Comparative             = stx.assert.pack.Comparative;
typedef ComparativeSum          = stx.assert.pack.Comparative.ComparativeSum;

typedef Compare<T>              = stx.assert.pack.Compare<T>;

class Assert{

}
class LiftAssert{
  static public inline function that<T,E>(stx:Wildcard,?pos:Pos){
    return new stx.assert.Module(pos);
  }
  static public function assert(__:Wildcard,?pos:Pos) return new stx.assert.module.Crunch(pos);

  static public function report<E>(b:Bool,err:Err<E>){
    return b ? Report.unit() : Report.pure(err);
  }
}
class LiftErr{
  // static public function alike<E>(err:Err<E>,e0:E):Bool{
  //   return err.data.map(
  //     (stx) -> switch(stx){
  //       case ERR(e1)  : __.that().alike().ok(e0,e1);
  //       default       : false;
  //     }
  //   ).defv(false);
  // }
}