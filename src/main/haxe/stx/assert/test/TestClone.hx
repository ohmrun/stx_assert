package stx.assert;

import utest.Assert.*;

class TestClone{
  public function new(){}
  public function testDeep(){
    var iterable = {
      iterator : function(){
        return [11,12,13].iterator();
      }
    }
    var clonable = new Clonable(1);
    var a = {
      s : "asd",
      f : 1,
      fdfg : true,
      arr : [ { obj : true }],
      obj : {
        "hello" : "world",
        clonable : clonable
      },
      itr : iterable
    };
    var out = [];
    var b = Clone.getCloneFor(a)(a,[]);
    b.itr.iter(
      function(x){
        out.push(x);
      }
    );
    same([11,12,13],out);
    a.arr[0].obj = false;
    isTrue(b.arr[0].obj);
    equals("ok",b.obj.clonable.hey);
    isFalse(b.obj.clonable.spanner == null);
  }
  /*
  public function testMacroClone(){
    var clonable = new Clonable(1);
    var iterable = {
      iterator : function(){
        return [11,12,13].iterator();
      }
    }
    var arr  = [ [{ obj : true } ]];
    var anon = {
      "string_in_anon" : "world",
      clonable : clonable
    };
    var a = {
      string  : "asd",
      int     : 1,
      bool    : true,
      arr_of_arr_of_anon : arr,
      anon : anon,
      itr : iterable
    };
    var b = {
      string  : "asd",
      int     : 1
    }
    var c = {
      ooos : {
        ooog : 2,
        ooom : true
      },
      nnnns : {
        nnnerf : "nadsf",
        nnnersk : "nobble"
      }
    };
    var d = {
      v : new SimpleClonable("hello"),
      a : c,
      arr : [
        {
          boot : "this"
        }
      ]
    }
    var e = {
      //a : new ClonableRec()
      //f : true
      g: new SimpleClonable("hello")
    }
    var t = new TwoLevelTop();
    var arr = [1,2,3,4];
    //var c = stx.macro.CloneHelpers.applyI(a);
    /*
    var c = stx.macro.CloneHelpers.applyIaar;
    var d = c(a);
    a.anon.string_in_anon = "hello";
    trace(a);
    trace(d);
    */
    //var f = { a : 2 };
    //var fn = stx.macro.CloneHelpers.applyI(a);
    //stx.macro.CloneHelpers.getRecursions(a);
    /*var address : Address   = Next(Head,Next(Next(Named("test"),Unique),Named("last")));
    var name : String       = address.makeString();
    trace(name);
    var address0 : Address  = Address.fromString(name);
    trace(address0);*/

    //trace(a.anon.clonable.spanner == b.anon.clonable.spanner);
    //trace(a.anon.clonable == b.anon.clonable);
  //}
}
class SimpleClonable{
  public function new(a){
    this.a = a;
  }
  public var a : String;
}
class ClonableRec{
  public function new(){}
  public var rec : ClonableRec;
}
class Clonable<T>{
  public function new(v:T){
    hey = "ok";
    spanner = this;
    something = v;
  }
  public var spanner : Clonable<T>;
  public var hey     : String;
  public var something      : T;
}
class TwoLevelTop{
  public function new(){}
  var second : TwoLevelInner;
}
class TwoLevelInner{
  public function new(){}
  var val : Int;
}
