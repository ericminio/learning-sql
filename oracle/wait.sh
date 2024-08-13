#!/bin/bash

source ./oracle/init.sh
source ./support/dir.sh
source ./support/waiting.sh

function wait_for_oracle {
    local DIR=$(current_dir ${BASH_SOURCE[0]})
    execute "select 'yes' as ORACLE_IS_READY from dual;" > $DIR/init.output
    grep yes $DIR/init.output | wc -l
}

waiting oracle wait_for_oracle