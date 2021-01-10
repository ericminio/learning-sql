#!/bin/bash

export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe

while ! echo " select 'yes' as ORACLE_IS_READY from dual;" | /u01/app/oracle/product/11.2.0/xe/bin/sqlplus -s SYSTEM/oracle@localhost
do
    echo "waiting for Oracle";
    sleep 1;
done;
echo "Oracle is ready";