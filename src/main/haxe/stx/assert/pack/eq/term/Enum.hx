package stx.assert.pack.eq.term;

class Enum implements EqApi<Dynamic> extends Clazz{
  public function applyII(a:Dynamic,b:Dynamic):Equaled{
    return if(0 != std.Type.enumIndex(a) - std.Type.enumIndex(b)){
      NotEqual;
    }else{
      var pa  = StdType.enumParameters(a);
      var pb  = StdType.enumParameters(b);
      var b   = AreEqual;
      for(i in 0...pa.length) {
        if(!Equal.getEqualFor(pa[i]).applyII(a[i], pb[i]).ok()){
          b = NotEqual;
          break;
        }
      }
      b;
    }
  }
}