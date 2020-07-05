package stx.assert.module;

class Crunch extends Clazz{
  var module  : Module;
  public function new(pos){
    super();
    this.module = new Module(pos);
  }
  public function equals<T>(lhs:T,rhs:T)                              this.module.equals().crunchII(lhs,rhs);
  public function alike<E:StdEnumValue>(lhs:E,rhs:E)                  this.module.alike().crunchII(lhs,rhs);
  public function gt<T>(lhs:T,rhs:T)                                  this.module.gt().crunchII(lhs,rhs);
  public function gt_eq<T>(lhs:T,rhs:T)                               this.module.gt_eq().crunchII(lhs,rhs);
  public function lt<T>(lhs:T,rhs:T)                                  this.module.lt().crunchII(lhs,rhs);
  public function lt_eq<T>(lhs:T,rhs:T)                               this.module.lt_eq().crunchII(lhs,rhs);

  public function always<T>(t:T)                                      this.module.always().crunch(t);
  public function never<T,E>(t:T)                                     this.module.never().crunch(t);
  public function iz<A>(a:A,clazz:Class<A>)                           this.module.iz(clazz).crunch(a);
  public function throws<E>(fn:Block)                                 this.module.throws().crunch(fn);
  public function void<T>(t:T)                                        this.module.void().crunch(t);
  public function exists<T>(t:T)                                      this.module.exists().crunch(t);
  public function matches<E>(string:String,reg:String,opt:String)     this.module.matches(reg,opt).crunch(string);
} 