package stx.macro.clone;

class ObjectTreeNode{
  public function new(path,type,id){
    this.path       = path;
    this.type       = type;
    this.id         = id;
    //trace('CREATED: $id');
    this.recursion  = false;
  }
  public var path(default,null)       : Path;
  public var type(default,null)       : Type;
  public var id(default,null)         : String;
  public var recursion(default,null)  : Bool;

  public function toString(){
    var short_id      = id.substr(0,12);
    var is_recursive  = recursion ? '*' : '';
    return '($is_recursive$path)';
  }
  function copy(){
    var next = new ObjectTreeNode(path,type,id);
        next.recursion = this.recursion;
    return next;
  }
  public function withPath(path){
    return new ObjectTreeNode(path,type,id);
  }
  public function withType(type){
    return new ObjectTreeNode(path,type,id);
  }
  public function withRecursion(recursion){
    var next = copy();
        next.recursion = recursion;
    return next;
  }
}
