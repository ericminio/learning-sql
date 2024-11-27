#!/bin/bash

function test_xbulk_can_load_one_field {
    xbulk "./mysql/load/xbulkone.csv"
    value=`execute "select name from xbulkone" | extract_query_result`

    assertequals "$value" "alice bob"
}

function test_xbulk_can_load_two_fields {
    xbulk "./mysql/load/xbulktwo.csv"
    value=`execute "select name, day from xbulktwo" | extract_query_result`

    assertequals "$value" "alice 25 bob 21"
}