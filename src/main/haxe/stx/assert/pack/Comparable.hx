package stx.assert.pack;

import stx.assert.pack.comparable.term.Int;
import stx.assert.pack.comparable.term.String;
import stx.assert.pack.comparable.term.Couple;


@:forward abstract Comparable<T>(ComparableApi<T>) from ComparableApi<T> to ComparableApi<T>{

  public function new(self) this = self;

  @:noUsing static public function int():Comparable<StdInt>{
    return new Int();
  }
  @:noUsing static public function string():Comparable<StdString>{
    return new String();
  }
  @:noUsing static public function couple<L,R>(l,r):Comparable<StdCouple<L,R>>{
    return new Couple(l,r);
  }
}