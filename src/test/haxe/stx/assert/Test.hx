package stx.assert;

using stx.Nano;
using stx.Assert;

using stx.Test;
import stx.assert.test.*;

final Ord         = __.assert().Ord();
final Eq          = __.assert().Eq();
final Comparable  = __.assert().Comparable();

class Test{
  static public function main(){
    var test = [
      //new ComparablesTest(),
      new StringMapTest(),
      new OrdTagCtrTest(),
    ];
    __.test().run(test,[]);
  }
}
class OrdTagCtrTest extends TestCase{
  public function test(){
    final ord   = Ord.Couple(Ord.String(),Ord.Int());
    final eq    = Eq.Couple(Eq.String(),Eq.Int());
    final comp  = Comparable.Couple(Comparable.String(),Comparable.Int());
  }
}