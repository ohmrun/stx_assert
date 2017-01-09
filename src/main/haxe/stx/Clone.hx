package stx;



using stx.Transducers;
using stx.Pointwise;

using stx.Tuple;

import Type;
import haxe.ds.IntMap;

import stx.Hash;

using stx.Compare;

using Lambda;

typedef CloneFunction<T> = T -> Array<Dynamic> -> T;

class Clone{
  static public function clone<T>(v:T):T{
    return getCloneFor(v)(v,[]);
  }
  static public function getCloneFor<T>(v:T):CloneFunction<T>{
    return getCloneForType(Type.typeof(v));
  }
  static public function getCloneForType<T>(v:ValueType):CloneFunction<T>{
    return switch(v) {
      case TInt,TFloat,TBool,TNull,TFunction  : clone_immutable;
      case TClass(c) if(c == String)          : clone_immutable;
      case TClass(c) if(c == Date)            : __clone__(cast DateClone.clone);
      case TClass(Array)                      : __clone__(cast ArrayClone.clone);
      case TClass(c)                          : __clone__(UnsupportedClassClone.clone);
      case TEnum(e)                           : __clone__(cast EnumClone.clone);
      case TObject                            : __clone__(ObjectClone.clone);
      case TUnknown                           : __clone__(clone_immutable); //?not sure about this
    }
  }
  static private function clone_immutable<T>(v:T,stack:Array<Dynamic>):T{
    return v;
  }
  static private function __clone__<T>(impl:CloneFunction<T>):CloneFunction<T>{
    return function(v:T,stack:Array<Dynamic>):T{
      if(stack.remove(v)){
        stack.push(v);
        return v;
      }else{
        stack.push(v);
      }
      return impl(v,stack);
    }
  }
}
@:note('#0b1kn00b: if there are lambdas as instance vars they will not be copied as there is no way to differentiate them without errors')
@:note("OK, I lied, but you'll need to try to copy all functions and catch errors")
class UnsupportedClassClone{
  @:noUsing static public function clone<T>(v:T,stack:Array<Dynamic>):T{
    var tp  : Class<T> = Type.getClass(v);
    var nw   = Type.createEmptyInstance(tp);
    var flds = Reflect.fields(v);

    var keys = [];

    function concat(arr:Array<String>, objs : Array<String>) {
      var nxt = arr;
        for (obj in objs) {
            var found = false;

            for (match in arr) {
                if (match == obj) {
                    found = true;
                    break;
                }
            }
            if (!found) nxt = T.toArray(nxt,obj);
        }
      return nxt;
    }

    keys = concat(keys,flds);

    switch (Type.typeof(v)) {
      case TClass(c) : keys = concat(keys,Type.getInstanceFields(c));
      default       :
    }
    var _filter = T.filter(
      Tuples2.snd.then(function(x) return !Reflect.isFunction(x))
    );
    //get the clone function for the object
    //then bind the stack to the resulting function
    //and curry it so the result of link is the far left input and the T -> T
    //function produced,then apply with unary.apply.
    //do all this to the right hand side of the tuple <FieldName,Value> (second)
    var _map    = T.map(
      Clone.getCloneFor.then(
        stx.Binary.apply.bind(_,_,stack).curry()
      ).link().then(stx.Unary.apply.flip().tupled()).second() //hurrr
    );
    var all     = _map.comp(_filter)(T.toArray);

    var fields  = keys.map(Reflect.field.bind(v).link());

    var new_fields = all.reduceBy(fields,[]);

    new_fields.iter(Reflect.setField.bind(nw).tupled());

    return nw;
  }
}
class EnumClone{
  @:noUsing static public function clone(v:EnumValue,stack:Array<Dynamic>):EnumValue{
    var nw      = Type.getEnum(v);
    var nm      = Type.enumConstructor(v);
    var params  = Type.enumParameters(v).map(
      function(x){
        return Clone.getCloneFor(x)(x,stack);
      }
    );
    return Type.createEnum(nw,nm,params);
  }
}
class ObjectClone{
  @:noUsing static public function clone<T>(v:T,stack:Array<Dynamic>):T{
    var nw : Dynamic  = {};
    var keys          = Reflect.fields(v);
    var flds          = keys.map(Reflect.field.bind(v).link())
        .map(
          function(x){
            return Clone.getCloneFor(x)(x,stack);
          }.second()
        );
    flds.iter(Reflect.setField.bind(nw).tupled());
    return nw;
  }
}
class DateClone{
  @:noUsing static public function clone(v:Date,stack:Array<Dynamic>):Date{
    return Date.fromTime(v.getTime());
  }
}
class ArrayClone{
  @:noUsing static public function clone<T>(arr:Array<T>,stack:Array<Dynamic>):Array<T>{
    var next = [];
    for (val in arr){
      next.push( Clone.getCloneFor(val)(val,stack) );
    }
    return next;
  }
}
