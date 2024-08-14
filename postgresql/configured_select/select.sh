#!/bin/bash

source ./postgresql/init.sh
source ./support/utils.sh

function test_works_with_hardcoded_product_id {
    DIR=$(current_dir ${BASH_SOURCE[0]})
    executeFile $DIR/data.sql
    executeFile $DIR/select-with-magic-number.sql > $DIR/run.output    
    local last=`cat $DIR/run.output | head -n 3 | tail -n 1 | trim`

    assertequals "$last" "2024-08-03"
}

function test_works_with_variable {
    DIR=$(current_dir ${BASH_SOURCE[0]})
    executeFile $DIR/data.sql
    local sql=$(sed "s/{{ product_id }}/1/g" $DIR/select-with-variable.sql)
    execute "$sql" > $DIR/run.output    
    local last=`cat $DIR/run.output | head -n 3 | tail -n 1 | trim`

    assertequals "$last" "2024-08-03"
}