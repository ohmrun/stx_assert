package stx.assert.pack;

@:forward abstract Assertation<T,E>(AssertationApi<T,E>) from AssertationApi<T,E>{
  public function crunchII(l:T,r:T){
    switch(this.applyII(l,r)){
      case Some(e) : throw e;
      default:
    }
  }
  public function ok(l:T,r:T):Bool{
    return !this.applyII(l,r).is_defined();
  }
  /**
   * Creates a Predicate from an Assertation.
   * @param l 
   * @return Predicate<T>
   */
  public function load(l:T):Predicate<T,E>{
    return new stx.assert.pack.predicate.term.AssertationPredicate(this,l);
  }
}