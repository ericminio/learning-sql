#!/bin/bash

export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe

ready=0
while [ "$ready" != "1" ]
do
    echo "waiting for Oracle";
    echo " select 'yes' as ORACLE_IS_READY from dual;" | /u01/app/oracle/product/11.2.0/xe/bin/sqlplus -s SYSTEM/oracle@localhost > ./oracle/support/init.output
    ready=`grep yes ./oracle/support/init.output | wc -l`
    sleep 1;
done;
echo "Oracle is ready";