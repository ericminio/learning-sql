drop table if exists tests;
drop table if exists actuals;
drop table if exists expectations;

create table expectations(
    id serial primary key,
    incoming varchar,
    expected integer
);

create table actuals(
    expectation_id integer,
    actual integer,
    constraint fk_actuals_expectations foreign key(expectation_id) references expectations(id)
);

create table tests(
    expectation_id integer,
    test varchar,
    constraint fk_tests_expectations foreign key(expectation_id) references expectations(id)
);