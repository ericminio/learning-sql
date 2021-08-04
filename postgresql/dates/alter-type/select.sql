select
    *
from events
where
    event_start <= '2021-08-16 23:59'
    AND
    event_end >= '2021-08-16 00:00'
    