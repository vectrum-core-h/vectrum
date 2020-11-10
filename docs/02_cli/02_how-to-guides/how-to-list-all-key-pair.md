## Goal

List all key pairs

## Before you begin

* Install the currently supported version of `vectrum-cli`

* Understand the following:
  * What is a public and private key pair

## Steps

Unlock your wallet

```sh
vectrum-cli wallet unlock
```

List all public keys:

```sh
vectrum-cli wallet keys
```

List all private keys:

```sh
vectrum-cli wallet private_keys
```

[[warning]]
| Be careful never real your private keys in a production enviroment
