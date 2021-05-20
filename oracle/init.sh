#!/bin/bash

export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe

function sqlplus {
    /u01/app/oracle/product/11.2.0/xe/bin/sqlplus -S $CONNECTION
}
function executeFile {
    sqlplus  < $1
}
function execute {
    echo "$1" | sqlplus
}

