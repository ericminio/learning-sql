#!/bin/bash

function test_xbulk_can_load_one_field {
    DIR=$(current_dir ${BASH_SOURCE[0]})
    xbulk "./mysql/load/xbulkone.csv"

    execute "
        select *
        from xbulkone
    " > $DIR/run.output
    value=`cat ${DIR}/run.output | extract_query_result`

    assertequals "$value" "alice bob"
}

function test_xbulk_can_load_two_fields {
    DIR=$(current_dir ${BASH_SOURCE[0]})
    xbulk "./mysql/load/xbulktwo.csv"

    execute "
        select *
        from xbulktwo
    " > $DIR/run.output
    value=`cat ${DIR}/run.output | extract_query_result`

    assertequals "$value" "alice 25 bob 21"
}