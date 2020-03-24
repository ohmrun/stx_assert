package stx.assert.pack.eq.term;

class Object implements EqApi<Any> extends Clazz{
  public function applyII(a:Any,b:Any):Equaled{
    var o = AreEqual;

    for(key in Reflect.fields(a)) {
      var va = Reflect.field(a, key);
      if(!Equal.getEqualFor(va).applyII(va, Reflect.field(b, key)).ok()){
        o = NotEqual;
        break;
      }
    }
    return o;
  }
}