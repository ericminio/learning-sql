#!/bin/bash

source ./support/yop-testing-bash/dist/utils.sh
source ./mysql/load/bulk.sh

function extract_data {
    tail -n +4 | sed '$d' | cut -d '|' -f 2,3 | sed 's/|//g' | oneliner | shrink | trim
}

function test_load_data_from_csv_with_headers {
    DIR=$(current_dir ${BASH_SOURCE[0]})

    executeFile $DIR/schema.sql > $DIR/run.output
    bulk_copy "./mysql/load/data.csv" "events" 

    execute "
        select external_id, count(id) count
        from events
        group by external_id;" > $DIR/run.output
    value=`cat ${DIR}/run.output | extract_data`

    assertequals "$value" "AA 4 BB 2"
}

function test_load_data_from_csv_resisting_comma_in_data {
    DIR=$(current_dir ${BASH_SOURCE[0]})

    executeFile $DIR/schema_comma.sql > $DIR/run.output
    bulk_copy "./mysql/load/data_comma.csv" "events" 

    execute "
        select 
            external_key,
            count(internal_key) as total_count
        from events
        group by external_key;" > $DIR/run.output
    value=`cat ${DIR}/run.output | extract_data`

    assertequals "$value" "AA, BB 2"
}