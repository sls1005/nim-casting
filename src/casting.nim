when not defined(cpp):
  {.error: "This can only be used with the C++ backend".}

import ./casting/exceptions

type SomeIntegerOrPointer = SomeInteger | pointer | ptr[auto]

proc cCast*[T](a: auto): T {.raises: [], importcpp: "(('0) #)", nodecl.}
  ## C-style casting.
proc staticCast*[T](a: auto): T {.raises: [], importcpp: "static_cast<'0>(#)", nodecl.}

proc dynamicCast*[T: pointer | ptr[object]](p: pointer | ptr[object]): T {.raises: [], importcpp: "dynamic_cast<'0>(#)", nodecl.}
  #                                                                    ^ Can be `nil`!
  ## Can only be used on a pointer to an object of a C++ class.
  ## One might have to use `--passC:-frtti` in order to use this `proc`.
  ## **Note:** This can return `nil` if failed.
proc dynamicCast*[T: object](v: var object): var T {.raises: [BadCast], importcpp: "dynamic_cast<'0>(#)", nodecl.}
  ## **Example:**
  ##
  ## .. code-block::
  ##   import casting
  ##   type
  ##     A {.inheritable, pure.} = object
  ##       a: int
  ##     B = object of A
  ##       b: float
  ##   var x: B
  ##   {.push experimental: "views".}
  ##   try:
  ##     var y: var A = dynamicCast[A](x)
  ##     y.a = 1
  ##     assert x.a == 1
  ##   except BadCast as e:
  ##     echo e.what()
  ##   {.pop.}
proc reinterpretCast*[T: SomeIntegerOrPointer](p: SomeIntegerOrPointer): T {.raises: [], importcpp: "reinterpret_cast<'0>(#)", nodecl.}

proc constCast*[T](x: T): T {.raises: [], importcpp: "const_cast<'0>(#)", nodecl.}
  ## Removes the const qualifier of a C variable.

export exceptions.BadCast
export exceptions.what
