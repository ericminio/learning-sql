select 
    external_key,
    count(internal_key) as total_count
from events
group by external_key;