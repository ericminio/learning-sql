#!/bin/bash

function test_json_value_can_extract_value_from_string {
    DIR=$(current_dir ${BASH_SOURCE[0]})
    
    executeFile ${DIR}/json-value.sql > ${DIR}/run.output
    actual=`cat ${DIR}/run.output | first`

    assertequals "$actual" "15"
}
