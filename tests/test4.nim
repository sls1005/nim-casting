from casting import dynamicCast

type
  A = object of RootObj
    a: int
  B = object of A
    b: float

proc main =
  var x: B
  let p1: ptr A = dynamicCast[ptr A](x.addr)
  (p1[]).a = 1
  assert x.a == 1

main()
