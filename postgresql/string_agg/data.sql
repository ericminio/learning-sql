drop table if exists planes;
create table planes(
    id serial primary key,
    name varchar
);
insert into planes(id ,name) values(1, 'GITN');
insert into planes(id, name) values(2, 'GSDZ');
drop table if exists equipments;
create table equipments(
    id serial primary key,
    name varchar
);
insert into equipments(id, name) values(1, 'radio');
insert into equipments(id, name) values(2, 'altimeter');
insert into equipments(id, name) values(3, 'gps');
drop table if exists equipment_list;
create table equipment_list(
    plane_id serial,
    equipment_id serial
);
insert into equipment_list(plane_id, equipment_id) values (1, 1);
insert into equipment_list(plane_id, equipment_id) values (1, 2);
insert into equipment_list(plane_id, equipment_id) values (1, 3);
insert into equipment_list(plane_id, equipment_id) values (2, 1);
insert into equipment_list(plane_id, equipment_id) values (2, 2);