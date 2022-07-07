drop table if exists events;
create table events(
    name varchar(50),
    event_start timestamp,
    event_end timestamp
);
insert into events(name, event_start, event_end) 
    values('Alex', '2021-08-16 9:30', '2021-08-16 12:30');
insert into events(name, event_start, event_end) 
    values('Joe', '2021-08-16 12:00', '2021-08-20 18:00');

