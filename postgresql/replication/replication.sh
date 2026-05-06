#!/bin/bash

source ./postgresql/utils.sh

function test_replication_happens {
    DIR=$(current_dir ${BASH_SOURCE[0]})
    executeFile $DIR/schema.sql

    execute "insert into products(id, name) values (1, 'Mouse')"
    wait_for_replication_done

    execute-read-replica "select count(*) from products" > $DIR/run.output
    actual=`grep " 1" $DIR/run.output | shrink | trim`

    assertequals "$actual" "1"
}