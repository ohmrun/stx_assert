package stx.order;

class Enum{
  static public function order(a : EnumValue, b: EnumValue) {
    var v = Type.enumIndex(a) - Type.enumIndex(b);
    if(0 != v)
      return v;
    var pa = Type.enumParameters(a);
    var pb = Type.enumParameters(b);
    for(i in 0...pa.length) {
      var v = Order.getOrder(pa[i])(pa[i], pb[i]);
      if(v != 0)
        return v;
    }
    return 0;
  }
}
