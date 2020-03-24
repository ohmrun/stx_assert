package stx.macro;


import haxe.ds.Option;

using Lambda;

import haxe.macro.Context;
import haxe.macro.Printer;
import haxe.macro.Expr;
import haxe.macro.Type;


using tink.CoreApi;

#if macro
  import haxe.macro.TypeTools;

  using stx.Couple;
  using stx.Pointwise;
  using stx.macro.Package;
  using tink.MacroApi;

#end
