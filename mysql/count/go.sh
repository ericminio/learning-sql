#!/bin/bash

function test_count_works_with_sub_queries {
    DIR=$(current_dir ${BASH_SOURCE[0]})

    executeFile $DIR/go.sql > $DIR/run.output
    value=`cat ${DIR}/run.output | head -4 | tail -1 | cut -d'|' -f2`

    assertequals $value 2
}