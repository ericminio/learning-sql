with 

flag_true_count_by_external_id as (
    select 
        external_id,
        count(flag) as flag_true_count
    from events 
    where flag = 'TRUE'
    group by external_id    
),

totals as (
    select 
        external_id,
        flag_true_count,
        (
            select count(b.id) 
            from events b 
            where flag_true_count_by_external_id.external_id = b.external_id 
            group by b.external_id
        ) as total_count
    from flag_true_count_by_external_id
)

select 
    external_id,
    concat(round(100 * flag_true_count / total_count, 0), '%') as flag_true_ratio 
from totals
;