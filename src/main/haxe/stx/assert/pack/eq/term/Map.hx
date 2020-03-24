package stx.assert.pack.eq.term;

import haxe.ds.Map as StdMap;

class Map<K,V> implements EqApi<StdMap<K,V>>{
  var eq : Eq<V>;

  public function new(eq){
    this.eq = eq;
  }
  public function applyII(a:StdMap<K,V>,b:StdMap<K,V>):Equaled{
    var ok = true;

    for(key => val in a){
      if(!b.exists(key)){
        break;
      }
      ok = eq.applyII(val,b.get(key)).toBool();

      if(!ok){break;}
    }
    for(key => val in b){
      if(!a.exists(key)){
        break;
      }
    }
    return ok ? AreEqual : NotEqual;
  }
}