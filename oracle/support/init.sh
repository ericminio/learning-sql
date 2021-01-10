#!/bin/bash

source ./oracle/support/dir.sh
export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe

function sqlplus {
    /u01/app/oracle/product/11.2.0/xe/bin/sqlplus -s SYSTEM/oracle@localhost
}
function executeFile {
    sqlplus  < $1
}
function execute {
    echo "$1" | sqlplus
}

DIR=$(current_dir ${BASH_SOURCE[0]})
ready=0
while [ "$ready" != "1" ]
do
    echo "waiting for Oracle";
    execute "select 'yes' as ORACLE_IS_READY from dual;" > $DIR/init.output
    ready=`grep yes $DIR/init.output | wc -l`
    sleep 1;
done;
echo "Oracle is ready";