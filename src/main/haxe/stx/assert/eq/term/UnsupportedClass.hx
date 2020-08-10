package stx.assert.eq.term;

class UnsupportedClass<T> implements EqApi<T> extends Clazz{
  public function applyII(a:T,b:T){
    return new Object().applyII(a,b) && (StdType.getClass(a) == StdType.getClass(b) ? AreEqual : NotEqual);
  }
}