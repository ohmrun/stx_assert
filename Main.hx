class Main{
  static function main(){
    trace('main');
    #if (test=="stx_assert")
      stx.assert.Test.main();
    #end
  }
}