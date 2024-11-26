drop table if exists events;
create table events(
    id varchar(10), 
    external_id varchar(10),
    flag boolean
);

load data local
    infile './mysql/load/data.csv' 
    into table events
    fields terminated by ','
    lines terminated by '\n'
    ignore 1 lines
    (id, external_id, flag);

select external_id, count(id) count
from events
group by external_id;