package stx.assert.pack;

import stx.assert.pack.predicate.term.*;

import stx.assert.pack.predicate.Constructor;

@:forward abstract Predicate<T,E>(PredicateApi<T,E>) from PredicateApi<T,E> to PredicateApi<T,E>{
  static public var _(default,null) = PredicateLift;

  public function new(v:PredicateApi<T,E>) this = v;

  @:noUsing static public function unit<T,E>():Predicate<T,E> return new Always();
  
  
  /** Produces a predicate that succeeds if both succeed. **/
  public inline function and(p: Predicate<T,E>): Predicate<T,E>                   return _.and(p,this);
  /**Produces a predicate that succeeds if all input predicates succeed.**/
  public inline function ands(ps: Iterable<Predicate<T,E>>): Predicate<T,E>       return _.ands(ps,this);
  /**Produces a predicate that succeeds if one or other predicates succeed.**/
  public inline function or(p: Predicate<T,E>): Predicate<T,E>                    return _.or(p,this);
  /**Produces a predicate that succeeds if one or other, but not both predicates succeed.**/
  public inline function xor(p: Predicate<T,E>): Predicate<T,E>                   return _.xor(p,this);
  /**Produces a predicate that succeeds if the input predicate fails.**/
  public inline function not():Predicate<T,E>                                     return _.not(this);
  /**Produces a predicate that succeeds if any of the input predicates succeed.**/
  public inline function ors(ps: Iterable<Predicate<T,E>>): Predicate<T,E>        return _.ors(ps,this);
  

  public inline function ordef(l:T,r:T):T{
    return this.applyI(l).is_defined() ? r : l;
  }
  public inline function fudge(v:T):T{
    return switch(this.applyI(v)){
      case Some(v)  : throw v;
      case None     : v;
    }
  }
  public inline function bind(v){
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
  public function errata<EE>(fn:Err<E>->Err<EE>):Predicate<T,EE>{
    return _()._.errata(fn,this);
  }
}
class PredicateLift{
  /**
   * Produces a predicate that succeeds if all input predicates succeed.
  **/
  static public function ands<T,E>(p1: Predicate<T,E>,ps: Iterable<Predicate<T,E>>): Predicate<T,E> {
    return ps.fold(
      (next,memo) -> new And(memo,next),
      p1
    );
  }
  /**
   * Produces a predicate that succeeds if any of the input predicates succeeds.
  **/
  static public function ors<T,E>(p1: Predicate<T,E>,ps: Iterable<Predicate<T,E>>): Predicate<T,E > {
    return ps.fold(
      (next,memo) -> new Or(memo,next),
      p1
    );
  }
}