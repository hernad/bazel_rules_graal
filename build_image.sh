#!/bin/bash

cd bazel-bazel_rules_graal
external/graal/bin/native-image -cp bazel-out/k8-fastbuild/bin/example/libmain.jar -H:Class="Main" -H:Name=bazel-out/k8-fastbuild/bin/example/main-native-bin-11 --native-compiler-path=/bin/gcc  --verbose

cd ..


ls -lh bazel-bin/example/main-native-bin-11

bazel-bin/example/main-native-bin-11
