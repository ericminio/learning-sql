USE exploration
GO

select *
from 
    ( select 
        ROW_NUMBER() over ( order by CREATION desc ) as ROWNUM
        , NAME
        , CREATION
    from PRODUCT
    ) as LAST_FIRST
where ROWNUM=1
    and CREATION < '2015-02-01'

