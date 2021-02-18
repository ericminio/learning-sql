#!/bin/bash

function test_can_read_value_in_json {
    DIR=$(current_dir ${BASH_SOURCE[0]})
    
    executeFile ${DIR}/json-value.sql > ${DIR}/run.output
    actual=`cat ${DIR}/run.output | head -n 3 | tail -n 1 | cut -d' ' -f1`

    assertequals "$actual" "15"
}
