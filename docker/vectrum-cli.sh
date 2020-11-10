#!/bin/bash

# Usage:
# Go into cmd loop: sudo ./vectrum-cli.sh
# Run single cmd:  sudo ./vectrum-cli.sh <vectrum-cli paramers>

PREFIX="docker-compose exec vectrum_wallet vectrum-cli"
if [ -z $1 ] ; then
  while :
  do
    read -e -p "vectrum-cli " cmd
    history -s "$cmd"
    $PREFIX $cmd
  done
else
  $PREFIX "$@"
fi
