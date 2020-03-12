#!/bin/bash

function test_no_index_results_in_table_scan {
    : > ./demo/select/plan-without-index
    /opt/mssql-tools/bin/sqlcmd -m 1 -S localhost -U SA -P Forever21! -d exploration -i ./demo/select/create-table-without-index.sql
    /opt/mssql-tools/bin/sqlcmd -m 1 -S localhost -U SA -P Forever21! -d exploration -i ./demo/select/insert.sql    
    /opt/mssql-tools/bin/sqlcmd -m 1 -S localhost -U SA -P Forever21! -d exploration -i ./demo/select/select-for-plan.sql > ./demo/select/plan-without-index
    
    strategy=`grep "|--" ./demo/select/plan-without-index | cut -d"(" -f1 | cut -d"-" -f3`

    assertequals "$strategy" "Table Scan"
}

function test_index_results_in_index_seek {
    : > ./demo/select/plan-with-index
    /opt/mssql-tools/bin/sqlcmd -m 1 -S localhost -U SA -P Forever21! -d exploration -i ./demo/select/create-table-with-index.sql
    /opt/mssql-tools/bin/sqlcmd -m 1 -S localhost -U SA -P Forever21! -d exploration -i ./demo/select/insert.sql    
    /opt/mssql-tools/bin/sqlcmd -m 1 -S localhost -U SA -P Forever21! -d exploration -i ./demo/select/select-for-plan.sql > ./demo/select/plan-with-index

    strategy=`grep "|--" ./demo/select/plan-with-index | cut -d"(" -f1 | cut -d"-" -f3`

    assertequals "$strategy" "Index Seek"
}

function test_bad_index_results_in_table_scan {
    : > ./demo/select/plan-with-bad-index
    /opt/mssql-tools/bin/sqlcmd -m 1 -S localhost -U SA -P Forever21! -d exploration -i ./demo/select/create-table-with-bad-index.sql
    /opt/mssql-tools/bin/sqlcmd -m 1 -S localhost -U SA -P Forever21! -d exploration -i ./demo/select/insert.sql    
    /opt/mssql-tools/bin/sqlcmd -m 1 -S localhost -U SA -P Forever21! -d exploration -i ./demo/select/select-for-plan.sql > ./demo/select/plan-with-bad-index

    strategy=`grep "|--" ./demo/select/plan-with-bad-index | cut -d"(" -f1 | cut -d"-" -f3`

    assertequals "$strategy" "Table Scan"
}
