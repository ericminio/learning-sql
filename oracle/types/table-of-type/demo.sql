@@./oracle/init.sql

execute drop_table_if_exists('EXTERNAL_PERSON_TABLE');
execute drop_type_if_exists('EXTERNAL_PERSON');

create type EXTERNAL_PERSON as object (
    name    varchar2(30),
    data    int
)
/

create table EXTERNAL_PERSON_TABLE of EXTERNAL_PERSON;
insert into EXTERNAL_PERSON_TABLE values ('Bob', 111);
insert into EXTERNAL_PERSON_TABLE values ('Alice', 222);

select sum(data) as TOTAL from EXTERNAL_PERSON_TABLE;