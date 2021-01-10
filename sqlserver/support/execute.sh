#!/bin/bash

function executeFile {
    /opt/mssql-tools/bin/sqlcmd -m 1 -S localhost -U SA -P Forever21! -d exploration -i $1
}

function execute {
    /opt/mssql-tools/bin/sqlcmd -m 1 -S localhost -U SA -P Forever21! -d exploration -Q "$1"
}