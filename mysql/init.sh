#!/bin/bash

source ./support/dir.sh
source ./support/waiting.sh

function executeFile {
    MYSQL_PWD=dev mysql --table --user=dev --database=exploration < $1
}
function execute {
    MYSQL_PWD=dev mysql --table --user=dev --database=exploration --execute "$1"
}

function wait_for_database {
    local DIR=$(current_dir ${BASH_SOURCE[0]})
    execute "select 'yes' DATABASE_IS_READY" > $DIR/init.output
    grep yes $DIR/init.output | wc -l
}

waiting mysql wait_for_database

