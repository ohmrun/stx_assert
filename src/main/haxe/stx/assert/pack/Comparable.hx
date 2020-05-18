package stx.assert.pack;

import stx.assert.pack.comparable.term.Int;
import stx.assert.pack.comparable.term.String;
import stx.assert.pack.comparable.term.Couple;


interface ComparableApi<P> extends EqualableApi<P> extends OrderableApi<P>{
  
} 

@:forward abstract Comparable<T>(ComparableApi<T>) from ComparableApi<T> to ComparableApi<T>{

  public function new(self) this = self;

  @:noUsing static public function Int():Comparable<StdInt>{
    return new Int();
  }
  @:noUsing static public function String():Comparable<StdString>{
    return new String();
  }
  @:noUsing static public function Couple<L,R>(l,r):Comparable<StdCouple<L,R>>{
    return new Couple(l,r);
  }
}