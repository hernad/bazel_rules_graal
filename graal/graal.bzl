load("@bazel_tools//tools/cpp:toolchain_utils.bzl", "find_cpp_toolchain")
load(
    "@bazel_tools//tools/build_defs/cc:action_names.bzl",
    "ASSEMBLE_ACTION_NAME",
    "CPP_COMPILE_ACTION_NAME",
    "CPP_LINK_DYNAMIC_LIBRARY_ACTION_NAME",
    "CPP_LINK_EXECUTABLE_ACTION_NAME",
    "CPP_LINK_STATIC_LIBRARY_ACTION_NAME",
    "C_COMPILE_ACTION_NAME",
    "OBJCPP_COMPILE_ACTION_NAME",
    "OBJC_COMPILE_ACTION_NAME",
)


def _graal_binary_implementation(ctx):
    graal_attr = ctx.attr._graal
    graal_inputs, _, _ = ctx.resolve_command(tools = [graal_attr])
    graal = graal_inputs[0]

    classpath_depset = depset(transitive = [
        dep[JavaInfo].transitive_runtime_jars
        for dep in ctx.attr.deps
        if JavaInfo in dep
    ])

    cc_toolchain = find_cpp_toolchain(ctx)
    feature_configuration = cc_common.configure_features(
        ctx = ctx,
        cc_toolchain = cc_toolchain,
        requested_features = ctx.features,
        unsupported_features = ctx.disabled_features,
    )
    c_compiler_path = cc_common.get_tool_for_action(
        feature_configuration = feature_configuration,
        action_name = C_COMPILE_ACTION_NAME,
    )
    ld_executable_path = cc_common.get_tool_for_action(
        feature_configuration = feature_configuration,
        action_name = CPP_LINK_EXECUTABLE_ACTION_NAME,
    )
    ld_static_lib_path = cc_common.get_tool_for_action(
        feature_configuration = feature_configuration,
        action_name = CPP_LINK_STATIC_LIBRARY_ACTION_NAME,
    )
    ld_dynamic_lib_path = cc_common.get_tool_for_action(
        feature_configuration = feature_configuration,
        action_name = CPP_LINK_DYNAMIC_LIBRARY_ACTION_NAME,
    )

    tool_paths = [c_compiler_path, ld_executable_path, ld_static_lib_path, ld_dynamic_lib_path]
    path_set = {}

    windows = False
    if ctx.configuration.host_path_separator == ":":
       slash = "/"
    else:
       slash = "\\"
       windows = True

    for tool_path in tool_paths:
        print("tool_path=" + tool_path)
        # https://docs.bazel.build/versions/master/skylark/lib/string.html#rpartition
        tool_dir, _, _ = tool_path.rpartition(slash)
        path_set[tool_dir] = None

    paths = sorted(path_set.keys())
    if ctx.configuration.host_path_separator == ":":
        # HACK: ":" is a proxy for a UNIX-like host.
        # The tools returned above may be bash scripts that reference commands
        # in directories we might not otherwise include. For example,
        # on macOS, wrapped_ar calls dirname.
        if "/bin" not in path_set:
            paths.append( "/bin")
            if "/usr/bin" not in path_set:
                paths.append("/usr/bin")
    else:
        print("windows system")
        paths.append( "c:/windows/system32")
        paths.append( "c:/windows")

    
    env = {}
    env["PATH"] = ctx.configuration.host_path_separator.join(paths)

    args = ctx.actions.args()
    
    #    
    #$ bazel-bazel_rules_graal/external/graal/bin/native-image  --help
    #
    #GraalVM native-image building tool
    #
    #This tool can be used to generate an image that contains ahead-of-time compiled Java code.
    #
    #Usage: native-image [options] class [imagename] [options]
    #           (to build an image for a class)
    #   or  native-image [options] -jar jarfile [imagename] [options]
    #           (to build an image for a jar file)
    #where options include:
    #    -cp <class search path of directories and zip/jar files>
    #    -classpath <class search path of directories and zip/jar files>
    #    --class-path <class search path of directories and zip/jar files>
    #                          A : separated list of directories, JAR archives,
    #                          and ZIP archives to search for class files.
    #    -D<name>=<value>      set a system property
    #    -J<flag>              pass <flag> directly to the JVM running the image generator
    #    -O<level>             0 - no optimizations, 1 - basic optimizations (default).
    #    --verbose             enable verbose output
    #    --version             print product version and exit
    #    --help                print this help message
    #    --help-extra          print help on non-standard options
    #
    #    --allow-incomplete-classpath
    #                          allow image building with an incomplete class path: report type
    #                          resolution errors at run time when they are accessed the first
    #                          time, instead of during image building
    #    --auto-fallback       build stand-alone image if possible
    #    --enable-all-security-services
    #                          add all security service classes to the generated image.
    #    --enable-http         enable http support in the generated image
    #    --enable-https        enable https support in the generated image
    #    --enable-url-protocols
    #                          list of comma separated URL protocols to enable.
    #    --features            a comma-separated list of fully qualified Feature implementation
    #                          classes
    #    --force-fallback      force building of fallback image
    #    --initialize-at-build-time
    #                          a comma-separated list of packages and classes (and implicitly all
    #                          of their superclasses) that are initialized during image
    #                          generation. An empty string designates all packages.
    #    --initialize-at-run-time
    #                          a comma-separated list of packages and classes (and implicitly all
    #                          of their subclasses) that must be initialized at runtime and not
    #                          during image building. An empty string is currently not
    #                          supported.
    #    --no-fallback         build stand-alone image or report failure
    #    --report-unsupported-elements-at-runtime
    #                          report usage of unsupported methods and fields at run time when
    #                          they are accessed the first time, instead of as an error during
    #                          image building
    #    --shared              build shared library
    #    --static              build statically linked executable (requires static libc and zlib)
    #    -da                   disable assertions in the generated image
    #    -ea                   enable assertions in the generated image
    #
    #Available macro-options are:
    #    --language:nfi
    #    --language:js
    #    --language:regex
    #    --language:llvm
    #    --tool:coverage
    #    --tool:profiler
    #    --tool:chromeinspector
    #    --tool:agentscript


    # bazel-bazel_rules_graal/external/graal/bin/native-image  --expert-options
    #-H:±AllowIncompleteClasspath                 Allow image building with an incomplete class path: report type resolution errors at run time when they are accessed the
    #                                             first time, instead of during image building. Default: - (disabled).
    #-H:±AllowVMInspection                        Enables features that allow the VM to be inspected during runtime. Default: - (disabled).
    #-H:CCompilerOption=...                       Provide custom C compiler option used for query code compilation. Default: None
    #-H:CCompilerPath=...                         Provide custom path to C compiler used for query code compilation and linking. Default: None
    #-H:CPUFeatures=...                           Comma separated list of CPU features that will be used for image generation on the AMD64 platform. Features SSE and SSE2
    #                                             are enabled by default. Other available features are: CX8, CMOV, FXSR, HT, MMX, AMD_3DNOW_PREFETCH, SSE3, SSSE3, SSE4A,
    #                                             SSE4_1, SSE4_2, POPCNT, LZCNT, TSC, TSCINV, AVX, AVX2, AES, ERMS, CLMUL, BMI1, BMI2, RTM, ADX, AVX512F, AVX512DQ,
    #                                             AVX512PF, AVX512ER, AVX512CD, AVX512BW. Default: None
    #-H:CStandard="C89"                           C standard to use in header files. Possible values are: [C89, C99, C11].
    #-H:Class=""                                  Class containing the default entry point method. Optional if --shared is used.
    #-H:ClassInitialization=...                   A comma-separated list of classes appended with their initialization strategy (':build_time', ':rerun', or ':run_time').
    #                                             Default: None
    #-H:CompilerBackend="lir"                     Backend used by the compiler.
    #-H:ConfigurationFileDirectories=...          Directories directly containing configuration files for dynamic features at runtime. Default: None
    #-H:ConfigurationResourceRoots=...            Resource path above configuration resources for dynamic features at runtime. Default: None
    #-H:DynamicProxyConfigurationFiles=...        One or several (comma-separated) paths to JSON files that specify lists of interfaces that define Java proxy classes.
    #                                             Default: None
    #-H:DynamicProxyConfigurationResources=...    Resources describing program elements to be made available for reflection (see ProxyConfigurationFiles). Default: None
    #-H:IncludeResourceBundles=...                Comma separated list of bundles to be included into the image. Default: None
    #-H:IncludeResources=...                      Regexp to match names of resources to be included in the image. Default: None
    #-H:JNIConfigurationFiles=...                 Files describing program elements to be made accessible via JNI (for syntax, see ReflectionConfigurationFiles). Default:
    #                                             None
    #-H:JNIConfigurationResources=...             Resources describing program elements to be made accessible via JNI (see JNIConfigurationFiles). Default: None
    #-H:±JNIVerboseLookupErrors                   Report information about known JNI elements when lookup fails. Default: - (disabled).
    #-H:Name=""                                   Name of the output file to be generated.
    #-H:±NativeArchitecture                       Overrides CPUFeatures and uses the native architecture, i.e., the architecture of a machine that builds an image.
    #                                             NativeArchitecture takes precedence over CPUFeatures. Default: - (disabled).
    #-H:Optimize=2                                Control native-image code optimizations: 0 - no optimizations, 1 - basic optimizations, 2 - aggressive optimizations.
    #-H:Path="/home/hernad/bazel_rules_graal/svmbuild"
    #                                             Directory of the image file to be generated.
    #-H:ReflectionConfigurationFiles=...          One or several (comma-separated) paths to JSON files that specify which program elements should be made available via
    #                                             reflection. Default: None
    #-H:ReflectionConfigurationResources=...      Resources describing program elements to be made available for reflection (see ReflectionConfigurationFiles). Default:
    #                                             None
    #-H:±ReportUnsupportedElementsAtRuntime       Report usage of unsupported methods and fields at run time when they are accessed the first time, instead of as an error
    #                                             during image building. Default: - (disabled).
    #-H:ResourceConfigurationFiles=...            Files describing Java resources to be included in the image. Default: None
    #-H:ResourceConfigurationResources=...        Resources describing Java resources to be included in the image. Default: None
    #-H:±RuntimeAssertions                        Enable or disable Java assert statements at run time. Default: - (disabled).
    #-H:SubstitutionFiles=...                     Comma-separated list of file names with declarative substitutions. Default: None
    #-H:SubstitutionResources=...                 Comma-separated list of resource file names with declarative substitutions. Default: None


    
    #args.add("--no-server")

    args.add("-cp", ":".join([f.path for f in classpath_depset.to_list()]))
    args.add("-H:Class=%s" % ctx.attr.main_class)
    args.add("-H:Name=%s" % ctx.outputs.bin.path)

    if windows:
        args.add("-H:CCompilerPath=\"%s\"" % c_compiler_path)
    else:
        args.add("-H:CCompilerPath=%s" % c_compiler_path)
        

    args.add("--verbose")

    print(args)

    if len(ctx.attr.native_image_features) > 0:
        args.add("-H:Features={entries}".format(entries=",".join(ctx.attr.native_image_features)))

    # --initialize-at-build-time
    #                      a comma-separated list of packages and classes (and implicitly all
    #                      of their superclasses) that are initialized during image
    #                      generation. An empty string designates all packages.

    if len(ctx.attr.initialize_at_build_time) > 0:
        args.add("--initialize-at-build-time={entries}".format(entries=",".join(ctx.attr.initialize_at_build_time)))

    if ctx.attr.reflection_configuration != None:
        args.add("-H:ReflectionConfigurationFiles={path}".format(path=ctx.file.reflection_configuration.path))
        classpath_depset = depset([ctx.file.reflection_configuration], transitive=[classpath_depset])


    ctx.actions.run(
        inputs = classpath_depset,
        outputs = [ctx.outputs.bin],
        arguments = [args],
        executable = graal,
        env = env,
    )

    
    return [DefaultInfo(
        executable = ctx.outputs.bin,
        files = depset(),
        runfiles = ctx.runfiles(
            collect_data = True,
            collect_default = True,
            files = [],
        ),
    )]


def _graal_native_image():
    #return "native-image.cmd"
    return "native-image"



#g_graal_native_image = select({
#        "@platforms//os:windows": "native-image.cmd",
#        "@platforms//os:linux": "native-image",
#        "@platforms//os:darwin": "native-image"
#    })

graal_binary = rule(
    implementation = _graal_binary_implementation,
    attrs = {
        "deps": attr.label_list(
            allow_files = True,
        ),
        "reflection_configuration": attr.label(mandatory=False, allow_single_file=True),
        "main_class": attr.string(),
        "initialize_at_build_time": attr.string_list(),
        "native_image_features": attr.string_list(),
        "_graal": attr.label(
            cfg = "host",
            default = "@graal//:bin/" + _graal_native_image(),
            allow_files = True,
            executable = True,
        ),
        "_cc_toolchain": attr.label(
            default = Label("@bazel_tools//tools/cpp:current_cc_toolchain")
        ),
        "data": attr.label_list(allow_files = True),
    },
    outputs = {
        "bin": "%{name}-bin",
    },
    executable = True,
    fragments = ["cpp"],
)

