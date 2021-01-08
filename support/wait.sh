#!/bin/bash

while ! /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P Forever21! -Q "SELECT 1";
do
    echo "waiting for SqlServer";
    sleep 1;
done;
echo "SqlServer is ready";