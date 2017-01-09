package stx.macro.clone;

enum Kind{
  Immutable;
  Unknown;
  Known(type:Type);
  Anon(type:Type);
}
class Kinds{
  static public function toString(kind:Kind){
    return switch(kind){
      case Immutable:           "(immutable)";
      case Unknown:             "(unknown)";
      case Known(type):         '(known:$type)';
      case Anon(anon):          '(anon:anon)';
    }
  }
}
