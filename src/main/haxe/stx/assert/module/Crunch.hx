package stx.assert.module;

class Crunch extends Clazz{
  var module  : Module;
  public function new(pos){
    super();
    this.module = new Module(pos);
  }
  public function equals<T>(lhs:T,rhs:T)                              this.module.equals().comply(lhs,rhs).crunch();
  public function alike<E:StdEnumValue>(lhs:E,rhs:E)                  this.module.alike().comply(lhs,rhs).crunch();
  public function gt<T>(lhs:T,rhs:T)                                  this.module.gt().comply(lhs,rhs).crunch();
  public function gt_eq<T>(lhs:T,rhs:T)                               this.module.gt_eq().comply(lhs,rhs).crunch();
  public function lt<T>(lhs:T,rhs:T)                                  this.module.lt().comply(lhs,rhs).crunch();
  public function lt_eq<T>(lhs:T,rhs:T)                               this.module.lt_eq().comply(lhs,rhs).crunch();

  public function always<T>(t:T)                                      this.module.always().crunch(t);
  public function never<T,E>(t:T)                                     this.module.never().crunch(t);
  public function iz<A>(a:A,clazz:Class<A>)                           this.module.iz(clazz).crunch(a);
  public function throws<E>(fn:Block)                                 this.module.throws().crunch(fn);
  public function void<T>(t:T)                                        this.module.void().crunch(t);
  public function exists<T>(t:T)                                      this.module.exists().crunch(t);
  public function matches<E>(string:String,reg:String,opt:String)     this.module.matches(reg,opt).crunch(string);
} 