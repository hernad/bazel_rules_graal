#!/bin/bash

rm -rf bazel-bin/example/main-native-bin


JARS=jodreports/commons-cli-1.2.jar
JARS=$JARS:jodreports/commons-io-1.4.jar
JARS=$JARS:jodreports/jodconverter-2.2.2.jar
JARS=$JARS:jodreports/jodconverter-cli.jar
#JARS=$JARS:jodreports/jodreports-cli.jar
#JARS=$JARS:jodreports/jodreports-2.4.1-with-dependencies.jar
JARS=$JARS:jodreports/jod.jar

JARS=$JARS:jodreports/juh-3.0.1.jar
JARS=$JARS:jodreports/jurt-3.0.1.jar
JARS=$JARS:jodreports/ridl-3.0.1.jar
JARS=$JARS:jodreports/slf4j-api-1.5.6.jar
JARS=$JARS:jodreports/slf4j-jdk14-1.5.6.jar
JARS=$JARS:jodreports/unoil-3.0.1.jar
JARS=$JARS:jodreports/xstream-1.3.1.jar


bazel build //example:main
read
bazel build //example:main-native-linux

bazel-bazel_rules_graal/external/graal/bin/native-image \
	-cp bazel-bin/example/libmain.jar:$JARS \
	-H:Class="Main" \
       	-H:Name=bazel-bin/example/main-native-bin \
	--native-compiler-path=/bin/gcc  \
	--no-fallback \
        --allow-incomplete-classpath \
	--initialize-at-run-time=freemarker.core.ArithmeticEngine \
	--verbose

ls -lh bazel-bin/example/main-native-bin

bazel-bin/example/main-native-bin


#-H:+PrintClassInitialization \
