#!/bin/bash

function test_select_top_can_help_with_custom_paging {
    DIR=$(current_dir ${BASH_SOURCE[0]})
    
    executeFile ${DIR}/select-top.sql > ${DIR}/run.output
    actual=`cat ${DIR}/run.output | sed -n '3p;4p;7p;8p' | xargs`

    assertequals "$actual" "2 3 4 5"
}

