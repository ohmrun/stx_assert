package stx.assert.test;

class ComparablesTest extends TestCase{
  var log : Log = __.log();

  public function testStringEq(){
    var a = Eq.String();
    var b = a.comply("a","a").is_ok();
    equals(true,b);
    var c = a.comply("a","b").is_ok();
    equals(false,c);
  }
  public function testStringOrd(){
  var a = Ord.String();
    var b = a.comply("a","a").is_ok();
    equals(false,b);
    var c = a.comply("a","b").is_ok();
    equals(true,c);
  }
}