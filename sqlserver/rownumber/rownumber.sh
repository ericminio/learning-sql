#!/bin/bash

function test_rownumber_offers_an_alternative_to_top {
    DIR=$(current_dir ${BASH_SOURCE[0]})
    
    executeFile ${DIR}/data.sql
    executeFile ${DIR}/inside-filter.sql > ${DIR}/run.output
    actual=`cat ${DIR}/run.output | grep affected`

    assertequals "$actual" "(1 rows affected)"
}

function test_rownumber_can_lead_to_bugs_hard_to_detect {
    DIR=$(current_dir ${BASH_SOURCE[0]})
    
    executeFile ${DIR}/data.sql
    executeFile ${DIR}/outside-filter.sql > ${DIR}/run.output
    actual=`cat ${DIR}/run.output | grep affected`

    assertequals "$actual" "(0 rows affected)"
}
