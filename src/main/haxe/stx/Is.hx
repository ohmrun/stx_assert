package stx;

class Is{
  public static function isObject<T>(value : T) : Bool{
    return switch Type.typeof(value) {
      case TObject: true;
      default: false;
    }
  }
  public static function isNull<T>(value : T) : Bool {
    return switch Type.typeof(value) {
      case TNull: true;
      default: false;
    }
  }
  public static function isInt<T>(value : T) : Bool {
    return switch Type.typeof(value) {
      case TInt: true;
      default: false;
    }
  }
  public static function isFunction<T>(value : T) : Bool {
    return switch Type.typeof(value) {
      case TFunction: true;
      default: false;
    }
  }
  public static function isFloat<T>(value : T) : Bool {
    return switch Type.typeof(value) {
      case TFloat: true;
      default: false;
    }
  }
  public static function isEnum<T>(value : T) : Bool {
    return switch Type.typeof(value) {
      case TEnum(_): true;
      default: false;
    }
  }
  public static function isClass<T>(value : T) : Bool {
    return switch Type.typeof(value) {
      case TClass(t): true;
      default: false;
    }
  }
  public static function isBoolean<T>(value : T) : Bool {
    return switch Type.typeof(value) {
      case TBool: true;
      default: false;
    }
  }
  public static function isString<T>(value : T) : Bool {
    return switch Type.typeof(value) {
      case TClass(String): true;
      default: false;
    }
  }
  public static function isPrimitive<T>(v:T):Bool{
    return switch (Type.typeof(v)) {
        case TInt, TFloat, TBool : true;
        default                  : false;
    }
  }
}
