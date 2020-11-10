# Bios Boot Tutorial

The `bios-boot-tutorial.py` script simulates the VECTRUM bios boot sequence.

``Prerequisites``:

1. Python 3.x
2. CMake
3. git
4. g++
5. build-essentials
6. pip3
7. openssl
8. curl
9. jq
10. psmisc


``Steps``:

1. Install VECTRUM binaries by following the steps outlined in below tutorial
[Install VECTRUM binaries](https://github.com/vectrum-core/vectrum#mac-os-x-brew-install).

2. Install VECTRUM.CDT binaries by following the steps outlined in below tutorial
[Install VECTRUM.CDT binaries](https://github.com/vectrum-core/vectrum.cdt#binary-releases).

3. Compile `vectrum.contracts`

```bash
$ cd ~
$ git clone https://github.com/vectrum-core/vectrum.contracts.git
$ cd ./vectrum.contracts/
$ ./build.sh
$ cd ./build/contracts/
$ pwd
```

7. Make note of the directory where the contracts were compiled
The last command in the previous step printed on the bash console the contracts' directory, make note of it, we'll reference it from now on as `VECTRUM_CONTRACTS_DIRECTORY`


8. Launch the `bios-boot-tutorial.py` script. 
The command line to launch the script, make sure you replace `VECTRUM_OLD_CONTRACTS_DIRECTORY` and `VECTRUM_CONTRACTS_DIRECTORY` with actual directory paths.

```bash
$ cd ~
$ git clone https://github.com/vectrum-core/vectrum.git
$ cd ./vectrum/tutorials/bios-boot-tutorial/
$ python3 bios-boot-tutorial.py --cli="vectrum-cli --wallet-url http://127.0.0.1:6666 " --node=vectrum-node --wallet=vectrum-wallet --contracts-dir="VECTRUM_CONTRACTS_DIRECTORY" --old-contracts-dir="VECTRUM_OLD_CONTRACTS_DIRECTORY" -w -a
```

6. At this point, when the script has finished running without error, you have a functional VECTRUM blockchain running locally with an latest version of `eosio.system` contract, 31 block producers out of which 21 active, `eosio` account resigned, 200k+ accounts with staked tokens, and votes allocated to each block producer. Enjoy exploring your freshly booted blockchain.
