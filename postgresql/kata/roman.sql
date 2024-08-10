drop table if exists expectations;
create table expectations(
    id serial primary key,
    incoming varchar,
    expected integer,
    actual integer,
    result varchar
);

insert into expectations(incoming, expected) values('I', 1);
create or replace function roman(incoming varchar) 
returns integer as $$
begin
    return 1;
end;
$$  LANGUAGE plpgsql;

insert into expectations(incoming, expected) values('II', 2);
create or replace function roman(incoming varchar) 
returns integer as $$
begin
    if incoming = 'I' then 
        return 1;
    else
        return 2;
    end if;
end;
$$  LANGUAGE plpgsql;
create or replace function roman(incoming varchar) 
returns integer as $$
declare
    value integer;
begin
    if incoming = 'I' then 
        value := 1;
    else
        value := 2;
    end if;
    return value;
end;
$$  LANGUAGE plpgsql;

update expectations set actual = roman(incoming);
update expectations set result = (select case when expected = actual then '.' else 'F' end as result);
select incoming, expected, actual, result from expectations order by id;



