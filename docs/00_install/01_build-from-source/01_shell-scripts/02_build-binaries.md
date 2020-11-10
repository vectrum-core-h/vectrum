---
content_title: Build VECTRUM Binaries
---

[[info | Shell Scripts]]
| The build script is one of various automated shell scripts provided in the VECTRUM Repository for building, installing, and optionally uninstalling the VECTRUM software and its dependencies. They are available in the `vectrum/scripts` folder.

The build script first installs all dependencies and then builds VECTRUM. The script supports these [Operating Systems](../../index.md#supported-operating-systems). To run it, first change to the `~/vectrum-core/vectrum` folder, then launch the script:

```sh
cd ~/vectrum-core/vectrum
./build.sh
```

The build process writes temporary content to the `vectrum/build` folder. After building, the program binaries can be found at `vectrum/build/programs`.

[[info | What's Next?]]
| [Installing VECTRUM](./03_install-binaries.md) is strongly recommended after building from source as it makes local development significantly more friendly.
