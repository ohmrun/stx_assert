package stx.assert.comparable.term;

class Anon<T> implements ComparableApi<T>{
  var _eq     : Eq<T>;
  var _lt     : Ord<T>;
  public function new(_eq,_lt){
    this._eq  = _eq;
    this._lt = _lt;
  }
  public function eq(){
    return _eq;
  }
  public function lt(){
    return _lt;
  }
}