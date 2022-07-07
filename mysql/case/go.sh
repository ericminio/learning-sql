#!/bin/bash

function test_case_can_help_collecting_several_counts_with_one_grouping {
    DIR=$(current_dir ${BASH_SOURCE[0]})

    executeFile $DIR/go.sql > $DIR/run.output
    actual=`grep "A" ${DIR}/run.output | wc -l`

    assertequals "$actual" "1"
}