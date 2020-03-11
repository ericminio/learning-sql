#!/bin/bash

/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P Forever21! -i ./support/create-database.sql