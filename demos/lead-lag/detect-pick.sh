#!/bin/bash

source ./support/dir.sh
source ./support/execute.sh

function test_lead_and_lag_can_help_detect_picks_in_dataset {
    DIR=$(current_dir ${BASH_SOURCE[0]})
    
    execute ${DIR}/products.sql
    execute ${DIR}/detect-pick.sql > ${DIR}/run.output
    actual=`cat ${DIR}/run.output | head -3 | tail -1 | cut -d' ' -f 1`

    assertequals "$actual" "Joy"
}