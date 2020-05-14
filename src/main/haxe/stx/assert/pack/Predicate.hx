package stx.assert.pack;

import stx.assert.pack.predicate.term.*;

@:using(stx.assert.pack.Predicate.PredicateLift)
@:forward abstract Predicate<T,E>(PredicateApi<T,E>) from PredicateApi<T,E> to PredicateApi<T,E>{
  static public var _(default,null) = PredicateLift;

  public function new(v:PredicateApi<T,E>) this = v;

  @:noUsing static public function unit<T,E>():Predicate<T,E> return new Always();
  @:noUsing static public function always<T>(?pos:Pos):Predicate<T,AssertFailure>{
    return new Always();
  }
  @:noUsing static public function never<T,E>(?pos:Pos):Predicate<T,E>{
    return new Never(pos);
  }
  @:noUsing static public inline function is<A>(?pos:Pos,clazz:Class<A>):Predicate<A,AssertFailure>{
    return new Is(clazz,pos);
  }
  @:noUsing static public inline function throws<E>(?pos:Pos):Predicate<Block,AssertFailure>{
    return new Throws(pos);
  }
  @:noUsing static public inline function void<T>(?pos:Pos):Predicate<T,AssertFailure>{
    return new stx.assert.pack.predicate.term.Void(pos);
  }
  @:noUsing static public inline function exists<T>(?pos:Pos):Predicate<T,AssertFailure>{
    return new Exists(pos);
  }
  @:noUsing static public inline function matches<E>(?pos:Pos,reg:String,opt:String):Predicate<String,AssertFailure>{
    return new Matches(pos,reg,opt);
  }  

  public inline function ordef(l:T,r:T):T{
    return this.applyI(l).is_defined() ? r : l;
  }
  public inline function fudge(v:T):T{
    return switch(this.applyI(v)){
      case Some(v)  : throw v;
      case None     : v;
    }
  }
  public inline function bindI(v){
    return this.applyI.bind(v);
  }
  public function check():T->Bool{
    return (x) -> this.applyI(x) == None;
  }
  inline public function crunch(v:T){
    switch(this.applyI(v)){
      case Some(e) : throw e;
      default:
    }
  }
}
class PredicateLift{
  /**
   * Produces a predicate that succeeds if all input predicates succeed.
  **/
  static public function ands<T,E>(self: Predicate<T,E>,rest: Iterable<Predicate<T,E>>): Predicate<T,E> {
    return rest.fold(
      (next,memo) -> new And(memo,next),
      self
    );
  }
  /**
   * Produces a predicate that succeeds if any of the input predicates succeeds.
  **/
  static public function ors<T,E>(self: Predicate<T,E>,rest: Iterable<Predicate<T,E>>): Predicate<T,E > {
    return rest.fold(
      (next,memo) -> new Or(memo,next),
      self
    );
  }
  /**
    Produces a predicate that succeeds if both succeed.
  **/
  static public function and<T,E>(self: Predicate<T,E>,that: Predicate<T,E>): Predicate<T,E> {
    return new And(self,that);
  }

  /**
    Produces a predicate that succeeds if one or other predicates succeed.
  **/
  static public function or<T,E>(self: Predicate<T,E>,that: Predicate<T,E>): Predicate<T,E> {
    return new Or(self,that);
  }
  /**
    Produces a predicate that succeeds if one or other , but not both predicates succeed.
  **/
  static public function xor<T,E>(self: Predicate<T,E>, that: Predicate<T,E>): Predicate<T,E> {
    return new XOr(self,that);
  }
  /**
    Produces a predicate that succeeds if the input predicate fails.
  **/
  static public function not<T,E>(self: Predicate<T,E>):Predicate<T,E>{
    return new Not(self);
  }

  static public function errata<T,E,EE>(self: Predicate<T,E>,fn:Err<E>->Err<EE>):Predicate<T,EE>{
    return new Transform(self,fn);
  }
}