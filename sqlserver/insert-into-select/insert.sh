#!/bin/bash

function test_insert_from_select_preserves_existing_records {
    DIR=$(current_dir ${BASH_SOURCE[0]})
    
    executeFile ${DIR}/insert.sql > ${DIR}/run.output
    actual=`cat ${DIR}/run.output | wc -l`

    assertequals "$actual" "5"
}

