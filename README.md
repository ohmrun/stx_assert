# stx_assert

includes ```Predicate Assertion Assertation Eq Ord Comparable```

## Usage

### Assertions
```haxe
using stx.Nano;//Wildcard
using stx.Assert;

class Main{
 static public function main(){
   __.assert().that().equals(1,2);//throws Refuse
   __.assert().expect().ok(1,2)//returns false
   __.assert().expect().crunchII(1,2)//throws Refuse

  var a = 1;
   __.assert().expect().exists().and(
    __.assert().expect().equals().bindI(1)
   ).is_ok(a)//returns true
 }
}
```

### Ord, Eq and Comparable
```haxe
  final Ord = __.assert().Ord();
  final Eq  = __.assert().Eq();

  class Main{
    static public function main(){
      final ord = Ord.Couple(Ord.String(),Ord.Int());
      final eq  = Eq.Couple(Eq.String(),Eq.Int());
    }
  }
```

### Adding a Constructor

```haxe
  using MyClassOrdTagCtr;
  final Ord = __.assert().Ord();
  
  class Main{
    static public function main(){
      final ord = Ord.StringMap(Ord.MyClass());//Using the static extension of `TAG`
    }
  }
  private typedef TAG = STX<Ord<MyClass>>;

  class MyClassOrdTagCtr{
    static public function MyClass(tag:TAG){
      return new MyClassOrd();
    }
  }
  class MyClassOrd extends Ord<MyClass>{
    //....
  }
```
## Assertions
```haxe
function equals<T>(lhs:T,rhs:T)                              
function alike<E:StdEnumValue>(lhs:E,rhs:E)
function gt<T>(lhs:T,rhs:T)
function gt_eq<T>(lhs:T,rhs:T)                              
function lt<T>(lhs:T,rhs:T)                                  
function lt_eq<T>(lhs:T,rhs:T)                              
```

## Predicates
```haxe
function always<T>(t:T)                                     
function never<T,E>(t:T)                                    
function is<A>(a:A,clazz:Class<A>)                          
function throws<E>(fn:Block)                                
function void<T>(t:T)                                       
function exists<T>(t:T)                                     
function matches<E>(string:String,reg:String,opt:String)    
```

## Predicate Grammar

`ands` produces a predicate that succeeds if all input predicates succeed.
```haxe
ands<T,E>(self: Predicate<T,E>,rest: Iterable<Predicate<T,E>>): Predicate<T,E> 
```


`ors` produces a predicate that succeeds if any of the input predicates succeeds.  
```haxe
ors<T,E>(self: Predicate<T,E>,rest: Iterable<Predicate<T,E>>): Predicate<T,E >
```


`and` produces a predicate that succeeds if both succeed.
```haxe
and<T,E>(self: Predicate<T,E>,that: Predicate<T,E>): Predicate<T,E>
```


`or` produces a predicate that succeeds if one or other predicates succeed.
```haxe
or<T,E>(self: Predicate<T,E>,that: Predicate<T,E>): Predicate<T,E>
```


`xor` produces a predicate that succeeds if one or other , but not both predicates succeed.  
```haxe
xor<T,E>(self: Predicate<T,E>, that: Predicate<T,E>): Predicate<T,E>
```


`not` produces a predicate that succeeds if the input predicate fails.
```haxe
not<T,E>(self: Predicate<T,E>):Predicate<T,E>
```



`errata` maps the `stx.nano.Report` datatype.
```haxe
  errata<T,E,EE>(self: Predicate<T,E>,fn:Report<E>->Report<EE>):Predicate<T,EE>
```
