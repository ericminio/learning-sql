#!/bin/bash

source ./postgresql/utils.sh

function strategy {
    grep -oE "(Index Only Scan|Index Scan|Seq Scan|Bitmap Heap Scan|Bitmap Index Scan)" $1 | tail -1
}

function test_index_needs_to_contain_all_the_selected_columns {
    DIR=$(current_dir ${BASH_SOURCE[0]})

    executeFile ${DIR}/create-table.sql
    executeFile ${DIR}/insert.sql
    executeFile ${DIR}/select-for-plan.sql > ${DIR}/plan-with-index
    actual=`strategy ${DIR}/plan-with-index`

    assertequals "$actual" "Index Only Scan"
}

function test_missing_columns_will_result_in_table_scan {
    DIR=$(current_dir ${BASH_SOURCE[0]})

    executeFile ${DIR}/create-table-with-bad-index.sql
    executeFile ${DIR}/insert.sql
    executeFile ${DIR}/select-for-plan.sql > ${DIR}/plan-with-bad-index
    actual=`strategy ${DIR}/plan-with-bad-index`

    assertequals "$actual" "Index Scan"
}
