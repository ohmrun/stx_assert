package stx.macro.clone;

import haxe.ds.StringMap;

using thx.Maps;

#if macro
  import stx.macro.CloneHelpers;
#end
import Map;

#if macro
@:forward(exists)abstract Repo(IMap<String,CloneItem>) from IMap<String,CloneItem>{
  public function new(self){
    this = self;
  }
  public function toMap():IMap<String,CloneItem>{
    return this;
  }
  /*
  public function paths():Paths{
    return this.map(
      function(x){
        return x.path;
      }
    );
  }*/
  public function ids(){
    return this.map(
      function(x){
        return x.id;
      }
    );
  }
  public function map(fn){
    return this.map(fn);
  }
  public function merge(that:Repo):Repo{
    var next = new StringMap();
        this.copyTo(next);
        that.toMap().copyTo(next);
    return next;
  }
  public function get(id:String):Null<CloneItem>{
    return this.get(id);
  }
  public function copy(){
    var next = new StringMap();
    this.copyTo(next);
    return next;
  }
  public function add(ci:CloneItem){
    //trace('ID: ${ci.id}');
    var next = copy();
    next.set(ci.id,ci);
    return next;
  }
  public function size(){
    return this.reduce(
      function(memo,next){
        return memo+1;
      }
    ,0);
  }
  public function toString(){
    return this.reduce(function(memo,next){
      return '$memo\n ${next._0} ${next._1.recursive}';
    },'');
  }
}
#end
