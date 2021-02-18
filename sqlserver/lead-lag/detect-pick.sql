USE exploration
GO
SET NOCOUNT ON
GO

DROP TABLE IF EXISTS PRODUCT
GO
CREATE TABLE PRODUCT (
    ID uniqueidentifier NOT NULL DEFAULT (newid()),
    CREATION date NOT NULL DEFAULT (getdate()),
    NAME varchar(10),
    VALUE int
)
GO

insert into PRODUCT (CREATION, NAME, VALUE) values ('2015-01-01', 'Love', 1)
insert into PRODUCT (CREATION, NAME, VALUE) values ('2015-01-02', 'Happiness', 2)
insert into PRODUCT (CREATION, NAME, VALUE) values ('2015-01-03', 'Joy', 30)
insert into PRODUCT (CREATION, NAME, VALUE) values ('2015-01-04', 'Wisdom', 3)
insert into PRODUCT (CREATION, NAME, VALUE) values ('2015-01-05', 'Strength', 4)
insert into PRODUCT (CREATION, NAME, VALUE) values ('2015-01-06', 'Beauty', 3)
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
