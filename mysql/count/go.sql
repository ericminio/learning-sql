drop table if exists events;
create table events(
        id varchar(1), 
        user varchar(10)
);
insert into events(id, user) values('z', 'A');

insert into events(id, user) values('y', 'A');
insert into events(id, user) values('y', 'B');
insert into events(id, user) values('y', 'C');
insert into events(id, user) values('y', 'D');

insert into events(id, user) values('w', 'A');
insert into events(id, user) values('w', 'B');
insert into events(id, user) values('w', 'C');

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