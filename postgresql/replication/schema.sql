drop table if exists products cascade;

create table products(
  id serial primary key,
  name varchar
);