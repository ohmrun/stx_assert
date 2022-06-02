package stx.assert;

import stx.assert.eq.term.Primitive; 
import stx.assert.eq.term.Noise; 
import stx.assert.eq.term.Anon;
import stx.assert.eq.term.*;
import stx.assert.eq.term.Couple;
import stx.assert.eq.term.Int;
import stx.assert.eq.term.Int64;
import stx.assert.eq.term.String;
import stx.assert.eq.term.Cluster;
import stx.assert.eq.term.EnumValueIndex;
import stx.assert.eq.term.NullOr;

interface EqApi<T>{
  public function comply(lhs:T,rhs:T):Equaled;
}
abstract class EqCls<T> implements EqApi<T>{
  abstract public function comply(lhs:T,rhs:T):Equaled;
}
@:forward abstract Eq<T>(EqApi<T>) from EqApi<T> to EqApi<T>{
  public function new(self){
    this = self;
  }
  public function toAssertion(?pos:Pos):Assertion<T,AssertFailure>{
    return new EqAssertion(this,pos);
  } 
  @:noUsing static public function Int():Eq<StdInt>{
    return new Int();
  }
  @:noUsing static public function Int64():Eq<haxe.Int64>{
    return new Int64();
  }
  @:noUsing static public function String():Eq<StdString>{
    return new String();
  }
  @:noUsing static public function Couple<L,R>(l:Eq<L>,r:Eq<R>):Eq<StdCouple<L,R>>{
    return new Couple(l,r);
  }
  @:noUsing static public function Anon<T>(fn:T->T->Equaled):Eq<T>{
    return new Anon(fn);
  }
  @:noUsing static public function Noise():Eq<tink.core.Noise>{
    return new Eq(new Noise());
  }
  @:noUsing static public function Bool():Eq<StdBool>{
    return Anon(
      (l,r) -> l == r ? AreEqual : NotEqual
    );
  }
  @:noUsing static public function Float():Eq<StdFloat>{
    return Anon(
      (l,r) -> l == r ? AreEqual : NotEqual
    );
  }
  @:noUsing static public function Array<T>(inner:Eq<T>):Eq<StdArray<T>>{
    return new Array(inner);
  }
  @:noUsing static public function Cluster<T>(inner:Eq<T>):Eq<stx.nano.Cluster<T>>{
    return new Cluster(inner);
  }
  @:noUsing static public function Primitive():Eq<stx.nano.Primitive>{
    return new Primitive();
  }
  @:noUsing static public function Option<T>(inner:Eq<T>):Eq<Option<T>>{
    return new stx.assert.eq.term.Option(inner);
  }
  @:noUsing static public function EnumValueIndex():Eq<StdEnumValue>{
    return new EnumValueIndex();
  }
  @:noUsing static public function NullOr<T>(inner:Eq<T>):Eq<Null<T>>{
    return new stx.assert.eq.term.NullOr(inner);
  }
  @:noUsing static public function Ident():Eq<Ident>{
    return new stx.assert.eq.term.Ident();
  }
  @:noUsing static public function Register():Eq<Register>{
    return new stx.assert.eq.term.Register();
  }
}

