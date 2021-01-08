#!/bin/bash

source ./support/execute.sh
source ./demo/execution-plan/strategy.sh

function test_index_needs_to_contain_all_the_selected_columns {
    execute ./demo/execution-plan/select-count/create-table.sql
    execute ./demo/execution-plan/select-count/insert.sql    
    execute ./demo/execution-plan/select-count/select-for-plan.sql > ./demo/execution-plan/select-count/plan-with-index    
    actual=`strategy ./demo/execution-plan/select-count/plan-with-index`

    assertequals "$actual" "Index Seek"
}

function test_missing_columns_will_result_in_table_scan {
    execute ./demo/execution-plan/select-count/create-table-with-bad-index.sql
    execute ./demo/execution-plan/select-count/insert.sql    
    execute ./demo/execution-plan/select-count/select-for-plan.sql > ./demo/execution-plan/select-count/plan-with-bad-index
    actual=`strategy ./demo/execution-plan/select-count/plan-with-bad-index`

    assertequals "$actual" "Table Scan"
}
