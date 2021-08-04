#!/bin/bash

function test_dates_varchar_use_requires_left_padding {
    DIR=$(current_dir ${BASH_SOURCE[0]})

    executeFile $DIR/data-with-left-padding.sql
    executeFile $DIR/select.sql > $DIR/run.output
    actual=`grep "1 row" ${DIR}/run.output`

    assertequals "$actual" "(1 row)"
}

function test_dates_missing_left_padding_will_hide_data {
    DIR=$(current_dir ${BASH_SOURCE[0]})

    executeFile $DIR/data-without-left-padding.sql
    executeFile $DIR/select.sql > $DIR/run.output
    actual=`grep "0 rows" ${DIR}/run.output`

    assertequals "$actual" "(0 rows)"
}