## Goal

Connect to a specific `vectrum-node` or `vectrum-wallet` host to send COMMAND

`vectrum-cli` and `vectrum-wallet` can connect to a specific node by using the `--url` or `--wallet-url` optional arguments, respectively, followed by the http address and port number these services are listening to.

[[info | Default address:port]]
| If no optional arguments are used (i.e. `--url` or `--wallet-url`), `vectrum-cli` attempts to connect to a local `vectrum-node` or `vectrum-wallet` running at localhost `127.0.0.1` and default port `8888`.

## Before you begin

* Install the currently supported version of `vectrum-cli`

## Steps
### Connecting to vectrum-node

```sh
vectrum-cli -url http://vectrum-node-host:8888 COMMAND
```

### Connecting to vectrum-wallet

```sh
vectrum-cli --wallet-url http://vectrum-wallet-host:8888 COMMAND
```
