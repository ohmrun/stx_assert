package stx.assert.pack.eq.term;

class Array<V> implements EqApi<StdArray<V>>{
  var inner : Eq<V>;

  public function new(inner){
    this.inner = inner;
  }
  public function applyII(a:StdArray<V>,b:StdArray<V>):Equaled{

    var ok = AreEqual;

    if(a.length!=b.length){
      return NotEqual;
    }

    for(i in 0...a.length-1){
      var lhs = a[i];
      var rhs = b[i];
      ok = inner.applyII(lhs,rhs);
      if(!ok.ok()){break;}
    }
    return ok;
  }
}