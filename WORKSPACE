# rules_graal
workspace(name = "rules_graal")

load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

load("@rules_graal//graal:graal_bindist.bzl", "graal_bindist_repository")

graal_bindist_repository(
    name = "graal",
    version = "19.3.1",
    java_version = "8",
)

git_repository(
    name = "misc_rules",
    commit = "0ad0b02af9e4b46717e8918c4c75b32eb71d9838",
    remote = "git://github.com/andyscott/misc_rules",
)

http_archive(
    name = "bazel_skylib",
    sha256 = "eb5c57e4c12e68c0c20bc774bfbc60a568e800d025557bc4ea022c6479acc867",
    strip_prefix = "bazel-skylib-0.6.0",
    url = "https://github.com/bazelbuild/bazel-skylib/archive/0.6.0.tar.gz",
)

register_toolchains(
	"@misc_rules//toolchains/shellcheck:shellcheck_from_host_path",
)

