## Goal

Delegate resource for an account or application

## Before you begin

* Install the currently supported version of `vectrum-cli`

* Ensure the reference system contracts from `vectrum.contracts` repository is deployed and used to manage system resources

* Understand the following:
  * What is an account
  * What is network bandwidth
  * What is CPU bandwidth

## Steps

Delegate 0.01 VTM CPU bandwidth from `bob` to `alice`

```sh
vectrum-cli system delegatebw bob alice "0.01 VTM" "0 VTM"
```

You should see something below:

```console
executed transaction: 5487afafd67bf459a20fcc2dbc5d0c2f0d1f10e33123eaaa07088046fd18e3ae  192 bytes  503 us
#         eosio <= eosio::delegatebw            {"from":"bob","receiver":"alice","stake_net_quantity":"0.0000 VTM","stake_cpu_quanti...
#   eosio.token <= eosio.token::transfer        {"from":"bob","to":"eosio.stake","quantity":"0.0010 VTM","memo":"stake bandwidth"}
#  bob <= eosio.token::transfer        {"from":"bob","to":"eosio.stake","quantity":"0.0010 VTM","memo":"stake bandwidth"}
#   eosio.stake <= eosio.token::transfer        {"from":"bob","to":"eosio.stake","quantity":"0.0010 VTM","memo":"stake bandwidth"}
```
