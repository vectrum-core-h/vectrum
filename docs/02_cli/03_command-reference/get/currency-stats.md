## Description
Retrieve the stats of for a given currency

## Positional Parameters
`contract` _TEXT_  - The contract that operates the currency

`symbol` _TEXT_ - The symbol for the currency if the contract operates multiple currencies
## Options
There are no options for this subcommand
## Example
Get stats of the VTM token from the eosio.token contract. 

```sh
vectrum-cli get currency stats eosio.token VTM
```
```json
{
  "VTM": {
    "supply": "1000000000.0000 VTM",
    "max_supply": "10000000000.0000 VTM",
    "issuer": "eosio"
  }
}
```
