when not defined(cpp):
  {.error: "This can only be used with the C++ backend".}

type
  Anything = auto
  AnyPointer = pointer or ptr[Anything]
  AnyPointerOrInteger = AnyPointer or SomeInteger

proc cCast*[T](a: auto): T {.importcpp: "(('0) #)", nodecl.}
  ## C-style casting.
proc staticCast*[T](a: auto): T {.importcpp: "static_cast<'0>(#)", nodecl.}

proc dynamicCast*[T: ptr[Anything]](p: AnyPointer): T {.importcpp: "dynamic_cast<'0>(#)", nodecl.}
  #                                                 ^ Can be `nil`!
  ## Can only be used on a pointer to an object of a C++ class.
  ## Note: This can return `nil` if failed.
proc reinterpretCast*[T: AnyPointerOrInteger](p: AnyPointerOrInteger): T {.importcpp: "reinterpret_cast<'0>(#)", nodecl.}
  
proc constCast*[T](a: T): T {.importcpp: "const_cast<'0>(#)", nodecl.}
  ## Removes `const` from a C variable.