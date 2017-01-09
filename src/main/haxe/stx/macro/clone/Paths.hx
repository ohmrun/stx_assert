package stx.macro.clone;

@:forward abstract Paths(List<Path>) from List<Path>{
  public function show(){
    return this.map(
      function(x){
        return x.toString();
      }
    ).join(",");
  }
}
