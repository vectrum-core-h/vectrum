---
content_title: Ubuntu 18.04
---

This section contains shell commands to manually download, build, install, test, and uninstall VECTRUM and dependencies on Ubuntu 18.04.

[[info | Building VECTRUM is for Advanced Developers]]
| If you are new to VECTRUM, it is recommended that you install the [VECTRUM Prebuilt Binaries](../../../00_install-prebuilt-binaries.md) instead of building from source.

Select a task below, then copy/paste the shell commands to a Unix terminal to execute:

* [Download VECTRUM Repository](#download-vectrum-repository)
* [Install VECTRUM Dependencies](#install-vectrum-dependencies)
* [Build VECTRUM](#build-vectrum)
* [Install VECTRUM](#install-vectrum)
* [Test VECTRUM](#test-vectrum)
* [Uninstall VECTRUM](#uninstall-vectrum)

[[info | Building VECTRUM on another OS?]]
| Visit the [Build VECTRUM from Source](../../index.md) section.

## Download VECTRUM Repository
These commands set the VECTRUM directories, install git, and clone the VECTRUM Repository.
```sh
# set VECTRUM directories
export VECTRUM_LOCATION=~/vectrum-core/vectrum
export VECTRUM_INSTALL_LOCATION=$VECTRUM_LOCATION/../install
mkdir -p $VECTRUM_INSTALL_LOCATION
# install git
apt-get update && apt-get upgrade -y && DEBIAN_FRONTEND=noninteractive apt-get install -y git
# clone VECTRUM Repository
git clone https://github.com/vectrum-core/vectrum.git $VECTRUM_LOCATION
cd $VECTRUM_LOCATION && git submodule update --init --recursive
```

## Install VECTRUM Dependencies
These commands install the VECTRUM software dependencies. Make sure to [Download the VECTRUM Repository](#download-vectrum-repository) first and set the VECTRUM directories.
```sh
# install dependencies
apt-get install -y make bzip2 automake libbz2-dev libssl-dev doxygen graphviz libgmp3-dev \
    autotools-dev libicu-dev python2.7 python2.7-dev python3 python3-dev \
    autoconf libtool curl zlib1g-dev sudo ruby libusb-1.0-0-dev \
    libcurl4-gnutls-dev pkg-config patch llvm-7-dev clang-7 vim-common jq
# build cmake
export PATH=$VECTRUM_INSTALL_LOCATION/bin:$PATH
cd $VECTRUM_INSTALL_LOCATION && curl -LO https://cmake.org/files/v3.13/cmake-3.13.2.tar.gz && \
    tar -xzf cmake-3.13.2.tar.gz && \
    cd cmake-3.13.2 && \
    ./bootstrap --prefix=$VECTRUM_INSTALL_LOCATION && \
    make -j$(nproc) && \
    make install && \
    rm -rf $VECTRUM_INSTALL_LOCATION/cmake-3.13.2.tar.gz $VECTRUM_INSTALL_LOCATION/cmake-3.13.2
# build boost
cd $VECTRUM_INSTALL_LOCATION && curl -OL https://boostorg.jfrog.io/artifactory/main/release/1.71.0/source/boost_1_71_0.tar.bz2 && \
    tar -xjf boost_1_71_0.tar.bz2 && \
    cd boost_1_71_0 && \
    ./bootstrap.sh --prefix=$VECTRUM_INSTALL_LOCATION && \
    ./b2 --with-iostreams --with-date_time --with-filesystem --with-system --with-program_options --with-chrono --with-test -q -j$(nproc) install && \
    rm -rf $VECTRUM_INSTALL_LOCATION/boost_1_71_0.tar.bz2 $VECTRUM_INSTALL_LOCATION/boost_1_71_0
# build mongodb
cd $VECTRUM_INSTALL_LOCATION && curl -LO https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-ubuntu1804-4.1.1.tgz && \
    tar -xzf mongodb-linux-x86_64-ubuntu1804-4.1.1.tgz && rm -f mongodb-linux-x86_64-ubuntu1804-4.1.1.tgz && \
    mv $VECTRUM_INSTALL_LOCATION/mongodb-linux-x86_64-ubuntu1804-4.1.1/bin/* $VECTRUM_INSTALL_LOCATION/bin/ && \
    rm -rf $VECTRUM_INSTALL_LOCATION/mongodb-linux-x86_64-ubuntu1804-4.1.1
# build mongodb c driver
cd $VECTRUM_INSTALL_LOCATION && curl -LO https://github.com/mongodb/mongo-c-driver/releases/download/1.13.0/mongo-c-driver-1.13.0.tar.gz && \
    tar -xzf mongo-c-driver-1.13.0.tar.gz && cd mongo-c-driver-1.13.0 && \
    mkdir -p build && cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$VECTRUM_INSTALL_LOCATION -DENABLE_BSON=ON -DENABLE_SSL=OPENSSL -DENABLE_AUTOMATIC_INIT_AND_CLEANUP=OFF -DENABLE_STATIC=ON -DENABLE_ICU=OFF -DENABLE_SNAPPY=OFF .. && \
    make -j$(nproc) && \
    make install && \
    rm -rf $VECTRUM_INSTALL_LOCATION/mongo-c-driver-1.13.0.tar.gz $VECTRUM_INSTALL_LOCATION/mongo-c-driver-1.13.0
# build mongodb cxx driver
cd $VECTRUM_INSTALL_LOCATION && curl -L https://github.com/mongodb/mongo-cxx-driver/archive/r3.4.0.tar.gz -o mongo-cxx-driver-r3.4.0.tar.gz && \
    tar -xzf mongo-cxx-driver-r3.4.0.tar.gz && cd mongo-cxx-driver-r3.4.0 && \
    sed -i 's/\"maxAwaitTimeMS\", count/\"maxAwaitTimeMS\", static_cast<int64_t>(count)/' src/mongocxx/options/change_stream.cpp && \
    sed -i 's/add_subdirectory(test)//' src/mongocxx/CMakeLists.txt src/bsoncxx/CMakeLists.txt && \
    mkdir -p build && cd build && \
    cmake -DBUILD_SHARED_LIBS=OFF -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$VECTRUM_INSTALL_LOCATION .. && \
    make -j$(nproc) && \
    make install && \
    rm -rf $VECTRUM_INSTALL_LOCATION/mongo-cxx-driver-r3.4.0.tar.gz $VECTRUM_INSTALL_LOCATION/mongo-cxx-driver-r3.4.0
```

## Build VECTRUM
These commands build the VECTRUM software on the specified OS. Make sure to [Install VECTRUM Dependencies](#install-vectrum-dependencies) first.

[[caution | `VECTRUM_BUILD_LOCATION` environment variable]]
| Do NOT change this variable. It is set for convenience only. It should always be set to the `build` folder within the cloned repository.

```sh
export VECTRUM_BUILD_LOCATION=$VECTRUM_LOCATION/build
mkdir -p $VECTRUM_BUILD_LOCATION
cd $VECTRUM_BUILD_LOCATION && cmake -DCMAKE_BUILD_TYPE='Release' -DCMAKE_CXX_COMPILER='clang++-7' -DCMAKE_C_COMPILER='clang-7' -DLLVM_DIR='/usr/lib/llvm-7/lib/cmake/llvm' -DCMAKE_INSTALL_PREFIX=$VECTRUM_INSTALL_LOCATION -DBUILD_MONGO_DB_PLUGIN=true $VECTRUM_LOCATION
cd $VECTRUM_BUILD_LOCATION && make -j$(nproc)
```

## Install VECTRUM
This command installs the VECTRUM software on the specified OS. Make sure to [Build VECTRUM](#build-vectrum) first.
```sh
cd $VECTRUM_BUILD_LOCATION && make install
```

## Test VECTRUM
These commands validate the VECTRUM software installation on the specified OS. Make sure to [Install VECTRUM](#install-vectrum) first. (**Note**: This task is optional but recommended.)
```sh
$VECTRUM_INSTALL_LOCATION/bin/mongod --fork --logpath $(pwd)/mongod.log --dbpath $(pwd)/mongodata
cd $VECTRUM_BUILD_LOCATION && make test
```

## Uninstall VECTRUM
These commands uninstall the VECTRUM software from the specified OS.
```sh
xargs rm < $VECTRUM_BUILD_LOCATION/install_manifest.txt
rm -rf $VECTRUM_BUILD_LOCATION
```
