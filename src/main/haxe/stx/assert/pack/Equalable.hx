package stx.assert.pack;

@:forward abstract Equalable<T>(EqualableApi<T>) from EqualableApi<T>{
  public function new(self){
    this = self;
  }
}