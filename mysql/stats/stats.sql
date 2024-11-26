select external_id, count(id) count
from events
group by external_id;