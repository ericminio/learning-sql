#!/bin/bash

source ./support/yop-testing-bash/dist/utils.sh
source ./mysql/load/bulk.sh

function test_load_data_from_file_with_headers {
    DIR=$(current_dir ${BASH_SOURCE[0]})

    executeFile $DIR/schema.sql > $DIR/run.output
    bulk_copy "./mysql/load/data.csv" "events" 

    executeFile $DIR/load.sql > $DIR/run.output
    value=`cat ${DIR}/run.output | head -5 | tail -1 | shrink`

    assertequals "$value" "| BB | 2 |"
}

function test_load_data_from_csv_resisting_comma_in_data {
    DIR=$(current_dir ${BASH_SOURCE[0]})

    executeFile $DIR/comma.sql > $DIR/run.output
    bulk_copy "./mysql/load/data_comma.csv" "events" 

    executeFile $DIR/load_comma.sql > $DIR/run.output
    value=`cat ${DIR}/run.output | head -4 | tail -1 | cut -d '|' -f 2,3 | shrink | trim`

    assertequals "$value" "AA, BB | 2"
}