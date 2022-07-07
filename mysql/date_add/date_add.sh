#!/bin/bash

function test_dateadd_can_substract_days {
    DIR=$(current_dir ${BASH_SOURCE[0]})

    executeFile $DIR/go.sql > $DIR/run.output
    actual=`grep "2022" ${DIR}/run.output | wc -l`

    assertequals "$actual" "2"
}