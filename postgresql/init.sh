#!/bin/bash

source ./support/dir.sh
source ./support/waiting.sh

function executeFile {
    psql exploration -U dev -q -f $1
}
function execute {
    psql exploration -U dev -q -c "$1"
}

function wait_for_database {
    local DIR=$(current_dir ${BASH_SOURCE[0]})
    execute "select 'yes' DATABASE_IS_READY" > $DIR/init.output
    grep yes $DIR/init.output | wc -l
}

waiting database wait_for_database

execute "alter database exploration set client_min_messages to WARNING"