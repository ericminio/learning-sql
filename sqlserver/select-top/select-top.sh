#!/bin/bash

function test_select_top_can_help_with_custom_pagination {
    DIR=$(current_dir ${BASH_SOURCE[0]})
    
    executeFile ${DIR}/select-top.sql > ${DIR}/run.output
    actual=`cat ${DIR}/run.output | sed -n '3p' | xargs`

    assertequals "$actual" "5"
}

