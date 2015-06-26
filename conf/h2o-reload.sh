#!/bin/bash
H2O="`which h2o`"
DEFAULT_DIR="/etc/h2o"
BASENAME=`basename "$0"`
PID_FILE="$DEFAULT_DIR/run/h2o.pid"
CONFIG_FILE="$DEFAULT_DIR/h2o.conf"

if [ "$1" == "reload"  ]; then
    if [ -f "$PID_FILE" ]; then
        kill -TERM `cat $PID_FILE`
        $H2O -m daemon -c $CONFIG_FILE

    else
        $H2O -m daemon -c $CONFIG_FILE
    fi

else
    echo "Usage: ./$BASENAME reload"
fi