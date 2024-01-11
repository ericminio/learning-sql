#!/bin/bash

function test_row_number_can_identify_best_seller {
    DIR=$(current_dir ${BASH_SOURCE[0]})

    executeFile $DIR/go.sql > $DIR/run.output
    value=`cat ${DIR}/run.output | head -4 | tail -1`

    assertequals "$value" "| P1          | z2      |    50.0000 |"
}

function test_row_number_can_identify_best_seller_when_alone {
    DIR=$(current_dir ${BASH_SOURCE[0]})

    executeFile $DIR/go.sql > $DIR/run.output
    value=`cat ${DIR}/run.output | head -5 | tail -1`

    assertequals "$value" "| P2          | z1      |   100.0000 |"
}