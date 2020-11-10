## Description
Retrieve accounts which are servants of a given account 

## Info

**Command**

```sh
vectrum-cli get servants
```
**Output**

```console
Usage: vectrum-cli get servants account

Positionals:
  account TEXT                The name of the controlling account
```

## Command

```sh
vectrum-cli get servants inita
```

## Output

```json
{
  "controlled_accounts": [
    "tester"
  ]
}
```
