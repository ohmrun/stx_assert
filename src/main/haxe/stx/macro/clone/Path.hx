package stx.macro.clone;

using thx.Arrays;
import thx.ReadonlyArray;

@:forward abstract Path(ReadonlyArray<PathNode>) from ReadonlyArray<PathNode>{
  public inline function new( ?v : ReadonlyArray<PathNode> ) {
    this = v;
    if(this == null){
      this = [Head];
    }
  }
  public function add(v):Path{
    var next = this.copy();
        next.push(v);
    return next;
  }
  public function toNative(){
    return this.foldLeft('',
      function(memo,next){
        return switch([memo,next]){
          case [memo,Head]                      : memo;
          case ["",DotAccess(str)]              :'$str';
          case [memo,DotAccess(str)]            :'$memo.$str';
          case [memo,ArrayAccess(int)]          : next.asIdentifier();
        }
      }
    );
  }
  public function equals(p:Path){
    return this.equals(p.unsafe());
  }
  public function up():Path{
    return this.dropRight(1);
  }
  public function leaf():PathNode{
    return this.last();
  }
  public function append(v:PathNode):Path{
    return this.append(v);
  }
  public function unsafe():ReadonlyArray<PathNode>{
    return this;
  }
  public function isHead(){
    return this.length == 1 && std.Type.enumEq(this.first(),Head);
  }
}
