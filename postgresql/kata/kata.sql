insert into expectations(incoming, expected) values('I', 1);

create or replace function roman(incoming varchar) 
returns integer as $$
begin
    return 1;
end;
$$  LANGUAGE plpgsql;

insert into actuals(expectation_id, actual) select id, roman(incoming) from expectations;
