#!/bin/bash

source ./postgresql/utils.sh

function test_can_select_two_rows {
    DIR=$(current_dir ${BASH_SOURCE[0]})
    executeFile $DIR/select.sql > $DIR/run.output
    count=`grep "row" ${DIR}/run.output | trim`

    assertequals "$count" "(2 rows)"
}