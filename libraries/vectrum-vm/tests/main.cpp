/**
 *  @file
 *  @copyright defined in vectrum/LICENSE
 */
#include <cstdlib>
#include <iostream>
#include <eosio/vm/allocator.hpp>

#define CATCH_CONFIG_MAIN
#include <catch2/catch.hpp>

eosio::vm::wasm_allocator wa;
