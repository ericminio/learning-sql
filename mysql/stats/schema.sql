drop table if exists events;
create table events(
    id varchar(10), 
    external_id varchar(10),
    flag boolean
);