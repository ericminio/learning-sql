#!/bin/bash

source ./support/dir.sh

function executeFile {
    psql exploration -U dev -q -f $1
}
function execute {
    psql exploration -U dev -q -c "$1"
}

DIR=$(current_dir ${BASH_SOURCE[0]})
ready=0
while [ "$ready" != "1" ]
do
    echo "waiting for database";
    execute "select 'yes' DATABASE_IS_READY" > $DIR/init.output
    ready=`grep yes $DIR/init.output | wc -l`
    sleep 1;
done;
echo "database is ready";

execute "alter database exploration set client_min_messages to WARNING"