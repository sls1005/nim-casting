# Sometimes `char*` and `const char*` are not considered the same type, and thus require explicit casting.
# Compile this file with, and without `-d:workaround1` to see the difference.

from casting import cCast, constCast

{.emit: """
const char * greet() {
    return "Hello world!";
}
""".}

proc greet(): cstring {.importcpp.}

proc main =
  var s: cstring
  when defined(workaround1):
    s = cCast[cstring](greet())
  elif defined(workaround2):
    s = constCast[cstring](greet())
  else:
    s = cast[cstring](greet())
    {.warning: "This might not be accepted by the C++ compiler. Consider using '-d:workaround1'".}
  echo s

main()
