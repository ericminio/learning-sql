#!/bin/bash

source ./mysql/load/bulk.sh

function extract_filename {
    grep -o "[^/]*$" | grep -o "^[^.]*" 
}

function extract_fields {
    sed 's/,/ varchar(100),/g' | sed 's/$/ varchar(100)/'
}

function xbulk {
    local FILE=$1
    local TABLE=`echo $FILE | extract_filename`
    local FIELDS=`head -1 $FILE | extract_fields`
    execute "
        drop table if exists $TABLE;
        create table $TABLE($FIELDS);"
    bulk_copy $FILE $TABLE
}