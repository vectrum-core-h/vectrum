#!/bin/sh

if [ ! "$VECTRUM_ROOT" ]; then
    VECTRUM_ROOT="/opt/vectrum"
fi

cd $VECTRUM_ROOT/bin

if [ ! -d "/data" ]; then
    mkdir -f /data
fi

if [ -f '/data/config.ini' ]; then
    echo
  else
    cp /config.ini /data
fi

if [ -d '/data/contracts' ]; then
    echo
  else
    cp -r /contracts /data
fi

while :; do
    case $1 in
        --config-dir=?*)
            CONFIG_DIR=${1#*=}
            ;;
        *)
            break
    esac
    shift
done

if [ ! "$CONFIG_DIR" ]; then
    CONFIG_DIR="--config-dir=/data"
else
    CONFIG_DIR=""
fi

exec vectrum-node $CONFIG_DIR "$@"
