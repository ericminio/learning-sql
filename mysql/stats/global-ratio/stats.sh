#!/bin/bash

source ./support/yop-testing-bash/dist/utils.sh
source ./mysql/load/bulk.sh

function test_stats_flagged_percentage {
    DIR=$(current_dir ${BASH_SOURCE[0]})
    executeFile $DIR/schema.sql > $DIR/run.output
    bulk_copy "./mysql/stats/global-ratio/data.csv" "events" 

    executeFile $DIR/stats.sql > $DIR/run.output
    value=`cat ${DIR}/run.output | head -4 | tail -1 | cut -d '|' -f 2 | trim`

    assertequals "$value" "60%"
}