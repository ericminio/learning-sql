#!/bin/bash

/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P Forever21! -Q 'CREATE DATABASE exploration'

while ! /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P Forever21! -d exploration -Q "SELECT 1";
do
    echo "waiting for database creation";
    sleep 1;
done;
echo "Database is ready";