when not defined(cpp):
  {.error: "This can only be used with the C++ backend".}

type SomeIntegerOrPointer = SomeInteger | pointer | ptr[auto]

proc cCast*[T](a: auto): T {.importcpp: "(('0) #)", nodecl.}
  ## C-style casting.
proc staticCast*[T](a: auto): T {.importcpp: "static_cast<'0>(#)", nodecl.}

proc dynamicCast*[S: pointer | ptr[object]](p: pointer | ptr[object]): S {.importcpp: "dynamic_cast<'0>(#)", nodecl.}
  #                                                                    ^ Can be `nil`!
  ## Can only be used on a pointer to an object of a C++ class.
  ## One might have to enable `-frtti` in order to use this `proc`.
  ##
  ## .. note::
  ##   This can return `nil` if failed.
proc dynamicCast*[R: var object](v: var object): R {.importcpp: "dynamic_cast<'0>(#)", nodecl.}
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
proc reinterpretCast*[T: SomeIntegerOrPointer](p: SomeIntegerOrPointer): T {.importcpp: "reinterpret_cast<'0>(#)", nodecl.}
  ## If the input is non-nil and non-zero, the result is not `nil`.
proc constCast*[T](x: T): T {.importcpp: "const_cast<'0>(#)", nodecl.}
  ## Removes the const qualifier of a C variable.
