select 
    incoming, expected, actual, 
    (
        select case when expected = actual then '.' else 'FAIL' end
        from actuals
        where actuals.expectation_id = expectations.id
    ) as test 
from expectations, actuals
where actuals.expectation_id = expectations.id
order by id;



