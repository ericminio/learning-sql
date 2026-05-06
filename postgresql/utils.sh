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
function execute-read-replica {
    PGPASSWORD=dev psql -h postgres-read exploration -U dev -q -c "$1"
}
function wait_for_replication_done {
    local target_lsn=$(psql exploration -U dev -At -c "select pg_current_wal_lsn()" | tr -d '[:space:]')
    local attempts=0
    while [ $attempts -lt 50 ]; do
        local caught_up=$(PGPASSWORD=dev psql -h postgres-read -U dev exploration -At -c "select pg_last_wal_replay_lsn() >= '$target_lsn'::pg_lsn" 2>/dev/null | tr -d '[:space:]')
        if [ "$caught_up" = "t" ]; then
            return 0
        fi
        sleep 0.1
        attempts=$((attempts+1))
    done
    return 1
}

function wait_for_postgresql {
    execute "select 'yes' DATABASE_IS_READY" | grep yes | wc -l
}
function wait_for_postgres_read {
    PGPASSWORD=dev psql -h postgres-read exploration -U dev -q -c "select 'yes' DATABASE_IS_READY" 2>/dev/null | grep yes | wc -l
}

function extract_query_result {
    tail -n +3 | sed '$d' | sed 's/|//g' | oneliner | shrink | trim
}