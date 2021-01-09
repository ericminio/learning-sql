#!/bin/bash

while ! /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P Forever21! -Q "SELECT 1 as SERVER_IS_READY";
do
    echo "waiting for SqlServer";
    sleep 1;
done;
echo "SqlServer is ready";

/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P Forever21! -Q 'CREATE DATABASE exploration'

while ! /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P Forever21! -d exploration -Q "SELECT 1 as DATABASE_IS_READY";
do
    echo "waiting for database";
    sleep 1;
done;
echo "Database is ready";