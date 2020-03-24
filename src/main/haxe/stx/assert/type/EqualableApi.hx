package stx.assert.type;

import stx.assert.pack.Eq;

interface EqualableApi<T>{
  public function eq() : Eq<T>;
}