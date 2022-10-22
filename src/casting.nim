when not defined(cpp):
  {.error: "This can only be used with the C++ backend".}

type SomeIntegerOrPointer = SomeInteger | pointer | ptr[auto]

proc cCast*[T](a: auto): T {.importcpp: "(('0) #)", nodecl.}
  ## C-style casting.
proc staticCast*[T](a: auto): T {.importcpp: "static_cast<'0>(#)", nodecl.}

proc dynamicCast*[T: pointer | ptr[object]](p: pointer | ptr[object]): T {.importcpp: "dynamic_cast<'0>(#)", nodecl.}
  #                                                                    ^ Can be `nil`!
  ## Can only be used on a pointer to an object of a C++ class.
  ## One might have to enable `-frtti` in order to use this `proc`.
  ## Note: This can return `nil` if failed.
proc dynamicCast*[T: var object](p:var object): T {.importcpp: "dynamic_cast<'0>(#)", nodecl.}
  #runnableExamples:
  #  import std/with
  #  from casting import dynamicCast
  #  type
  #    A {.inheritable, pure.} = object
  #      a: cint
  #    B = object of A
  #      b: cstring
  #  var x: B
  #  with dynamicCast[var A](x):
  #    a = 1
  #  assert x.a == 1
proc reinterpretCast*[T: SomeIntegerOrPointer](p: SomeIntegerOrPointer): T {.importcpp: "reinterpret_cast<'0>(#)", nodecl.}
  # If the input is non-nil, non-zero, then it does not return `nil`.
proc constCast*[T](x: T): T {.importcpp: "const_cast<'0>(#)", nodecl.}
  ## Removes the const qualifier of a C variable.
