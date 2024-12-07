#!/bin/bash

function test_works_with_hardcoded_product_id {    
    DIR=$(current_dir ${BASH_SOURCE[0]})
    executeFile $DIR/data.sql
    executeFile $DIR/select-with-magic-number.sql > $DIR/run.output    
    
    assertequals "$(last)" "2024-08-03"
}

function test_works_with_variable {
    DIR=$(current_dir ${BASH_SOURCE[0]})
    executeFile $DIR/data.sql
    execute "$(sed "s/{{ product_id }}/1/g" $DIR/select-with-variable.sql)" > $DIR/run.output    
    
    assertequals "$(last)" "2024-08-03"
}

function last {
    DIR=$(current_dir ${BASH_SOURCE[0]})
    cat $DIR/run.output | head -n 3 | tail -n 1 | trim
}
