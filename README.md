# Developing Zig with Docker

This repo serves as a way to quickly get a development environment setup for developing Zig using Docker. It builds LLVM from source for the version currently used by Zig. This repo currently targets developing Zig using LLVM release 18.1.7.

TODO: Tagging/etc. scheme for different versions of LLVM for compiling different versions of Zig?

## Building Docker Image

Build the image with:
``` shell
docker build --tag [your_tag] .
```

## Building "stage 3" Zig From Source

``` shell
docker run --rm -v "$(pwd)":/workspace -w /workspace [your_tag] ./build_stage3.sh
```

This will start your image, build a zig binary (in release mode) and store it in `build/stage3/zig`. Note that argument `-DZIG_NO_LIB=ON` in `build_stage3.sh` prevents the Zig standard library sources from being copied over to `build/stage3` so that modifications to standard library files take effect immediately without having to "reinstall"! This generally only has to be done when there are large scale changes to the Zig source code. See the next stage for the flow you will generally use when re-compiling Zig and testing local changes you've made.

## Building "stage 4" Zig Using "stage 3" Zig

``` shell
docker run --rm -v "$(pwd)":/workspace -w /workspace [your_tag] ./build_stage4.sh
```

This is the reccomended flow for the quickest way to test changes you've made to the compiler. It uses the zig binary `build/stage3/zig` to rebuild Zig and create `stage4/zig`.

## More Info
- You do not have to use `build_stage3.sh` or `build_stage4.sh` if you don't want to, they're merely provided as example commands to build Zig taken directly from:
    - https://github.com/ziglang/zig/wiki/Building-Zig-From-Source
- This image builds LLVM in release mode, which is reccomended unless you need a debug build for low level LLVM debugging, see the following for more info:
    - https://github.com/ziglang/zig/wiki/How-to-build-LLVM,-libclang,-and-liblld-from-source#posix
- The image provides the ENV variable $LLVM_INSTALL_PATH as a convenience for where the build LLVM artifacts are installed