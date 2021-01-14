@@./oracle/init.sql

execute drop_table_if_exists('event');
create table event(
    type varchar2(10) not null,
    label varchar2(50) not null
);

insert into event(type, label) values('MATCH', 'new year');
insert into event(type, label) values('MATCH', 'new month');
insert into event(type, label) values('MATCH', 'new day');
insert into event(type, label) values('MATCH', 'new hour');
insert into event(type, label) values('MATCH', 'new minute');
