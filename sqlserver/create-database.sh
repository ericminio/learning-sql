#!/bin/bash

/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P Forever21! -d exploration -i sql/create-database.sql