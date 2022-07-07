drop table if exists events;
create table events(
    name varchar(50),
    instant timestamp
);
insert into events(name, instant) values('Alex', '2022-02-01 12:30');
insert into events(name, instant) values('Joe', '2022-02-20 12:30');

select 
    * 
from events
where instant > date_add('2022-02-15', interval -15 day)
;