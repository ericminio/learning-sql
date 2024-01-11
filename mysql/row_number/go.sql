drop table if exists signatures;
create table signatures(
    petition_id varchar(2),
    zipcode varchar(2)
);

insert into signatures(petition_id, zipcode) values('P1', 'z1');
insert into signatures(petition_id, zipcode) values('P1', 'z2');
insert into signatures(petition_id, zipcode) values('P1', 'z2');
insert into signatures(petition_id, zipcode) values('P1', 'z3');

insert into signatures(petition_id, zipcode) values('P2', 'z1');

with 
signatures_count_by_zipcode as (
    select 
        petition_id,
        zipcode,
        count(zipcode) zipcode_count
    from signatures
    group by petition_id, zipcode
    order by zipcode_count desc
)

select
    petition_id,
    zipcode,
    zipcode_count * 100 / (
        select count(zipcode) from signatures where petition_id = best.petition_id group by petition_id
    ) as percentage
from (
    select
        petition_id, 
        zipcode, 
        zipcode_count
    from (
        select 
            petition_id,
            zipcode,
            zipcode_count,
            ROW_NUMBER() over (
                partition by petition_id        
            ) row_num
        from signatures_count_by_zipcode
    ) with_row_number
    where row_num = 1
) best
;