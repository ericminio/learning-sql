drop table if exists comments;
drop table if exists products;

create table products(
    id serial primary key,
    name text
);
create table comments(
    id serial primary key,
    product_id integer,
    created_at varchar,
    constraint fk_comments_products foreign key(product_id) references products(id)
);

insert into products(id, name) values 
(1, 'mouse'),
(2, 'keyboard');

select count(1) from products;