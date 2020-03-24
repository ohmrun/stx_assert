package stx.assert.pack;

import stx.assert.pack.eq.Term;

import stx.assert.pack.eq.term.EqAssertation;
import stx.assert.pack.eq.term.EqAssertion;

@:forward abstract Eq<T>(EqApi<T>) from EqApi<T> to EqApi<T>{
  public function new(self){
    this = self;
  }
  @:to public function toAssertion():Assertion<T>{
    return new EqAssertion(this,__.fault());
  }
  public function toAssertation(err:Err<AssertFailure>):Assertation<T,AssertFailure>{
    return new EqAssertation(this,__.fault());
  } 
  static public var term(default,never) : Term = new Term();
}