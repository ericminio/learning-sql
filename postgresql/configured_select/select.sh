#!/bin/bash

source ./support/utils.sh

function test_works_with_hardcoded_product_id {
    DIR=$(current_dir ${BASH_SOURCE[0]})
    executeFile $DIR/data.sql
    executeFile $DIR/select-with-magic-number.sql > $DIR/run.output    
    local last=`cat $DIR/run.output | head -n 3 | tail -n 1 | trim`

    assertequals "$last" "2024-08-03"
}