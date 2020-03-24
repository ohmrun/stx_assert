package stx.assert.type;

enum abstract OrderedSum(Bool) from Bool{
  var LessThan    = true;
  var NotLessThan = false;

  public function ok():Bool{
    return this;
  }
}