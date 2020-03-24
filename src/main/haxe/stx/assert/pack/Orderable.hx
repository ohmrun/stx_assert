package stx.assert.pack;

@:forward abstract Orderable<T>(OrderableApi<T>) from OrderableApi<T> to OrderableApi<T>{
  public function new(self){
    this = self;
  }
}