drop table if exists product;
create table product (name varchar(50));
insert into product(name) values('Hello');
insert into product(name) values('World');

select name from product;
