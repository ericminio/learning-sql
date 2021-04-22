#!/bin/bash

function test_type_can_be_used_to_define_a_table {
    DIR=$(current_dir ${BASH_SOURCE[0]})
    executeFile ${DIR}/demo.sql > ${DIR}/run.output
    actual=`grep "333" ${DIR}/run.output | wc -l`

    assertequals $actual 1
}
