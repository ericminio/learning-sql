#!/bin/bash

source ./support/execute.sh
source ./support/strategy.sh

function test_no_index_results_in_table_scan {
    execute ./demo/select/create-table-without-index.sql
    execute ./demo/select/insert.sql    
    execute ./demo/select/select-for-plan.sql > ./demo/select/plan-without-index
    actual=`strategy ./demo/select/plan-without-index`

    assertequals "$actual" "Table Scan"
}

function test_index_results_in_index_seek {
    execute ./demo/select/create-table-with-index.sql
    execute ./demo/select/insert.sql    
    execute ./demo/select/select-for-plan.sql > ./demo/select/plan-with-index
    actual=`strategy ./demo/select/plan-with-index`

    assertequals "$actual" "Index Seek"
}

function test_bad_index_results_in_table_scan {
    execute ./demo/select/create-table-with-bad-index.sql
    execute ./demo/select/insert.sql    
    execute ./demo/select/select-for-plan.sql > ./demo/select/plan-with-bad-index
    actual=`strategy ./demo/select/plan-with-bad-index`

    assertequals "$actual" "Table Scan"
}
