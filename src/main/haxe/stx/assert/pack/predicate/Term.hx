package stx.assert.pack.predicate;

import stx.assert.pack.predicate.term.*;

class Term extends Clazz{
  static public var ZERO(default,never) = new Term();

  public function always<T>(?pos:Pos):Predicate<T,AssertFailure>{
    return new Always();
  }
  public function never<T,E>(?pos:Pos):Predicate<T,E>{
    return new Never(pos);
  }
  public inline function is<A>(?pos:Pos,clazz:Class<A>):Predicate<A,AssertFailure>{
    return new Is(clazz,pos);
  }
  public inline function throws<E>(?pos:Pos):Predicate<Block,AssertFailure>{
    return new Throws(pos);
  }
  public inline function void<T>(?pos:Pos):Predicate<T,AssertFailure>{
    return new stx.assert.pack.predicate.term.Void(pos);
  }
  public inline function exists<T>(?pos:Pos):Predicate<T,AssertFailure>{
    return new Exists(pos);
  }
  public inline function matches<E>(?pos:Pos,reg:String,opt:String):Predicate<String,AssertFailure>{
    return new Matches(pos,reg,opt);
  }
}