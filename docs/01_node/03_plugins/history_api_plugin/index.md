[[warning | Deprecation Notice]]
| The `history_plugin` that the `history_api_plugin` depends upon is deprecated and will no longer be maintained. Please use the [`state_history_plugin`](../state_history_plugin/index.md) instead.

## Description

The `history_api_plugin` exposes functionality from the [`history_plugin`](../history_plugin/index.md) to the RPC API interface managed by the [`http_plugin`](../http_plugin/index.md), providing read-only access to blockchain data.

It provides four RPC API endpoints:

* get_actions
* get_transaction
* get_key_accounts
* get_controlled_accounts

[[info | More Info]]
| See HISTORY section of [EOSIO RPC API](https://developers.eos.io/eosio-nodeos/reference).

The four actions listed above are used by the following `vectrum-cli` commands (matching order):

* get actions
* get transaction
* get accounts
* get servants

## Usage

```console
# config.ini
plugin = eosio::history_api_plugin
```
```sh
# command-line
vectrum-node ... --plugin eosio::history_api_plugin
```

## Options

None

## Dependencies

* [`history_plugin`](../history_plugin/index.md)
* [`chain_plugin`](../chain_plugin/index.md)
* [`http_plugin`](../http_plugin/index.md)

### Load Dependency Examples

```console
# config.ini
plugin = eosio::history_plugin
[options]
plugin = eosio::chain_plugin
[options]
plugin = eosio::http_plugin
[options]
```
```sh
# command-line
vectrum-node ... --plugin eosio::history_plugin [options]  \
           --plugin eosio::chain_plugin [operations] [options]  \
           --plugin eosio::http_plugin [options]
```
