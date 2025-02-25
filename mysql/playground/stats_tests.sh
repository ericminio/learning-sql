#!/bin/bash

source ./mysql/utils.sh
source ./mysql/load/xbulk.sh

function test_stats_loading {
    xbulk "./mysql/playground/voters.csv"
    value=`execute "select count(1) from voters" | extract_query_result`

    assertequals $value 10482
}

function test_stats_inspect {
    xbulk "./mysql/playground/voters.csv"
    execute "
        with 
        voters_by_petition as (
            select 
                petition_id,
                count(user_id) voters 
            from voters
            where verified_voter='TRUE'
            group by petition_id
        ),
        signatures_by_petition as (
            select 
                petition_id,
                title,
                count(user_id) signatures
            from voters
            group by petition_id, title
        )

        select 
            voters_by_petition.petition_id,
            signatures,
            concat(round(voters / signatures * 100), '%') as voters_rate,
            title
        from voters_by_petition, signatures_by_petition
        where voters_by_petition.petition_id = signatures_by_petition.petition_id
        order by voters_rate desc
    "
}
