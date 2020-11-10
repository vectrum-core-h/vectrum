FROM vectrum/vectrum-builder as builder

ARG repo="https://github.com/vectrum-core/vectrum.git"
ARG branch="master"
ARG symbol="VTM"
ARG type="Release"

RUN git clone -b $branch $repo /vectrum && cd /vectrum && \
    git submodule update --init --recursive && \
    echo "$branch:$(git rev-parse HEAD)" > /etc/vectrum-version && \
    mkdir -p build && cd build && \
    cmake -DCMAKE_CXX_COMPILER="clang++-7" -DCMAKE_C_COMPILER="clang-7" \
        -DLLVM_DIR="/usr/lib/llvm-7/lib/cmake/llvm" \
        -DENABLE_MULTIVERSION_PROTOCOL_TEST=true \
        -DCMAKE_INSTALL_PREFIX="/opt/vectrum" \
        -DBUILD_MONGO_DB_PLUGIN=true \
        -DCMAKE_BUILD_TYPE="$type" \
        -DCORE_SYMBOL_NAME="$symbol" .. && \
    JOBS=${JOBS:-"$(getconf _NPROCESSORS_ONLN)"} && make -j$JOBS

RUN cd /vectrum/build/packages && chmod 755 ./*.sh && \
    ./generate_package.sh deb
