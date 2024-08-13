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
    body text,
    constraint fk_comments_products foreign key(product_id) references products(id)
);

insert into products(id, name) values 
(1, 'mouse'),
(2, 'keyboard');
insert into comments(product_id, created_at, body) values
(1, '2024-08-01', 'such a great mouse'),
(1, '2024-08-02', 'the only mouse you need'),
(1, '2024-08-03', 'that mouse saved my life'),
(2, '2024-09-01', 'kind off ok keyboard');
