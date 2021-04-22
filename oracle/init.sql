set feedback off;

create or replace procedure drop_table_if_exists(name varchar2)
is 
    c int;
begin
    execute immediate 'drop table ' || name;
    exception
        when others then
            if sqlcode != -942 then
                raise;
            end if;
end;
/

create or replace procedure drop_type_if_exists(name varchar2)
is 
    c int;
begin
    execute immediate 'drop type ' || name;
    exception
        when others then
            if sqlcode != -4043 then
                raise;
            end if;
end;
/