#!/bin/bash

SERVICE=$1
FOLDER=$2

path="./$SERVICE/$FOLDER"
if [ -z "$FOLDER" ]; then
    path="./$SERVICE"
fi

clear
docker-compose exec -T $SERVICE ./support/yop-testing-bash/dist/test.sh $path
