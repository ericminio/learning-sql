#!/bin/bash

function test_only_ready {
    DIR=$(current_dir ${BASH_SOURCE[0]})
    executeFile $DIR/go.sql > $DIR/run.output    
    local output=`cat $DIR/run.output | head -n 3 | tail -n 1`

    assertequals $output 2
}