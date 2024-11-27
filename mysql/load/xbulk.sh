#!/bin/bash

function xbulk {
    local FILE=$1
    local TABLE=`echo $FILE | grep -o "[^/]*$" | cut -d '.' -f1`
    local FIELDS=`head -1 $FILE | sed 's/,/ varchar(10),/' | sed 's/$/ varchar(10)/'`
    execute "
        drop table if exists $TABLE;
        create table $TABLE($FIELDS);"
        
    bulk_copy $FILE $TABLE
}