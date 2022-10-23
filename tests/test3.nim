import casting

type
  A {.inheritable, pure.} = object
    a: int
  B = object of A
    b: float

proc main {.raises: [].} =
  var x: B
  try:
    (dynamicCast[A](x)).a = 1
    var y = dynamicCast[A](x)
    assert x.a == 1
    assert y.a == 1
    y.a = 2
    echo x.a #should be 1
    {.push experimental: "views".}
    var z: var A = dynamicCast[A](x)
    assert z.a == 1
    z.a = 2
    echo x.a #should be 2
    {.pop.}
  except BadCast as e:
    echo e.what()

main()
