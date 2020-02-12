
#Prefix "graalvm-ce-java11-20.1.0" was given, but not found in the archive. 
# Here are possible prefixes for this archive: "graalvm-ce-java11-20.1.0-dev"

_graal_archive_internal_prefixs = {
    "darwin-amd64": "graalvm-ce-java{java_version}-{version}{slash_dev}/Contents/Home",
    "linux-amd64": "graalvm-ce-java{java_version}-{version}{slash_dev}",
    "windows-amd64": "graalvm-ce-java{java_version}-{version}{slash_dev}",
}


#https://github.com/graalvm/graalvm-ce-dev-builds/releases/download/20.1.0-dev-20200212_0349/graalvm-ce-java11-windows-amd64-20.1.0-dev.zip

#0d745be86b7711ac6df81fa631e6f577f987a9a1dff2008dc26ffbf5d34f8ab9  graalvm-ce-java11-linux-amd64-20.1.0-dev.tar.gz
#26c98569fd2b2c9f9188b35c477c1245d522ae770091fe96ef1e61138328297f  graalvm-ce-java11-windows-amd64-20.1.0-dev.zip


_graal_version_configs = {

    "20.1.0": {
        "urls": ["https://github.com/graalvm/graalvm-ce-dev-builds/releases/download/{version}-dev-20200212_0349/graalvm-ce-java{java_version}-{platform}-{version}-dev.{extension}"],
        "sha": {
            "8": {
                "windows-amd64": "0",
                "linux-amd64": "0",
            },
            "11": {
                "windows-amd64": "26c98569fd2b2c9f9188b35c477c1245d522ae770091fe96ef1e61138328297f",
                "linux-amd64": "0d745be86b7711ac6df81fa631e6f577f987a9a1dff2008dc26ffbf5d34f8ab9",
            },
        },
    },
    "19.0.0": {
        "urls": ["https://github.com/oracle/graal/releases/download/vm-{version}/graalvm-ce-{platform}-{version}.tar.gz"],
        "sha": {
            "8": {
                "darwin-amd64": "fc652566e61b9b774c120da1aea0ae3e28f198d55a297524dcc97b9a83525a79",
                "linux-amd64": "7ad124cdb19cbaa962f6d2f26d1e3eccfeb93afabbf8e81cb65976519f15730c",
            },
        },
    },
    "19.3.1": {
        "urls": ["https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-{version}/graalvm-ce-java{java_version}-{platform}-{version}.{extension}"],
        "sha": {
            "8": {
                "windows-amd64": "77eb35e88eee297bbaa63ca9856379d0ec31953370c8ea5168c8ee091b656a9f",
                "darwin-amd64": "eba3765174f0279ae2dc57c84fc0eb324da778dbfdcc03c6fa8381fe3728aef9",
                "linux-amd64": "815385a1c35a1db54b9b9622059c9e8e5155460f65c3d713e55d3a84222c9194",
            },
            "11": {
                "darwin-amd64": "b3ea6cf6545332f667b2cc742bbff9949d47e49eecea06334d14f0b69aa1a3f3",
                "linux-amd64": "691f0577c75c4ba0fb50916087925e6eb8a5a73de51994a37eee022d1e2c9e7d",
            },
        },
    }
}

_graal_native_image_version_configs = {
    #https://github.com/graalvm/graalvm-ce-dev-builds/releases/download/20.1.0-dev-20200212_0349/native-image-installable-svm-java11-windows-amd64-20.1.0-dev.jar

   #508b3c448fd1329f1d5347fce014f7bf30b0d8d396f3fdec34e357963ca5cf9f  native-image-installable-svm-java11-linux-amd64-20.1.0-dev.jar
   #f3fd4a81da5961025b2b511714e9447431f0af3260c24e94f01ce0e46bc3446f  native-image-installable-svm-java11-windows-amd64-20.1.0-dev.jar

    "20.1.0": {
        "urls": ["https://github.com/graalvm/graalvm-ce-dev-builds/releases/download/{version}-dev-20200212_0349/native-image-installable-svm-java{java_version}-{platform}-{version}{slash_dev}.jar"],
        "sha": {
            "8": {
                "darwin-amd64": "0",
                "linux-amd64": "0",
            },
            "11": {
                "windows-amd64": "f3fd4a81da5961025b2b511714e9447431f0af3260c24e94f01ce0e46bc3446f",
                "linux-amd64": "508b3c448fd1329f1d5347fce014f7bf30b0d8d396f3fdec34e357963ca5cf9f",
            },
        },
    },
    "19.0.0": {
        "urls": ["https://github.com/oracle/graal/releases/download/vm-{version}/native-image-installable-svm-{platform}-{version}.jar"],
        "sha": {
            "8": {
                "darwin-amd64": "4fa035b31cfd3d86d464e9a67b652c69a0cceb88c6b2f2ce629c55ca2113c786",
                "linux-amd64": "1c794a3c038f4e6bb90542cf13ba3c6c793dcd193462bf56b8713fd24386e344",
            },
        },
    },
    "19.3.1": {
        "urls": ["https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-{version}/native-image-installable-svm-java{java_version}-{platform}-{version}.jar"],
        "sha": {
            "8": {
                "darwin-amd64": "266d295456dfc588fae52ef2c26cd7e745e6fa0681271e677cad2dd9a1b09461",
                "linux-amd64": "3fd2e5b5299c8ce7c939235b4d01df990aeb236f127f98fbf19b588c521793fa",
            },
            "11": {
                "darwin-amd64": "6bd2bace9773a2ac7ff8182a36f84507678e71f94bf3f0c4646a091100644e13",
                "linux-amd64": "fef2e2c71a5408855026e022ae15fda50cb52769aa7d0ec008837f49196ee16a",
            },
        },
    }
}

def _get_platform(ctx):
    if ctx.os.name == "linux":
        return "linux-amd64"
    elif ctx.os.name == "mac os x":
        return "darwin-amd64"
    elif ctx.os.name == "windows 10":
        return "windows-amd64"
    else:
        fail("Unsupported operating system: " + ctx.os.name)

def _graal_bindist_repository_impl(ctx):
    platform = _get_platform(ctx)
    version = ctx.attr.version
    extension = "tar.gz"
    cmd_dot_extension = ""
    gu_cmd = "bin/gu" 

    if platform == "windows-amd64":
       extension = "zip"
       gu_cmd = "bin/gu.cmd"
       
    java_version = ctx.attr.java_version
    format_args = {
        "version": version,
        "platform": platform,
        "java_version": java_version,
	    "extension": extension,
        "slash_dev": ctx.attr.slash_dev
    }

    #Download graal
    config = _graal_version_configs[version]
    sha = config["sha"][java_version][platform]
    urls = [url.format(**format_args) for url in config["urls"]]
    archive_internal_prefix = _graal_archive_internal_prefixs[platform].format(**format_args)

    ctx.download_and_extract(
        url = urls,
        sha256 = sha,
        stripPrefix = archive_internal_prefix,
    )

    #if platform == "windows-amd64":
    #    print("windows native-image not needed")
    #else:
    if True:
        print("getting native-image ...")
        # download native image
        native_image_config = _graal_native_image_version_configs[version]
        native_image_sha = native_image_config["sha"][java_version][platform]
        native_image_urls = [url.format(**format_args) for url in native_image_config["urls"]]

        ctx.download(
            url = native_image_urls,
            sha256 = native_image_sha,
            output = "native-image-installer.jar"
        )

        exec_result = ctx.execute([gu_cmd, "install", "--local-file", "native-image-installer.jar"], quiet=False)
        if exec_result.return_code != 0:
            fail("Unable to install native image:\n{stdout}\n{stderr}".format(stdout=exec_result.stdout, stderr=exec_result.stderr))

    ctx.file("BUILD", """exports_files(glob(["**/*"]))""")
    ctx.file("WORKSPACE", "workspace(name = \"{name}\")".format(name = ctx.name))
    print("ctx.name=" + ctx.name)


graal_bindist_repository = repository_rule(
    attrs = {
        "version": attr.string(mandatory = True),
        "java_version": attr.string(mandatory = True),
        "slash_dev": attr.string(mandatory = True)
    },
    implementation = _graal_bindist_repository_impl,
)
