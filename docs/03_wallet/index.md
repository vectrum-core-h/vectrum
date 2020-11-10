---
content_title: vectrum-wallet
---

## Introduction

`vectrum-wallet` is a key manager service daemon for storing private keys and signing digital messages. It provides a secure key storage medium for keys to be encrypted at rest in the associated wallet file. `vectrum-wallet` also defines a secure enclave for signing transaction created by `vectrum-cli` or a third part library.

## Installation

`vectrum-wallet` is distributed as part of the [VECTRUM software suite](https://github.com/vectrum-core/vectrum/blob/master/README.md). To install `vectrum-wallet` just visit the [VECTRUM Software Installation](../00_install/index.md) section.

## Operation

When a wallet is unlocked with the corresponding password, `vectrum-cli` can request `vectrum-wallet` to sign a transaction with the appropriate private keys. Also, `vectrum-wallet` provides support for hardware-based wallets such as Secure Encalve and YubiHSM.

[[info | Audience]]
| `vectrum-wallet` is intended to be used by VECTRUM developers only.
