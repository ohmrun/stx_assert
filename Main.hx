class Main{
  static function main(){
    #if test
      utest.UTest.run(stx.Assert.tests());
    #end
  }
}