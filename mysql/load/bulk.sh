#!/bin/bash

function bulk_copy {
    local FILE=$1
    local TABLE=$2

    execute "load data local
                infile '$FILE' 
                into table $TABLE 
                fields terminated by ',' 
                lines terminated by '\n' 
                ignore 1 lines"
}