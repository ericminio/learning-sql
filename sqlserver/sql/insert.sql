SET NOCOUNT ON
GO

USE exploration
GO
delete PRODUCT
GO

insert into PRODUCT (CREATION, FIELD) values ('2015-01-15', 'Love')
GO
insert into PRODUCT (CREATION, FIELD) values ('2015-01-15', 'Happiness')
GO
insert into PRODUCT (CREATION, FIELD) values ('2015-01-15', 'Beauty')
GO

insert into PRODUCT (CREATION, FIELD) values ('2020-01-15', 'Wisdom')
GO
insert into PRODUCT (CREATION, FIELD) values ('2020-01-15', 'Peace')
GO
insert into PRODUCT (CREATION, FIELD) values ('2020-01-15', 'Strength')
GO
