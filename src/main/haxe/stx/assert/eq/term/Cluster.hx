package stx.assert.eq.term;

class Cluster<T> implements EqApi<stx.nano.Cluster<T>>{
  final inner : EqApi<T>;
  public function new(inner){
    this.inner = inner;
  }
  
  public function comply(lhs:stx.nano.Cluster<T>,rhs:stx.nano.Cluster<T>){
    return if(lhs.length != rhs.length){
      false;
    }else{
      var same = AreEqual;
      for(i in 0...lhs.length){
        same = inner.comply(lhs[i],rhs[i]);
        if(!same.is_ok()){
          break;
        }
      }
      return same;
    }
  }
}