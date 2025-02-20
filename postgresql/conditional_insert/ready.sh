#!/bin/bash

source ./postgresql/utils.sh

function test_not_exists {
    DIR=$(current_dir ${BASH_SOURCE[0]})
    executeFile $DIR/maybe-insert.sql
    execute "SELECT id FROM products where name='banana'" > $DIR/run.output
    count=`grep "row" ${DIR}/run.output | trim`

    assertequals "$count" "(0 rows)"
}

function test_exists {
    DIR=$(current_dir ${BASH_SOURCE[0]})
    executeFile $DIR/maybe-insert.sql
    execute "SELECT id FROM products where name='cherry'" > $DIR/run.output
    count=`grep "row" ${DIR}/run.output | trim`

    assertequals "$count" "(2 rows)"
}