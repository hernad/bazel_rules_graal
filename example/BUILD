load("@rules_graal//graal:graal.bzl", "graal_binary")
load("@rules_java//java:defs.bzl", "java_library", "java_import")




java_library(
    name = "main",
    #main_class = "Main",
    srcs = ["Main.java"],
    deps = [ "//jodreports:jodreports" ]

)

graal_binary(
    name = "main-native-linux",
    deps = [":main" ],
    main_class = "Main",
    graal = "@graal//:bin/native-image",
    data = []
)

graal_binary(
    name = "main-native-windows",
    deps = [":main"],
    main_class = "Main",
    graal = "@graal//:bin/native-image.cmd",
    data = []
)


graal_binary(
    name = "main-native-reflectioncfg",
    deps = [":main"],
    initialize_at_build_time=["Main"],
    reflection_configuration = "reflection.cfg",
    main_class = "Main",
    graal = "@graal//:bin/native-image",
)


