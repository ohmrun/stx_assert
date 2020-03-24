package stx.assert.type;

enum abstract EqualedSum(Bool) from Bool{
  var AreEqual = true;
  var NotEqual = false;

  public function ok():Bool{
    return this;
  }
}