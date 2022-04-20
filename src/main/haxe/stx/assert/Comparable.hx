package stx.assert;

import stx.assert.comparable.term.Primitive;
import stx.assert.comparable.term.Int;
import stx.assert.comparable.term.String;
import stx.assert.comparable.term.Couple;


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
  @:noUsing static public function Primitive():Comparable<stx.nano.Primitive>{
    return new Primitive();
  }
  @:noUsing static public function Anon<T>(eq:Eq<T>,lt:Ord<T>):Comparable<T>{
    return new stx.assert.comparable.term.Anon(eq,lt);
  }
  @:noUsing static public function Cluster<T>(inner:Comparable<T>):Comparable<stx.Cluster<T>>{
    return new stx.assert.comparable.term.Cluster(inner);
  }
}