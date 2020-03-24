package stx.assert.pack.eq.term;

import stx.core.alias.StdArray;

class Array<V> implements EqApi<StdArray<V>>{
  var eq : Eq<V>;

  public function new(eq){
    this.eq = eq;
  }
  public function applyII(a:StdArray<V>,b:StdArray<V>):Equaled{

    var ok = AreEqual;

    if(a.length!=b.length){
      return NotEqual;
    }

    for(i in 0...a.length-1){
      var lhs = a[i];
      var rhs = b[i];
      ok = eq.applyII(lhs,rhs);
      if(!ok.ok()){break;}
    }
    return ok;
  }
}