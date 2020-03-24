package stx.assert.pack;

abstract Comparative(ComparativeSum) from ComparativeSum{
  public function new(self) this = self;
  public function toString(){
    return switch (this){
      case GT       : ">";
      case GTEQ     : ">=";
      case LT       : "<";
      case LTEQ     : "<=";
      case EQ       : "==";
    }
  }
}