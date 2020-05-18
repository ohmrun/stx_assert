package stx.assert.pack;


interface OrderableApi<T>{
  public function lt():Ord<T>;
}

@:forward abstract Orderable<T>(OrderableApi<T>) from OrderableApi<T> to OrderableApi<T>{
  public function new(self){
    this = self;
  }
}