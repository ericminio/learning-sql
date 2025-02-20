drop table if exists products;

create table products (
    id serial primary key,
    name text not null
);

insert into products (id, name) values (1, 'apple');
insert into products (id, name) values (3, 'cherry');

do $$
begin
    if not exists (select 1 from products where id = 1) then
        insert into products (id, name) values (2, 'banana');
    end if;
end $$;

do $$
begin
    if exists (select 1 from products where id = 1) then
        insert into products (id, name) values (2, 'cherry');
    end if;
end $$;
