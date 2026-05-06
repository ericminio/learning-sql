#!/bin/bash

source ./postgresql/utils.sh

function recreate_schema {
    DIR=$(current_dir ${BASH_SOURCE[0]})
    executeFile $DIR/schema.sql
    execute_on_standby "SELECT pg_wal_replay_resume()"
    wait_for_replication_done
}

function test_replication_happens {
    DIR=$(current_dir ${BASH_SOURCE[0]})
    recreate_schema

    execute_on_primary "insert into products(id, name) values (1, 'Mouse')"
    wait_for_replication_done

    execute_on_standby "select count(*) from products" > $DIR/run.output
    actual=`grep " 1" $DIR/run.output | shrink | trim`

    assertequals "$actual" "1"
}

function test_replication_can_be_paused {
    DIR=$(current_dir ${BASH_SOURCE[0]})
    recreate_schema

    execute_on_standby "SELECT pg_wal_replay_pause()"
    execute_on_primary "insert into products(id, name) values (1, 'Mouse')"
    sleep 1
    
    execute_on_standby "select count(*) from products" > $DIR/run.output
    actual=`grep " 0" $DIR/run.output | shrink | trim`

    assertequals "$actual" "0"
}

function test_replication_can_be_resumed {
    DIR=$(current_dir ${BASH_SOURCE[0]})
    recreate_schema

    execute_on_standby "SELECT pg_wal_replay_pause()"
    execute_on_primary "insert into products(id, name) values (1, 'Mouse')"
    
    execute_on_standby "SELECT pg_wal_replay_resume()"
    wait_for_replication_done

    execute_on_standby "select count(*) from products" > $DIR/run.output
    actual=`grep " 1" $DIR/run.output | shrink | trim`

    assertequals "$actual" "1"
}