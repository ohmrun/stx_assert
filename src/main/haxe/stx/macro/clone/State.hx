package stx.macro.clone;

@:access(stx.macro.clone.State) class State{
  public var ref(default,null)        : ERef;
  public var pos(default,null)        : Position;
  public var inlinable(default,null)  : Bool;
  public var expr(default,null)       : ERef->Expr;
  public var methods(default,null)    : Methods;

  public function new(?methods,?expr,?ref,?pos){
    this.methods    = methods  == null ? new Methods() : methods;
    this.expr       = expr     == null ? CloneHelpers.def : expr;
    this.ref        = ref;
    this.pos        = pos == null ? Context.currentPos() : pos;
  }
  public function withRef(ref:ERef){
    var next = copy();
        next.ref = ref;
    return next;
  }
  public function get(req:Request){
    return this.methods.getMethod(req);
  }
  public function getAny(req:Request){
    return this.methods.getAny(req);
  }
  public function has(req){
    return this.methods.has(req);
  }
  public function isRecursive(req:Request){
    var hasDefault  = this.methods.hasDefault(req);
    var hasAny      = this.methods.hasAny(req);
    var anyMethod   = this.methods.getAny(req);
    var isImmutable = anyMethod == null ? false : std.Type.enumEq(anyMethod.kind,Immutable);
    var isR         = (!hasDefault) && hasAny && !isImmutable;
    if(isR){
      trace('recursive? $isR req $req' );
    }
    return isR;
  }
  public function rebase(ref){

  }
  public function ready(request:Request){
    var out = methods.hasAny(request);
    trace('ready? $request $methods $out');
    //trace(methods.has(request));
    return out;
  }

  public function found(request:Request,expr:Method):State{
    var next = copy();
        next.methods.setMethod(request,expr);
    return next;
  }
  public function copy():State{
    return new State(methods,expr,ref,pos);
  }
  public function reref(ref:ERef){
    var next = copy();
        next.ref = ref;
    return next;
  }
  public function recursives(){
    return methods.recursives();
  }
}
