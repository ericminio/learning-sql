#!/bin/bash

source ./postgresql/utils.sh

function test_distance_is_zero_for_same_person {
    DIR=$(current_dir ${BASH_SOURCE[0]})
    executeFile $DIR/schema.sql

    execute "insert into persons(id, name) values (1, 'Alice')"
    execute "select compute_distances()"

    execute "select person_id_from, person_id_to, distance from distances" > $DIR/run.output
    actual=`grep "0" $DIR/run.output | shrink | trim`

    assertequals "$actual" "1 | 1 | 0"
}