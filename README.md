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
+ When you have to cast something, please use the built-in keyword `cast` if possible. This library should only be used where `cast` fails, or is inappropriate to use.

### Warning
+ Some of the `proc`s provided by this module allow performing unsafe operations. Please be sure of knowing what you are doing with them.

### Reference
+ <https://cplusplus.com/doc/tutorial/typecasting>
