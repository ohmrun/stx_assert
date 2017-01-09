package stx.compare;

import tink.CoreApi;
import haxe.PosInfos;

@:enum abstract ErrorCodes(Int){
  var compare_function_error = Errors.code+1;
  var compare_no_implementation_error = Errors.code+2;
}
class Errors{
  static public inline var code : Int = 616639277;

  static public function compareFunctionError(?pos){
    return Error.withData(500,'Unable to compare functions',compare_function_error,pos);
  }
  static public function noImplementation(?pos){
    return Error.withData(500,'No implementation found',compare_no_implementation_error,pos);
  }
}
