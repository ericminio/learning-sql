#!/bin/bash

function test_returns_first_matching_rows {
    DIR=$(current_dir ${BASH_SOURCE[0]})

    executeFile ${DIR}/data.sql 
    execute "select * from event where rownum <= 3;" > ${DIR}/run.output
    actual=`grep "MATCH" ${DIR}/run.output | wc -l`

    assertequals "$actual" "3"
}
