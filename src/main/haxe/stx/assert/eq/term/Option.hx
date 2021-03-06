package stx.assert.eq.term;

class Option<T> implements EqApi<StdOption<T>>{
  var eq : Eq<T>;
  public function new(eq){
    this.eq = eq;
  }
  public function comply(a:StdOption<T>,b:StdOption<T>):Equaled{
    return switch([a,b]){
      case [Some(l),Some(r)]          : eq.comply(l,r);
      default                         : false;
    }
  }
}