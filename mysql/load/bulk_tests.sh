#!/bin/bash

function test_load_data_from_csv_with_headers {
    DIR=$(current_dir ${BASH_SOURCE[0]})
    execute "
        drop table if exists events;
        create table events(
            id varchar(10), 
            external_id varchar(10),
            flag boolean
        );"
    bulk_copy "./mysql/load/data.csv" "events" 

    execute "
        select external_id, count(id) count
        from events
        group by external_id;" > $DIR/run.output
    value=`cat ${DIR}/run.output | extract_query_result`

    assertequals "$value" "AA 4 BB 2"
}

function test_load_data_from_csv_resisting_comma_in_data {
    DIR=$(current_dir ${BASH_SOURCE[0]})

    execute "
        drop table if exists events;
        create table events(
            internal_key varchar(10), 
            external_key varchar(10)
        );"
    bulk_copy "./mysql/load/data_comma.csv" "events" 

    execute "
        select 
            external_key,
            count(internal_key) as total_count
        from events
        group by external_key;" > $DIR/run.output
    value=`cat ${DIR}/run.output | extract_query_result`

    assertequals "$value" "AA, BB 2"
}