DECLARE
    c int;
BEGIN
    select count(*) into c from user_tables where table_name = 'EVENT';
    if c = 1 then
        execute immediate 'drop table EVENT';
    end if;
END;
/   
create table event(
    type varchar2(10) not null,
    label varchar2(50) not null
);

insert into event(type, label) values('MATCH', 'new year');
insert into event(type, label) values('MATCH', 'new month');
insert into event(type, label) values('MATCH', 'new day');
insert into event(type, label) values('MATCH', 'new hour');
insert into event(type, label) values('MATCH', 'new minute');

select * from event where rownum <= 3;