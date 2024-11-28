#!/bin/bash

SERVICE=$1
FOLDER=$2

path="./$SERVICE/$FOLDER"
if [ -z "$FOLDER" ]; then
    echo "No folder inside $SERVICE specified, exiting"
    exit 1
fi

./support/run.sh $SERVICE $FOLDER
fswatch -o $path -e "run.output" | xargs -n1 ./support/run.sh $SERVICE $FOLDER