#!/bin/bash

function test_string_agg {
    DIR=$(current_dir ${BASH_SOURCE[0]})

    executeFile $DIR/data.sql
    executeFile $DIR/select.sql > $DIR/run.output
    actual=`grep GITN ${DIR}/run.output`

    assertequals "$actual" " GITN | radio,altimeter,gps"
}