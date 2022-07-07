drop table if exists events;
create table events(
        name varchar(1), 
        instant timestamp
);
insert into events(name, instant) values('A', '2022-02-01');
insert into events(name, instant) values('A', '2022-02-20');
insert into events(name, instant) values('A', '2022-03-01');
insert into events(name, instant) values('B', '2022-02-15');
insert into events(name, instant) values('B', '2022-03-15');
insert into events(name, instant) values('C', '2022-02-11');

select 
    name,
    count(1) as total,
    sum(case 
            when instant between '2022-02-01' and '2022-02-28' then 1
            else 0
        end
    ) as total_february
from events
group by name
having
    total > 1
    and total_february > 1
;