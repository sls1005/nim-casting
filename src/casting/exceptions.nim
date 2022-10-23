type BadCast* {.header: "<typeinfo>", importcpp: "std::bad_cast".} = object
proc what*(self: BadCast): cstring {.importcpp: "const_cast<'0>(#.what())".}
