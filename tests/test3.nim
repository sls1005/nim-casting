import casting

type
  A {.inheritable, pure.} = object
    a: int
  B = object of A
    b: float

proc main =
  var x: B
  try:
    (dynamicCast[var A](x)).a = 1
    var y = dynamicCast[var A](x)
    assert x.a == 1
    assert y.a == 1
    # `x` was casted to a C++ reference, however, `y` is an object.
    # Therefore modifying `y` does not affect `x`.
    y.a = 2
    echo x.a #should be 1
    {.push experimental: "views".}
    var z: var A = dynamicCast[var A](x)
    assert z.a == 1
    # `z` is of a view type.
    # Therefore, changing `z` does change `x`.
    z.a = 2
    echo x.a #should be 2
    {.pop.}
  except BadCast as e:
    echo e.what()

main()
