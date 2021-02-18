#!/bin/bash

function test_lead_and_lag_can_help_detect_picks_in_dataset {
    DIR=$(current_dir ${BASH_SOURCE[0]})
    
    executeFile ${DIR}/detect-pick.sql > ${DIR}/run.output
    actual=`cat ${DIR}/run.output | first`

    assertequals "$actual" "Joy"
}
