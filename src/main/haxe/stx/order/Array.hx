package stx.order;
import stx.Order;


class Array{
  @:note("what's to say index zero is non-null?")
  @:noUsing static public function order<T>(v1: std.Array<T>, v2: std.Array<T>) {
      return orderWith(v1, v2, Order.getOrder(v1[0]));
  }

  static public function orderWith<T>(v1: std.Array<T>, v2: std.Array<T>, order : Ord<T>) {
    var c = v1.length - v2.length;
    if(c != 0)
      return c;
    if(v1.length == 0)
      return 0;
      for (i in 0...v1.length) {
        var c = order(v1[i], v2[i]);
        if (c != 0) return c;
      }
      return 0;
  }
}
