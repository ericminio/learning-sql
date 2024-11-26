select concat(round(100 * flag_true_count / total_count, 0), '%') as flag_true_ratio
from (
    select 
        sum(case 
                when flag = 'TRUE' then 1
                else 0
            end
        ) as flag_true_count,
        sum(1) as total_count
    from events
) as totals
;