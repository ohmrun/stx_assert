package stx.assert;

class Module extends Clazz{
  var pos   : Pos;
  var assertation  : stx.assert.pack.assertation.Term;
  var predicate    : stx.assert.pack.predicate.Term;
  public function new(pos){
    super();
    this.pos = pos;
    this.assertation  = new stx.assert.pack.assertation.Term();
    this.predicate    = new stx.assert.pack.predicate.Term();
  }
  public function equals<T>():Assertation<T,AssertFailure>                                    return assertation.equals(pos);
  public function alike<E>():Assertation<StdEnumValue,AssertFailure>                          return assertation.alike(pos);
  public function gt<T>():Assertation<T,AssertFailure>                                        return assertation.gt(pos);
  public function gt_eq<T>():Assertation<T,AssertFailure>                                     return assertation.gt_eq(pos);
  public function lt<T>():Assertation<T,AssertFailure>                                        return assertation.lt(pos);
  public function lt_eq<T>():Assertation<T,AssertFailure>                                     return assertation.lt_eq(pos);

  public function always<T>():Predicate<T,AssertFailure>                                      return predicate.always(pos);
  public function never<T,E>():Predicate<T,E>                                                 return predicate.never(pos);
  public function is<A>(clazz:Class<A>):Predicate<A,AssertFailure>                            return predicate.is(pos,clazz);
  public function throws<E>():Predicate<Block,AssertFailure>                                  return predicate.throws(pos);
  public function void<T>():Predicate<T,AssertFailure>                                        return predicate.void(pos);
  public function exists<T>():Predicate<T,AssertFailure>                                      return predicate.exists(pos);
  public function matches<E>(reg:String,opt:String):Predicate<String,AssertFailure>           return predicate.matches(pos,reg,opt);
}