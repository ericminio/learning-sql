#!/bin/bash

source ./mysql/utils.sh
source ./mysql/load/xbulk.sh

function test_xbulk_extract_filename_remove_extension {
    value=`echo "./mysql/load/xbulkone.csv" | extract_filename`

    assertequals "$value" "xbulkone"
}

function test_xbulk_can_digest_three_fields {
    value=`echo "one,two,three" | extract_fields`

    assertequals "$value" "one varchar(100),two varchar(100),three varchar(100)"
}

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