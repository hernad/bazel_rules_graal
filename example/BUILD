load("@rules_graal//graal:graal.bzl", "graal_binary")
load("@rules_java//java:defs.bzl", "java_library")

java_library(
    name = "main",
    #main_class = "Main",
    srcs = ["Main.java"],
)

graal_binary(
    name = "main-native",
    deps = [":main"],
    main_class = "Main",
    #_graal = "@graal/:bin/native-image.cmd",
    data = []
)


graal_binary(
    name = "main-native-reflectioncfg",
    deps = [":main"],
    initialize_at_build_time=["Main"],
    reflection_configuration = "reflection.cfg",
    main_class = "Main",
)


