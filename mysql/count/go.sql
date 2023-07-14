drop table if exists events;
create table events(
        id varchar(1), 
        user varchar(10)
);
insert into events(id, user) values('1', 'A');
insert into events(id, user) values('1', 'B');

insert into events(id, user) values('2', 'A');
insert into events(id, user) values('2', 'B');
insert into events(id, user) values('2', 'C');
insert into events(id, user) values('2', 'D');

insert into events(id, user) values('3', 'A');
insert into events(id, user) values('3', 'B');
insert into events(id, user) values('3', 'C');

select count(id) from 
(
    select 
        id,
        count(user) user_count
    from
        events
    group by
        id
    having 
        user_count >= 3
) as popular_events
;