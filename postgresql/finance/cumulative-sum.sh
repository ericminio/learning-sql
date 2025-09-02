#!/bin/bash

function schema {
    DIR=$(current_dir ${BASH_SOURCE[0]})

    execute "drop table if exists transactions"
    execute "create table transactions(user_id integer, product_id integer, amount numeric, created_at timestamp)"
}

function test_can_group_two_rows_from_same_day {
    DIR=$(current_dir ${BASH_SOURCE[0]})
    schema
    execute "insert into transactions(user_id, product_id, amount, created_at) values (1, 2, 100, '2023-01-01 10:00:00')"
    execute "insert into transactions(user_id, product_id, amount, created_at) values (3, 4, 200, '2023-01-01 15:00:00')"
    local actual=$(execute "select created_at::date, sum(amount) as total_amount from transactions group by created_at::date")
    local values=$(echo "$actual" | extract_query_result)

    assertequals "$values" "2023-01-01 300"
}

function test_can_group_several_records_from_several_days {
    DIR=$(current_dir ${BASH_SOURCE[0]})
    schema
    execute "insert into transactions(user_id, product_id, amount, created_at) values (1, 2, 100, '2023-01-01 10:00:00')"
    execute "insert into transactions(user_id, product_id, amount, created_at) values (3, 4, 200, '2023-01-02 15:00:00')"
    execute "insert into transactions(user_id, product_id, amount, created_at) values (5, 6, 150, '2023-01-02 18:00:00')"
    local actual=$(execute "select created_at::date, sum(amount) as total_amount from transactions group by created_at::date")
    local values=$(echo "$actual" | extract_query_result)

    assertequals "$values" "2023-01-01 100 2023-01-02 350"
}

function test_can_calculate_cumulative_sum {
    DIR=$(current_dir ${BASH_SOURCE[0]})
    schema
    execute "insert into transactions(user_id, product_id, amount, created_at) values (1, 2, 100, '2023-01-01 10:00:00')"
    execute "insert into transactions(user_id, product_id, amount, created_at) values (3, 4, 200, '2023-01-02 15:00:00')"
    execute "insert into transactions(user_id, product_id, amount, created_at) values (5, 6, 150, '2023-01-02 18:00:00')"
    local actual=$(execute "select created_at::date, sum(sum(amount)) over (order by created_at::date) as cumulative_amount from transactions group by created_at::date order by created_at::date")
    local values=$(echo "$actual" | extract_query_result)

    assertequals "$values" "2023-01-01 100 2023-01-02 450"
}