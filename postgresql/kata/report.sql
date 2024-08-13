insert into tests(expectation_id, test) 
select 
    id,
    (
        select case when expected = actual then '.' else 'FAIL' end
        from actuals
        where actuals.expectation_id = expectations.id
    )
from expectations;

select incoming, expected, actual, test 
from expectations, actuals, tests
where 
    actuals.expectation_id = expectations.id
    and tests.expectation_id = expectations.id
order by id;



