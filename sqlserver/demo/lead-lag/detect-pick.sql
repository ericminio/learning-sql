USE exploration
GO

declare @threshold int = 15

select 
    NAME
from (    
    select 
        NAME
        , VALUE
        , abs(VALUE - LAG(VALUE, 1, VALUE) over (order by CREATION)) as previous 
        , abs(VALUE - LEAD(VALUE, 1, VALUE) over (order by CREATION)) as next
    from PRODUCT
) deltas
where 
    previous > @threshold
    and next > @threshold
