#!/bin/bash

source ./mysql/utils.sh
source ./mysql/load/xbulk.sh

function test_stats_loading {
    xbulk "./mysql/playground/data.csv"
    value=`execute "select count(1) from xbulkone" | extract_query_result`

    assertequals "$value" "2"
}
