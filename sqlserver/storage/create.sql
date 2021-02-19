USE exploration
GO
SET NOCOUNT ON
GO
	
DROP TABLE IF EXISTS PRODUCT
GO
CREATE TABLE PRODUCT (
    CREATION_DATE datetime default (getdate()),
    Field8kbLong varchar(8000)
)
GO

insert into PRODUCT (Field8kbLong) values (replicate('A', 4000))
insert into PRODUCT (Field8kbLong) values (replicate('B', 8000))
insert into PRODUCT (Field8kbLong) values (replicate('C', 4000))

select substring(Field8kbLong, 1, 1) as RECORD from PRODUCT
select substring(Field8kbLong, 1, 1) as RECORD from PRODUCT order by CREATION_DATE
