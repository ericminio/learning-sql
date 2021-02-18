#!/bin/bash

source ./support/dir.sh

function first {
    head -3 | tail -1 | cut -d' ' -f1
}

function executeFile {
    /opt/mssql-tools/bin/sqlcmd -m 1 -S localhost -U SA -P Forever21! -d exploration -i $1
}

function execute {
    /opt/mssql-tools/bin/sqlcmd -m 1 -S localhost -U SA -P Forever21! -d exploration -Q "$1"
}

DIR=$(current_dir ${BASH_SOURCE[0]})

ready=0
while [ "$ready" != "1" ]
do
    echo "waiting for SqlServer";
    /opt/mssql-tools/bin/sqlcmd -m 1 -S localhost -U SA -P Forever21! -Q "SELECT 'yes' as SERVER_IS_READY" > $DIR/init.output
    ready=`grep yes $DIR/init.output | wc -l`
    sleep 1;
done;
echo "SqlServer is ready";

/opt/mssql-tools/bin/sqlcmd -m 1 -S localhost -U SA -P Forever21! -Q "CREATE DATABASE exploration"

ready=0
while [ "$ready" != "1" ]
do
    echo "waiting for database";
    execute "SELECT 'yes' as DATABASE_IS_READY" > $DIR/init.output
    ready=`grep yes $DIR/init.output | wc -l`
    sleep 1;
done;
echo "Database is ready";
