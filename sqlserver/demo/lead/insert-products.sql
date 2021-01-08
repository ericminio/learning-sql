SET NOCOUNT ON
GO

USE exploration
GO
delete PRODUCT
GO

insert into PRODUCT (CREATION, FIELD) values ('2015-01-01', 'Love')
GO
insert into PRODUCT (CREATION, FIELD) values ('2015-01-02', 'Happiness')
GO
insert into PRODUCT (CREATION, FIELD) values ('2015-01-03', 'Beauty')
GO
