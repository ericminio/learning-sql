#!/bin/bash

function test_no_index_results_in_table_scan {
    : > ./demo/actual-without-index
    /opt/mssql-tools/bin/sqlcmd -m 1 -S localhost -U SA -P Forever21! -d exploration -i ./sql/create-table-without-index.sql
    /opt/mssql-tools/bin/sqlcmd -m 1 -S localhost -U SA -P Forever21! -d exploration -i ./sql/insert.sql    
    /opt/mssql-tools/bin/sqlcmd -m 1 -S localhost -U SA -P Forever21! -d exploration -i ./sql/select-for-plan.sql > ./demo/actual-without-index
    
    strategy=`grep "|--" ./demo/actual-without-index | cut -d"(" -f1 | cut -d"-" -f3`

    assertequals "$strategy" "Table Scan"
}

function test_index_results_in_index_seek {
    : > ./demo/actual-with-index
    /opt/mssql-tools/bin/sqlcmd -m 1 -S localhost -U SA -P Forever21! -d exploration -i ./sql/create-table-with-index.sql
    /opt/mssql-tools/bin/sqlcmd -m 1 -S localhost -U SA -P Forever21! -d exploration -i ./sql/insert.sql    
    /opt/mssql-tools/bin/sqlcmd -m 1 -S localhost -U SA -P Forever21! -d exploration -i ./sql/select-for-plan.sql > ./demo/actual-with-index

    strategy=`grep "|--" ./demo/actual-with-index | cut -d"(" -f1 | cut -d"-" -f3`

    assertequals "$strategy" "Index Seek"
}

function test_bad_index_results_in_table_scan {
    : > ./demo/actual-with-bad-index
    /opt/mssql-tools/bin/sqlcmd -m 1 -S localhost -U SA -P Forever21! -d exploration -i ./sql/create-table-with-bad-index.sql
    /opt/mssql-tools/bin/sqlcmd -m 1 -S localhost -U SA -P Forever21! -d exploration -i ./sql/insert.sql    
    /opt/mssql-tools/bin/sqlcmd -m 1 -S localhost -U SA -P Forever21! -d exploration -i ./sql/select-for-plan.sql > ./demo/actual-with-bad-index

    strategy=`grep "|--" ./demo/actual-with-bad-index | cut -d"(" -f1 | cut -d"-" -f3`

    assertequals "$strategy" "Table Scan"
}
