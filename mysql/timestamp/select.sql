select
    count(1) as event_count
from events
where
    event_start >= '2021-08-16 00:00'
    AND
    event_end < '2021-08-17 00:00'
    