#!/bin/bash

function test_index_needs_to_contain_all_the_selected_columns {
    : > ./demo/select-count/plan-with-index
    /opt/mssql-tools/bin/sqlcmd -m 1 -S localhost -U SA -P Forever21! -d exploration -i ./demo/select-count/create-table.sql
    /opt/mssql-tools/bin/sqlcmd -m 1 -S localhost -U SA -P Forever21! -d exploration -i ./demo/select-count/insert.sql    
    /opt/mssql-tools/bin/sqlcmd -m 1 -S localhost -U SA -P Forever21! -d exploration -i ./demo/select-count/select-for-plan.sql > ./demo/select-count/plan-with-index
    
    strategy=`grep "|--" ./demo/select-count/plan-with-index | cut -d"(" -f1 | cut -d"-" -f3 | tail -1`

    assertequals "$strategy" "Index Seek"
}

function test_missing_columns_will_result_in_table_scan {
    : > ./demo/select-count/plan-with-bad-index
    /opt/mssql-tools/bin/sqlcmd -m 1 -S localhost -U SA -P Forever21! -d exploration -i ./demo/select-count/create-table-with-bad-index.sql
    /opt/mssql-tools/bin/sqlcmd -m 1 -S localhost -U SA -P Forever21! -d exploration -i ./demo/select-count/insert.sql    
    /opt/mssql-tools/bin/sqlcmd -m 1 -S localhost -U SA -P Forever21! -d exploration -i ./demo/select-count/select-for-plan.sql > ./demo/select-count/plan-with-bad-index
    
    strategy=`grep "|--" ./demo/select-count/plan-with-bad-index | cut -d"(" -f1 | cut -d"-" -f3 | tail -1`

    assertequals "$strategy" "Table Scan"
}
