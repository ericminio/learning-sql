#!/bin/bash

source ./support/dir.sh

function executeFile {
    MYSQL_PWD=dev mysql --table --user=dev --database=exploration < $1
}
function execute {
    MYSQL_PWD=dev mysql --table --user=dev --database=exploration --execute "$1"
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

