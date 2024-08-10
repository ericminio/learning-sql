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

insert into expectations(incoming, expected) values('IV', 4);
create or replace function roman(incoming varchar) 
returns integer as $$
declare
    decimal_value integer;
    candidate varchar;
    remaining varchar;
begin
    decimal_value := 0;
    remaining := incoming;
    
    candidate := 'IV'; 
    while length(remaining) > 0 and candidate = substring(remaining from 1 for length(candidate)) loop 
        decimal_value := decimal_value + 4;
        remaining = substring(remaining from 1 + length(candidate));
    end loop;

    candidate := 'I'; 
    while length(remaining) > 0 and candidate = substring(remaining from 1 for length(candidate)) loop 
        decimal_value := decimal_value + 1;
        remaining = substring(remaining from 1 + length(candidate));
    end loop;

    return decimal_value;
end;
$$  LANGUAGE plpgsql;

drop table if exists dico;
create table dico(
    translation_priority integer primary key,
    roman_value varchar,
    decimal_value integer
);
insert into dico(translation_priority, roman_value, decimal_value) values
(1, 'IV', 4),
(2, 'I', 1)
;

create or replace function roman(incoming varchar) 
returns integer as $$
declare
    decimal_value integer;
    candidate varchar;
    candidate_value integer;
    remaining varchar;
    cdico cursor for select dico.roman_value, dico.decimal_value from dico order by translation_priority;
begin
    decimal_value := 0;
    remaining := incoming;

    for dico_entry in cdico loop
        candidate := dico_entry.roman_value;
        candidate_value := dico_entry.decimal_value;
        while length(remaining) > 0 and candidate = substring(remaining from 1 for length(candidate)) loop 
            decimal_value := decimal_value + candidate_value;
            remaining = substring(remaining from 1 + length(candidate));
        end loop;
    end loop;

    return decimal_value;
end;
$$  LANGUAGE plpgsql;

update expectations set actual = roman(incoming);
update expectations set result = (select case when expected = actual then 'OK' else 'FAILED' end as result);
select incoming, expected, actual, result from expectations order by id;



