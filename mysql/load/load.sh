#!/bin/bash

source ./support/yop-testing-bash/dist/utils.sh

function test_load_data_from_file_with_headers {
    DIR=$(current_dir ${BASH_SOURCE[0]})

    executeFile $DIR/load.sql > $DIR/run.output
    value=`cat ${DIR}/run.output | head -5 | tail -1 | shrink`

    assertequals "$value" "| BB | 2 |"
}