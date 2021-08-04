drop table if exists events;
create table events(
    id serial primary key,
    name varchar,
    event_start varchar,
    event_end varchar
);
insert into events(name, event_start, event_end) 
    values('Alex', '2021-08-16 09:30', '2021-08-16 12:30');
insert into events(name, event_start, event_end) 
    values('Joe', '2021-08-20 12:00', '2021-08-20 18:00');

