USE exploration
GO
IF EXISTS (select 1 from INFORMATION_SCHEMA.TABLES where TABLE_NAME = 'PRODUCT')
	DROP TABLE PRODUCT
GO

CREATE TABLE PRODUCT (
    ID uniqueidentifier NOT NULL DEFAULT (newid()),
    CREATION datetime NOT NULL DEFAULT (getdate()),
    FIELD varchar(200)
)
GO
