#!/bin/bash

source ./support/execute.sh

function test_lead_and_lag_can_help_detect_picks_in_dataset {
    execute ./demo/lead-lag/products.sql
    execute ./demo/lead-lag/detect-pick.sql > ./demo/lead-lag/run.output
    actual=`cat ./demo/lead-lag/run.output | head -3 | tail -1 | cut -d' ' -f 1`

    assertequals "$actual" "Joy"
}
