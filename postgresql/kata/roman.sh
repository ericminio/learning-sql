#!/bin/bash

function test_roman_kata {
    DIR=$(current_dir ${BASH_SOURCE[0]})

    executeFile $DIR/roman.sql > $DIR/run.output
    cat $DIR/run.output
    count=`grep "FAIL" ${DIR}/run.output | wc -l `
    
    assertequals "$count failure(s)" "0 failure(s)"
}