package stx.assert.test;

import haxe.ds.StringMap;

class StringMapTest extends TestCase{
  public function test(){
    final eq = Eq.StringMap(Eq.String());
    final l : StringMap<String> = [
      "abcd" => "b",
      "efgh" => "099080"
    ];
    is_true(eq.comply(l,l).is_ok());
    final r : StringMap<String> = [
      "abcd" => "b",
      "efgh" => "0990801"
    ];
    is_false(eq.comply(l,r).is_ok());
  }
}