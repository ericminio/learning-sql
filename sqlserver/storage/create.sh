#!/bin/bash

function test_insert_record_in_first_page_with_enough_room {
    DIR=$(current_dir ${BASH_SOURCE[0]})
    
    executeFile ${DIR}/create.sql > ${DIR}/run.output
    actual=`cat ${DIR}/run.output | sed -n '3p;4p;5p;7p;8p;9p;10p' | cut -d' ' -f1 | xargs`

    assertequals "$actual" "A C B ------ A B C"
}
