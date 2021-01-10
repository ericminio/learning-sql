#!/bin/bash

source ./oracle/support/dir.sh

function executeFile {
    export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe
    /u01/app/oracle/product/11.2.0/xe/bin/sqlplus -s SYSTEM/oracle@localhost  < $1
}

function test_can_use_sqlplus_with_file {
    DIR=$(current_dir ${BASH_SOURCE[0]})

    executeFile ${DIR}/hello.sql > ${DIR}/run.output
    ls -la $DIR
    cat ${DIR}/run.output
    grep "Hello" ${DIR}/run.output | wc -l
    actual=`grep "Hello" ${DIR}/run.output | wc -l`

    assertequals "$actual" "0"
}