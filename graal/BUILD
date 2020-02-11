# @graal


load("@bazel_skylib//:bzl_library.bzl", "bzl_library")

package(default_visibility = ["//visibility:public"])

exports_files([
    "graal.bzl",
    "graal_bindist.bzl",
])

toolchain_type(
    name = "toolchain",
)

bzl_library(
    name = "rules",
    srcs = glob(["**/*.bzl"]),
)
