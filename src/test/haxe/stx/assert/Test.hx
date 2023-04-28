package stx.assert;

using stx.Nano;
using stx.Assert;

using stx.Test;
import stx.assert.test.*;

class Test{
  static public function main(){
    var test = [
      //new ComparablesTest(),
      new StringMapTest(),
    ];
    __.test().run(test,[]);
  }
}