#!/bin/bash
#
# vectrum-tn_bounce is used to restart a node that is acting badly or is down.
# usage: vectrum-tn_bounce.sh [arglist]
# arglist will be passed to the node's command line. First with no modifiers
# then with --hard-replay-blockchain and then a third time with --delete-all-blocks
#
# the data directory and log file are set by this script. Do not pass them on
# the command line.
#
# in most cases, simply running ./vectrum-tn_bounce.sh is sufficient.
#

pushd $VECTRUM_HOME

if [ ! -f programs/node/vectrum-node ]; then
    echo unable to locate binary for vectrum-node
    exit 1
fi

config_base=etc/vectrum/node_
if [ -z "$VECTRUM_NODE" ]; then
    DD=`ls -d ${config_base}[012]?`
    ddcount=`echo $DD | wc -w`
    if [ $ddcount -ne 1 ]; then
        echo $HOSTNAME has $ddcount config directories, bounce not possible. Set environment variable
        echo VECTRUM_NODE to the 2-digit node id number to specify which node to bounce. For example:
        echo VECTRUM_NODE=06 $0 \<options\>
        cd -
        exit 1
    fi
    OFS=$((${#DD}-2))
    export VECTRUM_NODE=${DD:$OFS}
else
    DD=${config_base}$VECTRUM_NODE
    if [ ! \( -d $DD \) ]; then
        echo no directory named $PWD/$DD
        cd -
        exit 1
    fi
fi

bash $VECTRUM_HOME/scripts/vectrum-tn_down.sh
bash $VECTRUM_HOME/scripts/vectrum-tn_up.sh "$*"
