SET NOCOUNT ON
GO

USE exploration
GO
delete PRODUCT
GO

insert into PRODUCT (CREATION, FIELD) values ('2015-01-01', 'Love')
insert into PRODUCT (CREATION, FIELD) values ('2015-01-02', 'Happiness')
insert into PRODUCT (CREATION, FIELD) values ('2015-01-03', 'Beauty')
GO
