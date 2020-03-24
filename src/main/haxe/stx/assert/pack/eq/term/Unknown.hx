package stx.assert.pack.eq.term;

class Unknown implements EqApi<Dynamic> extends Clazz{

  public function applyII(a:Dynamic,b:Dynamic){
    return if(Reflect.hasField(a,'equals')){
      new HasFunction().applyII(a,b);
    }else{
      new Object().applyII((a:Any),(b:Any));
    }
  }
}