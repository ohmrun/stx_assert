package stx.macro.clone.data;

enum PathNode{
  Head;
  DotAccess(str:String);
  ArrayAccess(?int:Int);
}
