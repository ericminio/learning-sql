#!/bin/bash

source ./support/yop-testing-bash/dist/dir.sh
source ./support/yop-testing-bash/dist/waiting.sh
source ./support/yop-testing-bash/dist/utils.sh

function executeFile {
    psql exploration -U dev -q -f $1
}
function execute {
    psql exploration -U dev -q -c "$1"
}

function wait_for_postgresql {
    execute "select 'yes' DATABASE_IS_READY" | grep yes | wc -l
}

function extract_query_result {
    tail -n +3 | sed '$d' | sed 's/|//g' | oneliner | shrink | trim
}