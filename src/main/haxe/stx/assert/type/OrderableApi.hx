package stx.assert.type;

import stx.assert.pack.Ord;

interface OrderableApi<T>{
  public function lt():Ord<T>;
}