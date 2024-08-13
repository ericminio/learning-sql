#!/bin/bash

source ./postgresql/init.sh

function test_roman_to_numeral_kata {
    DIR=$(current_dir ${BASH_SOURCE[0]})
    
    executeFile $DIR/schema.sql
    executeFile $DIR/kata.sql
    executeFile $DIR/report.sql > $DIR/run.output
    cat $DIR/run.output
    
    count=`grep "FAIL" ${DIR}/run.output | wc -l `    
    assertequals "$count failure(s)" "0 failure(s)"
}