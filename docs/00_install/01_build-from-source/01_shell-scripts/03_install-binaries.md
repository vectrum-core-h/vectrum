---
content_title: Install VECTRUM Binaries
---

## VECTRUM install script

For ease of contract development, content can be installed at the `/usr/local` folder using the `install.sh` script within the `vectrum` folder. Adequate permission is required to install on system folders:

```sh
cd ~/vectrum-core/vectrum
sudo ./install.sh
```

## VECTRUM Manual install

In lieu of the `install.sh` script, you can install the VECTRUM binaries directly by invoking `make install` within the `vectrum/build` folder. Again, adequate permission is required to install on system folders:

```sh
cd ~/vectrum-core/vectrum/build
sudo make install
```

[[info | What's Next?]]
| Configure and use [vectrum-node](../../../01_node/index.md), or optionally [Test the VECTRUM binaries](./04_test-binaries.md).
