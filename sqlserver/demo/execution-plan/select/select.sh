#!/bin/bash

source ./support/execute.sh
source ./demo/execution-plan/strategy.sh

function test_no_index_results_in_table_scan {
    execute ./demo/execution-plan/select/create-table-without-index.sql
    execute ./demo/execution-plan/select/insert.sql    
    execute ./demo/execution-plan/select/select-for-plan.sql > ./demo/execution-plan/select/plan-without-index
    actual=`strategy ./demo/execution-plan/select/plan-without-index`

    assertequals "$actual" "Table Scan"
}

function test_index_results_in_index_seek {
    execute ./demo/execution-plan/select/create-table-with-index.sql
    execute ./demo/execution-plan/select/insert.sql    
    execute ./demo/execution-plan/select/select-for-plan.sql > ./demo/execution-plan/select/plan-with-index
    actual=`strategy ./demo/execution-plan/select/plan-with-index`

    assertequals "$actual" "Index Seek"
}

function test_bad_index_results_in_table_scan {
    execute ./demo/execution-plan/select/create-table-with-bad-index.sql
    execute ./demo/execution-plan/select/insert.sql    
    execute ./demo/execution-plan/select/select-for-plan.sql > ./demo/execution-plan/select/plan-with-bad-index
    actual=`strategy ./demo/execution-plan/select/plan-with-bad-index`

    assertequals "$actual" "Table Scan"
}
