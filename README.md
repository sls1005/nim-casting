# Casting

This wraps the C++ cast operators for the Nim programming language.

### Example

```nim
from casting import staticCast

var f: float64 = 1 / 2
let i: int64 = staticCast[int](f)
echo i #0
```

### Note
+ Consider using the built-in `cast` keyword instead. This module should only be used where `cast` fails, or is inappropriate to be used.

### Warning
+ Some of the `proc`s provided by this module allow performing unsafe operations. Please be sure of knowing what you are doing with them.

### Reference
+ <https://cplusplus.com/doc/tutorial/typecasting>
