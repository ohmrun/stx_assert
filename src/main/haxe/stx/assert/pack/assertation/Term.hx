package stx.assert.pack.assertation;

import stx.assert.pack.assertation.term.*;

class Term extends Clazz{
  public function equals<T>(pos:Position):Assertation<T,AssertFailure>{
    return new Equals(pos);
  }
  public inline function alike<E>(pos:Position):Assertation<StdEnumValue,AssertFailure>{
    return new Alike(pos);
  }
  public function gt<T>(pos:Position):Assertation<T,AssertFailure>{
    return new GreaterThan(pos);
  }
  public inline function gt_eq<T>(pos:Position):Assertation<T,AssertFailure>{
    return new GreaterThanOrEquals(pos);
  }
  public inline function lt<T>(pos:Position):Assertation<T,AssertFailure>{
    return new LessThan(pos);
  }
  public inline function lt_eq<T>(pos:Position):Assertation<T,AssertFailure>{
    return new LessThanOrEquals(pos);
  }
}