package stx.assert.comparable.term;

class Base<T> implements ComparableApi<T> extends Clazz{
  var _eq : Eq<T>;
  var _lt : Ord<T>;

  public function new(_eq,_ord){
    super();
    this._eq    = _eq;
    this._lt    = _ord;
  }
  public function eq() : Eq<T>{
    return _eq;
  }
  public function lt() : Ord<T>{
    return _lt;
  }
  public function toString(){
    return identifier(); 
  }
}