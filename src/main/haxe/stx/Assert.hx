package stx;

typedef AssertFailure           = stx.fail.AssertFailure;

typedef AssertionApi<P,E>       = stx.assert.Assertion.AssertionApi<P,E>;
typedef Assertion<P,E>          = stx.assert.Assertion<P,E>;

typedef ComparableApi<P>        = stx.assert.Comparable.ComparableApi<P>;
typedef Comparable<P>           = stx.assert.Comparable<P>;

typedef Equal                   = stx.assert.Equal;

typedef EqCls<T>                = stx.assert.Eq.EqCls<T>;
typedef EqApi<T>                = stx.assert.Eq.EqApi<T>;
typedef Eq<T>                   = stx.assert.Eq<T>;

typedef EqualableApi<T>         = stx.assert.Equalable.EqualableApi<T>;
typedef Equalable<T>            = stx.assert.Equalable<T>;

typedef EqualedSum              = stx.assert.Equaled.EqualedSum;
typedef Equaled                 = stx.assert.Equaled;

typedef OrdCls<T>               = stx.assert.Ord.OrdCls<T>;
typedef OrdApi<T>               = stx.assert.Ord.OrdApi<T>;
typedef Ord<T>                  = stx.assert.Ord<T>;

typedef OrderableApi<T>         = stx.assert.Orderable.OrderableApi<T>;
typedef Orderable<T>            = stx.assert.Orderable<T>;

typedef OrderedSum              = stx.assert.Ordered.OrderedSum;
typedef Ordered                 = stx.assert.Ordered;

typedef PredicateApi<T,E>       = stx.assert.Predicate.PredicateApi<T,E>;
typedef Predicate<T,E>          = stx.assert.Predicate<T,E>;

//typedef AssertError             = stx.assert.AssertError;

typedef Comparative             = stx.assert.Comparative;
typedef ComparativeSum          = stx.assert.Comparative.ComparativeSum;

typedef Compare<T>              = stx.assert.Compare<T>;

class LiftAssert{
  static public inline function that<T,E>(stx:Wildcard,?pos:Pos){
    return new stx.assert.Module(pos);
  }
  static public function assert(__:Wildcard,?pos:Pos) return new stx.assert.module.Crunch(pos);

  static public function expect<E>(b:Bool,err:Refuse<E>){
    return b ? Report.unit() : Report.pure(err);
  }
}

typedef PartialOrderedDef             = stx.assert.PartialOrder.PartialOrderedDef;
typedef PartialOrdered                = stx.assert.PartialOrder.PartialOrdered;
typedef PartialOrdApi<T>              = stx.assert.PartialOrder.PartialOrdApi<T>;
typedef PartialOrderableApi<T>        = stx.assert.PartialOrder.PartialOrderableApi<T>;
typedef PartialComparableApi<T>       = stx.assert.PartialOrder.PartialComparableApi<T>;
