USE exploration
GO
IF EXISTS (select 1 from INFORMATION_SCHEMA.TABLES where TABLE_NAME = 'PRODUCT')
	DROP TABLE PRODUCT
GO

CREATE TABLE PRODUCT (
    ID uniqueidentifier NOT NULL DEFAULT (newid()),
    CREATION date NOT NULL DEFAULT (getdate()),
    NAME varchar(10),
    VALUE int
)
GO

SET NOCOUNT ON
GO
insert into PRODUCT (CREATION, NAME, VALUE) values ('2015-01-15', 'Love', 1)
insert into PRODUCT (CREATION, NAME, VALUE) values ('2015-02-15', 'Love', 2)
GO
