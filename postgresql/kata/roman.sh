#!/bin/bash

function test_roman_kata {
    DIR=$(current_dir ${BASH_SOURCE[0]})

    executeFile $DIR/roman.sql > $DIR/run.output
    cat $DIR/run.output
    failures=`grep "F" ${DIR}/run.output | wc -l `
    
    assertequals "$failures failure(s)" "0 failure(s)"
}