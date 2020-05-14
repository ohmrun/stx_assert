#if (test=="stx_assert")
  import stx.assert.test.*;
#end
class Main{
  static function main(){
    trace('main');
    #if (test=="stx_assert")
      utest.UTest.run(
        [
          new ComparablesTest()
        ]
      );
    #end
  }
}