#!/bin/bash
set -e

if [ "$ICECC_ENABLE_SCHEDULER" == "1" ]; then
    /usr/sbin/icecc-scheduler -d -vvv -l /tmp/icecc-scheduler.log
else
    [ ! -z "$ICECC_NETNAME" ] && ICECC_NETNAME_OPTION="--netname $ICECC_NETNAME"
    [ ! -z "$ICECC_SCHEDULER" ] && ICECC_SCHEDULER_OPTION="--scheduler-host $ICECC_SCHEDULER"
    [ ! -z "$ICECC_NODE_NAME" ] && ICECC_NODE_NAME_OPTION="-N $ICECC_NODE_NAME" || ICECC_NODE_NAME_OPTION="-N $(hostname)"

    echo "ICECC_NETNAME_OPTION=$ICECC_NETNAME_OPTION"
    echo "ICECC_NODE_NAME_OPTION=$ICECC_NODE_NAME_OPTION"
    echo "ICECC_SCHEDULER_OPTION=$ICECC_SCHEDULER_OPTION"

    sudo /usr/sbin/iceccd $ICECC_NETNAME_OPTION $ICECC_SCHEDULER_OPTION $ICECC_NODE_NAME_OPTION -u icecc
fi
