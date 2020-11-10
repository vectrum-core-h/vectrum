---
content_title: VECTRUM Software Dependencies
---

The VECTRUM software requires specific software dependencies to build the VECTRUM binaries. These dependencies can be built from source or installed from binaries directly. Dependencies can be pinned to a specific version release or unpinned to the current version, usually the latest one. The main VECTRUM Dependencies hosted outside the VECTRUM repos are:

* Clang - the C++17 compliant compiler used by VECTRUM
* CMake - the build system used by VECTRUM
* Boost - the C++ Boost library used by VECTRUM
* OpenSSL - the secure communications (and crypto) library
* LLVM - the LLVM compiler/toolchain infrastructure

Other dependencies are either inside the VECTRUM repo, such as the `secp256k1` elliptic curve DSA library, or they are otherwise used for testing or housekeeping purposes, such as:

* automake, autoconf, autotools
* doxygen, graphviz
* python2, python3
* bzip2, zlib
* etc.

## Pinned Dependencies

To guarantee interoperability across different VECTRUM software releases, developers may opt to reproduce the exact "pinned" dependency binaries used in-house. Block producers may want to install and run the VECTRUM software built with these pinned dependencies for portability and stability reasons. Pinned dependencies are usually built from source.

## Unpinned Dependencies

Regular users or application developers may prefer installing unpinned versions of the VECTRUM Dependencies. These correspond to the latest or otherwise stable versions of the dependencies. The main advantage of unpinned dependencies is reduced installation times and perhaps better performance. Pinned dependencies are typically installed from binaries.

## Automatic Installation of Dependencies

VECTRUM Dependencies can be built or installed automatically from the [Build Script](../01_shell-scripts/02_build-binaries.md) when building VECTRUM from source. To build the pinned dependencies, the optional `-P` parameter can be specified when invoking the script. Otherwise, the unpinned dependencies will be installed instead, with the exception of `boost` and `cmake` which are always pinned:

```sh
cd ~/vectrum-core/vectrum
./build.sh [-P]
```

### Unupported Platforms

VECTRUM Dependencies can also be built and installed manually by reproducing the same commands invoked by the [Build Script](../01_shell-scripts/02_build-binaries.md). The actual commands can be generated from the script directly by exporting specific environment variables and CLI parameters to the script when invoked:

```sh
cd ~/vectrum-core/vectrum
export VERBOSE=true && export DRYRUN=true && ./build.sh -y [-P]
```
