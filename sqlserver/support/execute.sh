#!/bin/bash

function execute {
    if test -f "$1"; then
        /opt/mssql-tools/bin/sqlcmd -m 1 -S localhost -U SA -P Forever21! -d exploration -i $1
    else
        /opt/mssql-tools/bin/sqlcmd -m 1 -S localhost -U SA -P Forever21! -d exploration -Q "$1"
    fi
}
