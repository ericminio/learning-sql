#!/bin/bash

source ./sqlserver/support/dir.sh
source ./sqlserver/support/execute.sh
source ./sqlserver/execution-plan/strategy.sh

function test_no_index_results_in_table_scan {
    DIR=$(current_dir ${BASH_SOURCE[0]})

    execute ${DIR}/create-table-without-index.sql
    execute ${DIR}/insert.sql    
    execute ${DIR}/select-for-plan.sql > ${DIR}/plan-without-index
    actual=`strategy ${DIR}/plan-without-index`

    assertequals "$actual" "Table Scan"
}

function test_index_results_in_index_seek {
    DIR=$(current_dir ${BASH_SOURCE[0]})

    execute ${DIR}/create-table-with-index.sql
    execute ${DIR}/insert.sql    
    execute ${DIR}/select-for-plan.sql > ${DIR}/plan-with-index
    actual=`strategy ${DIR}/plan-with-index`

    assertequals "$actual" "Index Seek"
}

function test_bad_index_results_in_table_scan {
    DIR=$(current_dir ${BASH_SOURCE[0]})

    execute ${DIR}/create-table-with-bad-index.sql
    execute ${DIR}/insert.sql    
    execute ${DIR}/select-for-plan.sql > ${DIR}/plan-with-bad-index
    actual=`strategy ${DIR}/plan-with-bad-index`

    assertequals "$actual" "Table Scan"
}
