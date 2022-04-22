package stx.assert;

enum abstract OrderedSum(Bool) from Bool{
  var LessThan    = true;
  var NotLessThan = false;

  public function is_ok():Bool{
    return this;
  }
}

@:forward abstract Ordered(OrderedSum) from OrderedSum to OrderedSum{
  public function new(self){
    this = self;
  }
  @:from static public function fromBool(b:Bool):Ordered{
    return b  ? LessThan : NotLessThan;
  }
  public function toBool():Bool{
    return switch(this){
      case OrderedSum.LessThan    : true;
      case OrderedSum.NotLessThan : false;
    }
  }
  @:op(A || B)
  public function or(that:Ordered):Ordered{
    return toBool() || that.toBool();
  }
  @:op(!A)
  public function not():Ordered{
    return switch(this){
      case OrderedSum.LessThan    : OrderedSum.NotLessThan;
      case OrderedSum.NotLessThan : OrderedSum.LessThan;
    }
  }
  @:op(A && B)
  public function and(that:Ordered):Ordered{
    return toBool() && that.toBool();
  }
  public function is_not_less_than(){
    return switch(this){
      case NotLessThan : true;
      default          : false;
    }
  }
}

