#!/bin/bash

function test_count_works_with_sub_queries {
    DIR=$(current_dir ${BASH_SOURCE[0]})

    executeFile $DIR/go.sql > $DIR/run.output
    actual=`grep "2" ${DIR}/run.output | wc -l`

    assertequals "$actual" "1"
}