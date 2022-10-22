# Casting

This wraps the C++ cast operators for the Nim programming language.

### Example

```nim
from casting import dynamicCast
type
  A {.inheritable, pure.} = object
    a: int
  B = object of A
    b: float
var x: B
let p: ptr A = dynamicCast[ptr A](x.addr)
if p.isNil():
  echo "failed to cast"
else:
  (p[]).a = 1
  assert x.a == 1
```

### Note
+ Please use the built-in keyword `cast` if possible. This library should only be used where `cast` fails, or is inappropriate to use.

### Warning
+ Some of the `proc`s provided by this module allow performing unsafe operations. Please be sure of knowing what you are doing with them.

### Reference
+ <https://cplusplus.com/doc/tutorial/typecasting>
