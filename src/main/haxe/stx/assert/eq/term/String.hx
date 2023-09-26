package stx.assert.eq.term;

class String extends EqCls<StdString>{
  static public function Unit(){
    return new String();
  }
  public function new(){}
  public function comply(a:StdString,b:StdString):Equaled{
    return a == b ? AreEqual : NotEqual;
  }
}