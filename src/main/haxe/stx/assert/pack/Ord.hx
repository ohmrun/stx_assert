package stx.assert.pack;

import stx.assert.pack.ord.Term;

@:forward abstract Ord<T>(OrdApi<T>) from OrdApi<T> to OrdApi<T>{
  public function new(self){
    this = self;
  }
  @:to public function toAssertion():Assertion<T>{
    return new stx.assert.pack.ord.term.OrdAssertion(this);
  } 
  static public var term(default,never) : Term = new Term();
}

