#!/bin/bash

source ./oracle/init.sh
source ./support/dir.sh

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
