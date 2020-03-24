package stx;

#if (test=="stx_assert")
  import stx.assert.test.*;
#end

typedef AssertFailure           = stx.assert.pack.AssertFailure;

typedef AssertionApi<P>         = stx.assert.type.AssertionApi<P>;
typedef Assertion<P>            = stx.assert.pack.Assertion<P>;

typedef AssertationApi<P,E>     = stx.assert.type.AssertationApi<P,E>;
typedef Assertation<P,E>        = stx.assert.pack.Assertation<P,E>;

typedef ComparableApi<P>        = stx.assert.type.ComparableApi<P>;
typedef Comparable<P>           = stx.assert.pack.Comparable<P>;

typedef Equal                   = stx.assert.pack.Equal;

typedef EqApi<T>                = stx.assert.type.EqApi<T>;
typedef Eq<T>                   = stx.assert.pack.Eq<T>;
typedef EqualableApi<T>         = stx.assert.type.EqualableApi<T>;
typedef Equalable<T>            = stx.assert.pack.Equalable<T>;
typedef EqualedSum              = stx.assert.type.EqualedSum;
typedef Equaled                 = stx.assert.pack.Equaled;

typedef OrdApi<T>               = stx.assert.type.OrdApi<T>;
typedef Ord<T>                  = stx.assert.pack.Ord<T>;
typedef OrderableApi<T>         = stx.assert.type.OrderableApi<T>;
typedef Orderable<T>            = stx.assert.pack.Orderable<T>;
typedef OrderedSum              = stx.assert.type.OrderedSum;
typedef Ordered                 = stx.assert.pack.Ordered;

typedef PredicateApi<T,E>       = stx.assert.type.PredicateApi<T,E>;
typedef Predicate<T,E>          = stx.assert.pack.Predicate<T,E>;
typedef AssertError             = stx.assert.pack.AssertError;
typedef Comparative             = stx.assert.pack.Comparative;
typedef ComparativeSum          = stx.assert.type.ComparativeSum;

typedef Compare<T>              = stx.assert.pack.Compare<T>;

class Assert{
  #if (test=="stx_assert")
    static public function tests():Array<utest.Test>{
      return [
        new ComparablesTest()
      ];
    }
  #end
}
class LiftAssert{
  static public inline function that<T,E>(stx:Wildcard,?pos:Pos){
    return new stx.assert.module.That(pos);
  }
  static public function assert(__:Wildcard,?pos:Pos) return new stx.assert.Module(pos);

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