package stx.assert.pack;

import stx.assert.pack.assertion.term.*;

interface AssertionApi<P,E>{
  public function applyII(lhs:P,rhs:P):Report<E>;
  public function asAssertionApi():AssertionApi<P,E>;
}

@:forward abstract Assertion<T,E>(AssertionApi<T,E>) from AssertionApi<T,E>{
  public function crunchII(l:T,r:T){
    switch(this.applyII(l,r)){
      case Some(e) : throw e;
      default:
    }
  }
  public function ok(l:T,r:T):Bool{
    return !this.applyII(l,r).is_defined();
  }
  /**
   * Creates a Predicate from an Assertion.
   * @param l 
   * @return Predicate<T>
   */
  public function bindI(l:T):Predicate<T,E>{
    return new stx.assert.pack.predicate.term.AssertionPredicate(this,l);
  }
  @:noUsing static public function equals<T>(?pos:Pos):Assertion<T,AssertFailure>{
    return new Equals(pos);
  }
  @:noUsing static public inline function alike<E>(?pos:Pos):Assertion<StdEnumValue,AssertFailure>{
    return new Alike(pos);
  }
  @:noUsing static public function gt<T>(?pos:Pos):Assertion<T,AssertFailure>{
    return new GreaterThan(pos);
  }
  @:noUsing static public inline function gt_eq<T>(?pos:Pos):Assertion<T,AssertFailure>{
    return new GreaterThanOrEquals(pos);
  }
  @:noUsing static public inline function lt<T>(?pos:Pos):Assertion<T,AssertFailure>{
    return new LessThan(pos);
  }
  @:noUsing static public inline function lt_eq<T>(?pos:Pos):Assertion<T,AssertFailure>{
    return new LessThanOrEquals(pos);
  }
}