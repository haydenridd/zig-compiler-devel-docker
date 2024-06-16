#!/bin/sh
# Intended to be run from the root of the zig repo
cmake -B build -S . -DCMAKE_BUILD_TYPE=Release -DZIG_NO_LIB=ON -G Ninja -DCMAKE_PREFIX_PATH=$LLVM_INSTALL_PATH
ninja -C build install