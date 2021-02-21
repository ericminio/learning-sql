#!/bin/bash

function test_select_top_can_help_with_custom_pagination {
    DIR=$(current_dir ${BASH_SOURCE[0]})
    
    executeFile ${DIR}/pagination.sql > ${DIR}/run.output
    count_by_page=`cat ${DIR}/run.output | sed -n '3p;4p;5p' | xargs`

    assertequals "$count_by_page" "3 3 1"
}

