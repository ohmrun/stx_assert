package stx.assert.pack;

@:forward abstract Assertion<T>(AssertionApi<T>) from AssertionApi<T>{
  public function new(self){
    this = self;
  }
}