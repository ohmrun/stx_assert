package stx.assert.pack;

import stx.assert.pack.ord.term.*;
import stx.assert.pack.ord.term.Couple;
import stx.assert.pack.ord.term.String;
import stx.assert.pack.ord.term.Int;
import stx.assert.pack.ord.term.Anon;

interface OrdApi<T>{
  public function applyII(lhs:T,rhs:T):Ordered;
}


@:forward abstract Ord<T>(OrdApi<T>) from OrdApi<T> to OrdApi<T>{
  public function new(self){
    this = self;
  }
  @:to public function toAssertion():Assertion<T,AssertFailure>{
    return new OrdAssertion(this).asAssertionApi();
  } 
  @:noUsing static public function Int():Ord<StdInt>{
    return new Int();
  }
  @:noUsing static public function String():Ord<StdString>{
    return new String();
  }
  @:noUsing static public function Couple<L,R>(l,r):Ord<stx.core.pack.Couple<L,R>>{
    return new Couple(l,r);
  }
  @:noUsing static public function Anon<T>(fn:T->T->Ordered):Ord<T>{
    return new Anon(fn);
  }
}