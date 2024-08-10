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
    decimal_value integer;
    candidate varchar;
    remaining varchar;
begin
    decimal_value := 0;
    remaining := incoming;
    
    candidate := 'I'; 
    while length(remaining) > 0 loop
        if candidate = substring(remaining from 1 for length(candidate)) then 
            decimal_value := decimal_value + 1;
        end if;

        remaining = substring(remaining from 1 + length(candidate));
    end loop;

    return decimal_value;
end;
$$  LANGUAGE plpgsql;

update expectations set actual = roman(incoming);
update expectations set result = (select case when expected = actual then 'OK' else 'FAILED' end as result);
select incoming, expected, actual, result from expectations order by id;



