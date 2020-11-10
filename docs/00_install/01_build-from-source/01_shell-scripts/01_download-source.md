---
content_title: Download VECTRUM Source
---

To download the VECTRUM source code, clone the VECTRUM repo and its submodules. It is adviced to create a home `vectrum-core` folder first and download all the VECTRUM related software there:

```sh
mkdir -p ~/vectrum-core && cd ~/vectrum-core
git clone --recursive https://github.com/vectrum-core/vectrum
```

## Update Submodules

If a repository is cloned without the `--recursive` flag, the submodules *must* be updated before starting the build process:

```sh
cd ~/vectrum-core/vectrum
git submodule update --init --recursive
```

## Pull Changes

When pulling changes, especially after switching branches, the submodules *must* also be updated. This can be achieved with the `git submodule` command as above, or using `git pull` directly:

```sh
[git checkout <branch>]  (optional)
git pull --recurse-submodules
```

[[info | What's Next?]]
| [Build VECTRUM binaries](./02_build-binaries.md)
