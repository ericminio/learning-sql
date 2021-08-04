#!/bin/bash

function test_alter_from_varchar_to_timestamp_can_recover_from_missing_left_padding {
    DIR=$(current_dir ${BASH_SOURCE[0]})

    executeFile $DIR/data.sql
    executeFile $DIR/select.sql > $DIR/run.output
    actual=`grep "1 row" ${DIR}/run.output`

    assertequals "$actual" "(1 row)"
}