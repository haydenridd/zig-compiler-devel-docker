#!/bin/sh
# Intended to be run from the root of the zig repo after stage3 has already been built
./build/stage3/bin/zig build -p stage4 -Denable-llvm -Dno-lib