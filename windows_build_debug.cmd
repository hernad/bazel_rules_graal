bazel-bazel_rules_graal\external\graal\bin\native-image.cmd ^
  -cp bazel-out/x64_windows-fastbuild/bin/example/libmain.jar ^
  -H:Class="Main" -H:Name="bazel-out/x64_windows-fastbuild/bin/example/main-native-bin" ^
  -H:+ReportExceptionStackTraces ^
  --native-compiler-options="-DHERNAD=1 c:\users\hernad\bazel_rules_graal\legacy_stdio_definitions.lib" ^
  --verbose

REM /NODEFAULTLIB:msvcrt" ^
  