workspace(name = "rules_graal")


load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

load("@rules_graal//graal:graal_bindist.bzl", "graal_bindist_repository")

graal_bindist_repository(
    name = "graal",
    version = "19.3.1",
    java_version = "8",
    #extension = "tar.gz"
    #extension = select({
    #    "@bazel_tools/platforms:windows": "zip",
	#"@bazel_tools/platforms:linux": "tar.gz"
    #})
)

git_repository(
    name = "misc_rules",
    commit = "0ad0b02af9e4b46717e8918c4c75b32eb71d9838",
    remote = "git://github.com/andyscott/misc_rules",
)

register_toolchains(
	"@misc_rules//toolchains/shellcheck:shellcheck_from_host_path",
)

