#!/bin/bash

function extract_filename {
    echo "$1" | grep -o "[^/]*$" | grep -o "^[^.]*" 
}

function xbulk {
    local FILE=$1
    local TABLE=`extract_filename $FILE`
    local FIELDS=`head -1 $FILE | sed 's/,/ varchar(100),/' | sed 's/$/ varchar(100)/'`
    execute "
        drop table if exists $TABLE;
        create table $TABLE($FIELDS);"
    bulk_copy $FILE $TABLE
}