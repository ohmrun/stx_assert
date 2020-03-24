package stx.assert.pack.eq.term;

class Option<T> implements EqApi<StdOption<T>>{
  var eq : Eq<T>;
  public function new(eq){
    this.eq = eq;
  }
  public function applyII(a:StdOption<T>,b:StdOption<T>):Equaled{
    return switch([a,b]){
      case [Some(l),Some(r)]          : eq.applyII(l,r);
      default                         : false;
    }
  }
}