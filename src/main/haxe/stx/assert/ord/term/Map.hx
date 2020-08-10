package stx.assert.ord.term;

import haxe.ds.Map in StdMap;

class Map<K,V> implements OrdApi<StdMap<K,V>>{
  var key : Ord<K>;
  var val : Ord<V>;

  public function new(key,val){
    this.key = key;
    this.val = val;
  }
  public function applyII(lhs:StdMap<K,V>,rhs:StdMap<K,V>):Ordered{
    var ret     = NotLessThan;
    var l_keys  = lhs.keyValueIterator().toIter().toArray();
    var r_keys  = rhs.keyValueIterator().toIter().toArray();
    var c       = l_keys.length - r_keys.length;
    return if(c != 0){
      c > 0 ? NotLessThan : LessThan;
    }else{
      ret = Ord.Array(key).applyII(l_keys,r_keys);
      if(ret == LessThan){
        LessThan;
      }else{
        for(k in l_keys){
          ret = val.applyII(lhs.get(k),rhs.get(k));
          if(ret == LessThan){
            break;
          }
        }
      }
      ret;
    }
  }
}