#!/bin/bash

function test_can_use_mysql_with_query {
    DIR=$(current_dir ${BASH_SOURCE[0]})

    execute "select 'welcome' as MESSAGE;" > ${DIR}/run.output
    actual=`grep "welcome" ${DIR}/run.output | wc -l`

    assertequals "$actual" "1"
}

function test_can_use_mysql_with_file {
    DIR=$(current_dir ${BASH_SOURCE[0]})

    executeFile ${DIR}/hello.sql > ${DIR}/run.output
    actual=`grep "Hello" ${DIR}/run.output | wc -l`

    assertequals "$actual" "1"
}

function test_can_use_mysql_with_file_containin_several_statements {
    DIR=$(current_dir ${BASH_SOURCE[0]})

    executeFile ${DIR}/hellos.sql > ${DIR}/run.output
    actual=`grep "Hello" ${DIR}/run.output | wc -l`

    assertequals "$actual" "1"
}

