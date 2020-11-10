---
content_title: MacOS 10.14
---

This section contains shell commands to manually download, build, install, test, and uninstall VECTRUM and dependencies on MacOS 10.14.

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
brew update && brew install git
# clone VECTRUM Repository
git clone https://github.com/vectrum-core/vectrum.git $VECTRUM_LOCATION
cd $VECTRUM_LOCATION && git submodule update --init --recursive
```

## Install Dependencies
These commands install the VECTRUM software dependencies. Make sure to [Download the VECTRUM Repository](#download-vectrum-repository) first and set the VECTRUM directories.
```sh
# install dependencies
brew install cmake python libtool libusb graphviz automake wget gmp pkgconfig doxygen openssl@1.1 jq boost || :
export PATH=$VECTRUM_INSTALL_LOCATION/bin:$PATH
# install mongodb
mkdir -p $VECTRUM_INSTALL_LOCATION/bin
cd $VECTRUM_INSTALL_LOCATION && curl -OL https://fastdl.mongodb.org/osx/mongodb-osx-ssl-x86_64-3.6.3.tgz
    tar -xzf mongodb-osx-ssl-x86_64-3.6.3.tgz && rm -f mongodb-osx-ssl-x86_64-3.6.3.tgz && \
    mv $VECTRUM_INSTALL_LOCATION/mongodb-osx-x86_64-3.6.3/bin/* $VECTRUM_INSTALL_LOCATION/bin/ && \
    rm -rf $VECTRUM_INSTALL_LOCATION/mongodb-osx-x86_64-3.6.3 && rm -rf $VECTRUM_INSTALL_LOCATION/mongodb-osx-ssl-x86_64-3.6.3.tgz
# install mongo-c-driver from source
cd $VECTRUM_INSTALL_LOCATION && curl -LO https://github.com/mongodb/mongo-c-driver/releases/download/1.13.0/mongo-c-driver-1.13.0.tar.gz && \
    tar -xzf mongo-c-driver-1.13.0.tar.gz && cd mongo-c-driver-1.13.0 && \
    mkdir -p cmake-build && cd cmake-build && \
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$VECTRUM_INSTALL_LOCATION -DENABLE_BSON=ON -DENABLE_SSL=DARWIN -DENABLE_AUTOMATIC_INIT_AND_CLEANUP=OFF -DENABLE_STATIC=ON -DENABLE_ICU=OFF -DENABLE_SASL=OFF -DENABLE_SNAPPY=OFF .. && \
    make -j $(getconf _NPROCESSORS_ONLN) && \
    make install && \
    rm -rf $VECTRUM_INSTALL_LOCATION/mongo-c-driver-1.13.0.tar.gz $VECTRUM_INSTALL_LOCATION/mongo-c-driver-1.13.0
# install mongo-cxx-driver from source
cd $VECTRUM_INSTALL_LOCATION && curl -L https://github.com/mongodb/mongo-cxx-driver/archive/r3.4.0.tar.gz -o mongo-cxx-driver-r3.4.0.tar.gz && \
    tar -xzf mongo-cxx-driver-r3.4.0.tar.gz && cd mongo-cxx-driver-r3.4.0/build && \
    cmake -DBUILD_SHARED_LIBS=OFF -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$VECTRUM_INSTALL_LOCATION .. && \
    make -j $(getconf _NPROCESSORS_ONLN) VERBOSE=1 && \
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
cd $VECTRUM_BUILD_LOCATION && cmake -DCMAKE_BUILD_TYPE='Release' -DCMAKE_INSTALL_PREFIX=$VECTRUM_INSTALL_LOCATION -DBUILD_MONGO_DB_PLUGIN=true $VECTRUM_LOCATION
cd $VECTRUM_BUILD_LOCATION && make -j$(getconf _NPROCESSORS_ONLN)
```

## Install VECTRUM
This command installs the VECTRUM software on the specified OS. Make sure to [Build VECTRUM](#build-vectrum) first.
```sh
cd $VECTRUM_BUILD_LOCATION && make install
```

## Test VECTRUM
These commands validate the VECTRUM software installation on the specified OS. This task is optional but recommended. Make sure to [Install VECTRUM](#install-vectrum) first.
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
