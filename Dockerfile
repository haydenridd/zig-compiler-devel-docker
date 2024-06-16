# syntax=docker/dockerfile:1
FROM fedora:37

# Install Dependencies
RUN dnf install -y \
    ninja-build \
    make \
    cmake \
    git \
    gcc \
    libgcc \
    gcc-c++ \
    libstdc++-static
    
RUN git clone --depth 1 --branch llvmorg-18.1.7 https://github.com/llvm/llvm-project llvm-project-18
RUN cmake -B ./llvm-project-18/build-release -S ./llvm-project-18/llvm \
  -DCMAKE_INSTALL_PREFIX=/home/local/llvm18-release \
  -DCMAKE_BUILD_TYPE=Release \
  -DLLVM_ENABLE_PROJECTS="lld;clang" \
  -DLLVM_ENABLE_LIBXML2=OFF \
  -DLLVM_ENABLE_TERMINFO=OFF \
  -DLLVM_ENABLE_LIBEDIT=OFF \
  -DLLVM_ENABLE_ASSERTIONS=ON \
  -DLLVM_PARALLEL_LINK_JOBS=1 \
  -G Ninja
RUN ninja -C ./llvm-project-18/build-release install

# Handy ENV variable pointing to installed LLVM binaries
ENV LLVM_INSTALL_PATH="/home/local/llvm18-release"
