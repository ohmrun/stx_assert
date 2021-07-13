package stx.assert.test;

class ComparablesTest extends TestCase{
  var log : Log = __.log();

  public function testStringEq(){
    var a = Eq.String();
    var b = a.comply("a","a").ok();
    equals(true,b);
    var c = a.comply("a","b").ok();
    equals(false,c);
  }
  public function testStringOrd(){
  var a = Ord.String();
    var b = a.comply("a","a").ok();
    equals(false,b);
    var c = a.comply("a","b").ok();
    equals(true,c);
  }
}