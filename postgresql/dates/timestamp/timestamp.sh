#!/bin/bash

function test_timestamp_does_not_need_left_padding {
    DIR=$(current_dir ${BASH_SOURCE[0]})

    executeFile $DIR/data.sql
    executeFile $DIR/select.sql > $DIR/run.output
    actual=`grep "1 row" ${DIR}/run.output`

    assertequals "$actual" "(1 row)"
}