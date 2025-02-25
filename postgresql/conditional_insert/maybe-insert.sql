drop table if exists conditional_insert_products;

create table conditional_insert_products (
    id serial primary key,
    name text not null
);

insert into conditional_insert_products (id, name) values (1, 'apple');
insert into conditional_insert_products (id, name) values (3, 'cherry');

do $$
begin
    if not exists (select 1 from conditional_insert_products where id = 1) then
        insert into conditional_insert_products (id, name) values (2, 'banana');
    end if;
end $$;

do $$
begin
    if exists (select 1 from conditional_insert_products where id = 1) then
        insert into conditional_insert_products (id, name) values (2, 'cherry');
    end if;
end $$;
