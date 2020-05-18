package stx.assert.test;

class ComparablesTest extends utest.Test{
  var log : Log = __.log();

  public function testStringEq(){
    var a = Eq.String();
    var b = a.applyII("a","a");
        b.equals(true);
    var c = a.applyII("a","b");
        c.equals(false);
  }
  public function testStringOrd(){
  var a = Ord.String();
    var b = a.applyII("a","a");
        false.equals(b);
    var c = a.applyII("a","b");
        true.equals(c);
  }
}