package stx.macro.clone;

import stx.macro.clone.data.PathNode in PathNodeT;

abstract PathNode(PathNodeT) from PathNodeT{
  public function new(self){
    this = self;
  }
  function show(){
    return switch(this){
      case Head                   : '^';
      case DotAccess(str)         : '$str';
      case ArrayAccess(int)       : int == null ? '[]' : '[$int]';
    }
  }
  public function asIdentifier(){
    return switch(this){
      case Head                 : "";
      case DotAccess(str)       : str;
      case ArrayAccess(int)     : int == null ? '[]' : '[$int]';
    }
  }
}
