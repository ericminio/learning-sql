#!/bin/bash

source ./support/dir.sh
source ./support/waiting.sh
DIR=$(current_dir ${BASH_SOURCE[0]})

function first {
    head -3 | tail -1 | cut -d' ' -f1
}

function executeFile {
    /opt/mssql-tools/bin/sqlcmd -m 1 -S localhost -U SA -P Forever21! -d exploration -i $1
}

function execute {
    /opt/mssql-tools/bin/sqlcmd -m 1 -S localhost -U SA -P Forever21! -d exploration -Q "$1"
}

function wait_for_server {
    /opt/mssql-tools/bin/sqlcmd -m 1 -S localhost -U SA -P Forever21! -Q "SELECT 'yes' as SERVER_IS_READY" > $DIR/init.output
    grep yes $DIR/init.output | wc -l
}

function wait_for_database {
    execute "SELECT 'yes' as DATABASE_IS_READY" > $DIR/init.output
    grep yes $DIR/init.output | wc -l
}

waiting SqlServer wait_for_server
/opt/mssql-tools/bin/sqlcmd -m 1 -S localhost -U SA -P Forever21! -Q "CREATE DATABASE exploration"

waiting database wait_for_database
