from casting import dynamicCast

type
  A = object of RootObj
    a: int
  B = object of A
    b: float

proc main =
  var x: B
  let p: ptr A = dynamicCast[ptr A](x.addr)
  if unlikely(p.isNil()):
    echo "failed to cast"
    return
  (p[]).a = 1
  assert x.a == 1

main()
