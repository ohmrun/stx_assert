package stx.assert.pack;

import stx.assert.pack.ord.term.*;
import stx.assert.pack.ord.term.Couple;
import stx.assert.pack.ord.term.String;
import stx.assert.pack.ord.term.Int;

@:forward abstract Ord<T>(OrdApi<T>) from OrdApi<T> to OrdApi<T>{
  public function new(self){
    this = self;
  }
  @:to public function toAssertion():Assertion<T,AssertFailure>{
    return new OrdAssertion(this).asAssertionApi();
  } 
  @:noUsing static public function int():Ord<StdInt>{
    return new Int();
  }
  @:noUsing static public function string():Ord<StdString>{
    return new String();
  }
  @:noUsing static public function couple<L,R>(l,r):Ord<stx.core.pack.Couple<L,R>>{
    return new Couple(l,r);
  }
}

