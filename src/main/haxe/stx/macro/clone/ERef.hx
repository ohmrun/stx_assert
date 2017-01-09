package stx.macro.clone;

typedef ERefT = Array<String>;

abstract ERef(ERefT) from ERefT{
  public inline function new( v : ERefT ) {
    this = v;
  }
  public function full(){
    var string = this.join(".");
    return macro $i{string};
  }
  public function with(name:String){
    var next = this.copy();
        next.push(name);
    return next;
  }
}
