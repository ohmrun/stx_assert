package stx.assert;

using stx.Nano;
using stx.Assert;

import stx.assert.test.*;
import utest.Assert.*;
import utest.UTest;


class Test{
  static public function main(){
    var test = [
      new ComparablesTest(),
    ];
    var poke = test.filter(
      __.that().always().check()
    );
    utest.UTest.run(#if poke poke #else test #end);
  }
}