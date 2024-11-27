#!/bin/bash

source ./support/yop-testing-bash/dist/dir.sh
source ./support/yop-testing-bash/dist/waiting.sh
source ./support/yop-testing-bash/dist/utils.sh

function executeFile {
    MYSQL_PWD=dev mysql --local-infile=1 --table --user=dev --database=exploration < $1
}
function execute {
    MYSQL_PWD=dev mysql --local-infile=1 --table --user=dev --database=exploration --execute "$1"
}
function execute_as_root {
    MYSQL_PWD=dev mysql --table --user=root --database=exploration --execute "$1"
}

function extract_query_result {
    tail -n +4 | sed '$d' | sed 's/|//g' | oneliner | shrink | trim
}

function wait_for_database {
    execute "select 'yes' DATABASE_IS_READY" | grep yes | wc -l
}
