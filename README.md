# stx_assert

includes ```Predicate Assertion Assertation Eq Ord```

## Usage

```haxe
using stx.Nano;//Wildcard
using stx.Assert;

class Main{
 static public function main(){
   __.assert().equals(1,2);//throws Err
   __.that().equals().ok(1,2)//returns false
   __.that().equals().crunchII(1,2)//throws Err

  var a = 1;
   __.that().exists().and(
    __.that().equals().bindI(1)
   ).ok(a)//returns true
 }
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

```haxe
ands<T,E>(self: Predicate<T,E>,rest: Iterable<Predicate<T,E>>): Predicate<T,E> 
```
Produces a predicate that succeeds if all input predicates succeed.

```haxe
ors<T,E>(self: Predicate<T,E>,rest: Iterable<Predicate<T,E>>): Predicate<T,E >
```
Produces a predicate that succeeds if any of the input predicates succeeds.


```haxe
and<T,E>(self: Predicate<T,E>,that: Predicate<T,E>): Predicate<T,E>
```
Produces a predicate that succeeds if both succeed.

```haxe
or<T,E>(self: Predicate<T,E>,that: Predicate<T,E>): Predicate<T,E>
```
Produces a predicate that succeeds if one or other predicates succeed.
  
```haxe
xor<T,E>(self: Predicate<T,E>, that: Predicate<T,E>): Predicate<T,E>
```
Produces a predicate that succeeds if one or other , but not both predicates succeed.

```haxe
not<T,E>(self: Predicate<T,E>):Predicate<T,E>
```

Produces a predicate that succeeds if the input predicate fails.
 
```haxe
  errata<T,E,EE>(self: Predicate<T,E>,fn:Err<E>->Err<EE>):Predicate<T,EE>
```
Map the `Err` datatype.