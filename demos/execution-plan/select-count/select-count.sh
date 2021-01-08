#!/bin/bash

source ./support/dir.sh
source ./support/execute.sh
source ./demos/execution-plan/strategy.sh

function test_index_needs_to_contain_all_the_selected_columns {
    DIR=$(current_dir ${BASH_SOURCE[0]})

    execute ${DIR}/create-table.sql
    execute ${DIR}/insert.sql    
    execute ${DIR}/select-for-plan.sql > ${DIR}/plan-with-index    
    actual=`strategy ${DIR}/plan-with-index`

    assertequals "$actual" "Index Seek"
}

function test_missing_columns_will_result_in_table_scan {
    DIR=$(current_dir ${BASH_SOURCE[0]})

    execute ${DIR}/create-table-with-bad-index.sql
    execute ${DIR}/insert.sql    
    execute ${DIR}/select-for-plan.sql > ${DIR}/plan-with-bad-index
    actual=`strategy ${DIR}/plan-with-bad-index`

    assertequals "$actual" "Table Scan"
}
