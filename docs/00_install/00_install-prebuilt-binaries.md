---
content_title: Install Prebuilt Binaries
---

[[info | Previous Builds]]
| If you have previously installed VECTRUM from source using shell scripts, you must first run the [Uninstall Script](./01_build-from-source/01_shell-scripts/05_uninstall.md) before installing any prebuilt binaries on the same OS.

## Prebuilt Binaries

Prebuilt VECTRUM software packages are available for the operating systems below. Find and follow the instructions for your OS:

### Mac OS X:

#### Mac OS X Brew Install
```sh
brew tap vectrum-core/vectrum
brew install vectrum
```
#### Mac OS X Brew Uninstall
```sh
brew remove vectrum
```

### Ubuntu Linux:

#### Ubuntu 18.04 Package Install
```sh
wget https://github.com/vectrum-core/vectrum/releases/download/v0.1.0/vectrum_0.1.0-1-ubuntu-18.04_amd64.deb
sudo apt install ./vectrum_0.1.0-1-ubuntu-18.04_amd64.deb
```
#### Ubuntu 16.04 Package Install
```sh
wget https://github.com/vectrum-core/vectrum/releases/download/v0.1.0/vectrum_0.1.0-1-ubuntu-16.04_amd64.deb
sudo apt install ./vectrum_0.1.0-1-ubuntu-16.04_amd64.deb
```
#### Ubuntu Package Uninstall
```sh
sudo apt remove vectrum
```

### RPM-based (CentOS, Amazon Linux, etc.):

#### RPM Package Install
```sh
wget https://github.com/vectrum-core/vectrum/releases/download/v0.1.0/vectrum-0.1.0-1.el7.x86_64.rpm
sudo yum install ./vectrum-0.1.0-1.el7.x86_64.rpm
```
#### RPM Package Uninstall
```sh
sudo yum remove vectrum
```

## Location of VECTRUM binaries

After installing the prebuilt packages, the actual VECTRUM binaries will be located under:
* `/usr/opt/vectrum/<version-string>/bin` (Linux-based); or
* `/usr/local/Cellar/vectrum/<version-string>/bin` (MacOS)

where `version-string` is the VECTRUM version that was installed.

Also, soft links for each VECTRUM program (`vectrum-node`, `vectrum-cli`, `vectrum-wallet`, etc.) will be created under `usr/bin` or `usr/local/bin` to allow them to be executed from any directory.

## Previous Versions

To install previous versions of the VECTRUM prebuilt binaries:

1. Browse to https://github.com/vectrum-core/vectrum/tags and select the actual version of the VECTRUM software you need to install.

2. Scroll down past the `Release Notes` and download the package or archive that you need for your OS.

3. Follow the instructions on the first paragraph above to install the selected prebuilt binaries on the given OS.
