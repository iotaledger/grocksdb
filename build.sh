#!/bin/bash
set -eo pipefail

DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

INSTALL_PREFIX=$1

BUILD_FLAGS="-fPIC -O3 -pipe"

BUILD_PATH=/tmp/build
mkdir -p $BUILD_PATH

CMAKE_REQUIRED_PARAMS="-DCMAKE_POSITION_INDEPENDENT_CODE=ON -DCMAKE_INSTALL_PREFIX=${INSTALL_PREFIX} -DPORTABLE=1 -DWITH_CORE_TOOLS=OFF"
TARGET_SYS="Unknown"

if [ "$GOARCH" == "arm64" ]; then
    TARGET_SYS="Linux ARM64"
    export DIST_DIR=${INSTALL_PREFIX}
    CMAKE_REQUIRED_PARAMS="-DCMAKE_TOOLCHAIN_FILE=${DIRECTORY}/arm64.cmake ${CMAKE_REQUIRED_PARAMS}"
else
    TARGET_SYS="Linux AMD64"
    if [ "$GOOS" == "windows" ]; then
        TARGET_SYS="Windows AMD64"
        export DIST_DIR=${INSTALL_PREFIX}
        BUILD_FLAGS="-Wno-cast-function-type -Wno-error=cast-function-type ${BUILD_FLAGS}"
        CMAKE_REQUIRED_PARAMS="-DROCKSDB_INSTALL_ON_WINDOWS=ON -DCMAKE_TOOLCHAIN_FILE=${DIRECTORY}/win64.cmake ${CMAKE_REQUIRED_PARAMS}"
    fi
fi

export CFLAGS=${BUILD_FLAGS}
export CXXFLAGS=${BUILD_FLAGS}

echo "Building rocksdb for ${TARGET_SYS}..."

rocksdb_version="6.19.3"
cd $BUILD_PATH && wget https://github.com/facebook/rocksdb/archive/v${rocksdb_version}.tar.gz && tar xzf v${rocksdb_version}.tar.gz && cd rocksdb-${rocksdb_version}/ && \
    mkdir -p build_place && cd build_place && cmake -DCMAKE_BUILD_TYPE=Release $CMAKE_REQUIRED_PARAMS -DCMAKE_PREFIX_PATH=$INSTALL_PREFIX -DWITH_TESTS=OFF -DWITH_GFLAGS=OFF \
    -DWITH_BENCHMARK_TOOLS=OFF -DWITH_TOOLS=OFF -DWITH_MD_LIBRARY=OFF -DWITH_RUNTIME_DEBUG=OFF -DROCKSDB_BUILD_SHARED=OFF -DWITH_SNAPPY=OFF -DWITH_LZ4=OFF -DWITH_ZLIB=OFF \
    -DWITH_ZSTD=OFF -DWITH_BZ2=OFF -WITH_GFLAGS=OFF .. && make -j16 install/strip && \
    cd $BUILD_PATH && rm -rf *

rm -rf $INSTALL_PREFIX/bin $INSTALL_PREFIX/share $INSTALL_PREFIX/lib/cmake $INSTALL_PREFIX/lib64/cmake $INSTALL_PREFIX/lib/pkgconfig $INSTALL_PREFIX/lib64/pkgconfig
