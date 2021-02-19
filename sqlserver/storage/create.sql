USE exploration
GO
SET NOCOUNT ON
GO
	
DROP TABLE IF EXISTS PRODUCT
GO
CREATE TABLE PRODUCT (
    CREATION_DATE date,
    Field8kbLong varchar(8000)
)
GO

insert into PRODUCT (CREATION_DATE, Field8kbLong) values ('2021-01-01', replicate('A', 4000))
insert into PRODUCT (CREATION_DATE, Field8kbLong) values ('2021-01-02', replicate('B', 8000))
insert into PRODUCT (CREATION_DATE, Field8kbLong) values ('2021-01-03', replicate('C', 4000))

select substring(Field8kbLong, 1, 1) as RECORD, CREATION_DATE from PRODUCT
select substring(Field8kbLong, 1, 1) as RECORD, CREATION_DATE from PRODUCT order by CREATION_DATE
