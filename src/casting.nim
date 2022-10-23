when not defined(cpp):
  {.error: "This can only be used with the C++ backend".}

import ./casting/exceptions

type SomeIntegerOrPointer = SomeInteger | pointer | ptr[auto]

proc cCast*[T](a: auto): T {.raises: [], importcpp: "(('0) #)", nodecl.}
  ## C-style casting.
proc staticCast*[T](a: auto): T {.raises: [], importcpp: "static_cast<'0>(#)", nodecl.}

proc dynamicCast*[S: pointer | ptr[object]](p: pointer | ptr[object]): S {.raises: [], importcpp: "dynamic_cast<'0>(#)", nodecl.}
  #                                                                    ^ Can be `nil`!
  ## Can only be used on a pointer to an object of a C++ class.
  ## One might have to use `--passC:-frtti` in order to use this `proc`.
  ## **Note:** This can return `nil` if failed.
proc dynamicCast*[R: var object](v: var object): R {.raises: [BadCast], importcpp: "dynamic_cast<'0>(#)", nodecl.}
  ## **Example:**
  ##
  ## .. code-block::
  ##   import std/with
  ##   from casting import dynamicCast
  ##   type
  ##     A {.inheritable, pure.} = object
  ##       a: cint
  ##     B = object of A
  ##       b: cstring
  ##   var x: B
  ##   with dynamicCast[var A](x):
  ##     a = 1
  ##   assert x.a == 1
proc reinterpretCast*[T: SomeIntegerOrPointer](p: SomeIntegerOrPointer): T {.raises: [], importcpp: "reinterpret_cast<'0>(#)", nodecl.}
  ## If the input is non-nil and non-zero, the result is not `nil`.
proc constCast*[T](x: T): T {.raises: [], importcpp: "const_cast<'0>(#)", nodecl.}
  ## Removes the const qualifier of a C variable.

export exceptions
