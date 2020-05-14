package stx.assert;

class Module extends Clazz{
  var pos   : Pos;
  public function new(pos){
    super();
    this.pos = pos;
  }
  public function equals<T>():Assertion<T,AssertFailure>                                      return Assertion.equals(pos);
  public function alike<E>():Assertion<StdEnumValue,AssertFailure>                            return Assertion.alike(pos);
  public function gt<T>():Assertion<T,AssertFailure>                                          return Assertion.gt(pos);
  public function gt_eq<T>():Assertion<T,AssertFailure>                                       return Assertion.gt_eq(pos);
  public function lt<T>():Assertion<T,AssertFailure>                                          return Assertion.lt(pos);
  public function lt_eq<T>():Assertion<T,AssertFailure>                                       return Assertion.lt_eq(pos);

  public function always<T>():Predicate<T,AssertFailure>                                      return Predicate.always(pos);
  public function never<T,E>():Predicate<T,E>                                                 return Predicate.never(pos);
  public function is<A>(clazz:Class<A>):Predicate<A,AssertFailure>                            return Predicate.is(pos,clazz);
  public function throws<E>():Predicate<Block,AssertFailure>                                  return Predicate.throws(pos);
  public function void<T>():Predicate<T,AssertFailure>                                        return Predicate.void(pos);
  public function exists<T>():Predicate<T,AssertFailure>                                      return Predicate.exists(pos);
  public function matches<E>(reg:String,opt:String):Predicate<String,AssertFailure>           return Predicate.matches(pos,reg,opt);
}