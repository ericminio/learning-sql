drop table if exists distances;
drop table if exists persons;

create table persons(
  id serial primary key,
  name varchar
);
create table distances(
  id serial primary key,
  person_id_from integer references persons(id),
  person_id_to integer references persons(id),
  distance integer
);

create or replace function distance() 
returns integer as $$
declare
    decimal_value integer;
begin
    decimal_value := 0;
    return decimal_value;
end;
$$  LANGUAGE plpgsql;

create or replace function compute_distances()
returns void as $$
declare
    person_from record;
    person_to record;
begin
    for person_from in select * from persons loop
        for person_to in select * from persons loop
            insert into distances(person_id_from, person_id_to, distance) values (person_from.id, person_to.id, distance());
        end loop;
    end loop;
end;
$$  LANGUAGE plpgsql;