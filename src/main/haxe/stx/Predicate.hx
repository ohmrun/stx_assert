package stx;


import stx.data.Predicate in TPredicate;

import stx.types.*;

import stx.Equal;
import stx.Order;

using stx.Pointwise;

@:callable abstract Predicate<T>(TPredicate<T>) from TPredicate<T> to TPredicate<T>{
  @:noUsing static public function unit<T>():Predicate<T>{
    return function(x:T){ return true; }
  }
  public function new(v:TPredicate<T>){
    this = v;
  }
  public function apply(v:T):Bool{
    return this(v);
  }
  /**
    Produces a predicate that succeeds if both succeed.
  **/
  public inline function and(p: stx.Predicate<T>): Predicate<T>{
    return Predicates.and(this,p);
  }
  /**
    Produces a predicate that succeeds if all input predicates succeed.
  **/
  public inline function andAll(ps: Iterable<Predicate<T>>): Predicate<T>{
    return Predicates.andAll(this,ps);
  }
  /**
    Produces a predicate that succeeds if one or other predicates succeed.
  **/
  public inline function or(p: Predicate<T>): Predicate<T>{
    return Predicates.or(this,p);
  }
  /**
    Produces a predicate that succeeds if one or other, but not both predicates succeed.
  **/
  public inline function xor(p: Predicate<T>): Predicate<T>{
    return Predicates.xor(this,p);
  }
  /**
    Produces a predicate that succeeds if the input predicate fails.
  **/
  public inline function not():Predicate<T>{
    return Predicates.not(this);
  }
  /**
    Produces a predicate that succeeds if any of the input predicates succeed.
  **/
  public inline function orAny(ps: Iterable<Predicate<T>>): Predicate<T> {
    return Predicates.orAny(this,ps);
  }
  /**
    Produces a Method from a Predicate.

  @:to public function toMethod():Method<T,Bool>{
    return new Method(this);
  }
  **/
}

class Predicates{
  /**
    Produces a predicate that succeeds if both succeed.
  **/
  static public function and<T>(p1: Predicate<T>, p2: Predicate<T>): Predicate<T> {
    return function(value:T) {
      return p1(value) && p2(value);
    }
  }
  /**
    Produces a predicate that succeeds if all input predicates succeed.
  **/
  static public function andAll<T>(p1: Predicate<T>, ps: Iterable<Predicate<T>>): Predicate<T> {
    return function(value:T) {
      var result = p1(value);

      for (p in ps) {
        if (!result) break;

        result = result && p(value);
      }

      return result;
    }
  }
  /**
    Produces a predicate that succeeds if one or other predicates succeed.
  **/
  static public function or<T>(p1: Predicate<T>, p2: Predicate<T>): Predicate<T> {
    return function(value:T) {
      return p1(value) || p2(value);
    }
  }
  /**
    Produces a predicate that succeeds if one or other , but not both predicates succeed.
  **/
  static public function xor<T>(p1: Predicate<T>, p2: Predicate<T>): Predicate<T> {
    return function(value:T) {
      return or(p1,p2)(value) && (!and(p1,p2)(value));
    }
  }
  /**
    Produces a predicate that succeeds if the input predicate fails.
  **/
  static public inline function not<T>(p1: Predicate<T>):Predicate<T>{
    return function(value:T){
      return !p1(value);
    }
  }
  /**
    Produces a predicate that succeeds if any of the input predicates succeeds.
  **/
  static public function orAny<T>(p1: Predicate<T>, ps: Iterable<Predicate<T>>): Predicate<T> {
    return function(value:T) {
      var result = p1(value);

      for (p in ps) {
        if (result) break;

        result = result || p(value);
      }

      return result;
    }
  }
}
