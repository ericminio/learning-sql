#!/bin/bash

function test_timestamp_does_not_need_left_padding_at_insert_time {
    DIR=$(current_dir ${BASH_SOURCE[0]})

    executeFile $DIR/data.sql
    executeFile $DIR/select.sql > $DIR/run.output
    actual=`grep "1" ${DIR}/run.output | wc -l`

    assertequals "$actual" "1"
}