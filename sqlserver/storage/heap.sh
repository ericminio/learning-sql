#!/bin/bash

function test_insert_record_in_first_page_with_enough_room {
    DIR=$(current_dir ${BASH_SOURCE[0]})
    
    executeFile ${DIR}/heap-insert.sql > ${DIR}/run.output
    actual=`cat ${DIR}/run.output | sed -n '3p;4p;5p;7p;8p;9p;10p' | cut -d' ' -f1 | xargs`

    assertequals "$actual" "1 3 2 -- 1 2 3"
}

function test_updated_record_still_starts_on_same_page {
    DIR=$(current_dir ${BASH_SOURCE[0]})
    
    executeFile ${DIR}/heap-update.sql > ${DIR}/run.output
    actual=`cat ${DIR}/run.output | sed -n '3p;4p;5p;7p;8p;9p;10p' | cut -d' ' -f1 | xargs`

    assertequals "$actual" "1 3 2 -- 1 3 2"
}

function test_updated_record_can_occupy_two_pages {
    DIR=$(current_dir ${BASH_SOURCE[0]})
    
    executeFile ${DIR}/heap-update-forwards.sql > ${DIR}/run.output
    actual=`cat ${DIR}/run.output | grep FORWARDING_STUB | wc -l`

    assertequals "$actual" "1"
}

