from casting import staticCast, dynamicCast, reinterpretCast

{.emit: """
class A {
  public:
    int i;
};
class B: public A {
  public:
    char * s;
};
""".}

type
  A {.importcpp: "A", inheritable.} = object
    i: cint
  B {.importcpp: "B".} = object of A
    s: cstring

proc main =
  var b: B
  b.i = 1
  let p1: ptr A = dynamicCast[ptr A](b.addr)
  if unlikely(p1.isNil()):
    echo "failed to cast"
  else:
    echo (p1[]).i
  var f = 1 / 2 + 3
  echo f
  let x = staticCast[int](f)
  echo x
  let y = cast[int](f)
  let p2 = reinterpretCast[ptr[int]](f.addr)
  echo likely(p2[] == y)

main()