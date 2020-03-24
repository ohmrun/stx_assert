package stx.assert.pack.eq.term;

class NotNull<T> implements EqApi<T>{
  var eq : Eq<Dynamic>;
  public function new(eq){
    this.eq = eq;
  }
  public function applyII(a:T,b:T){
    return switch([a,b]){
      case [null,null]        : AreEqual;
      case [null,_]           : NotEqual;
      case [_,null]           : NotEqual;
      default                 : eq.applyII(a,b);
    }
  }
}