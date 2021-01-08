SET NOCOUNT ON
GO

USE exploration
GO
delete PRODUCT
GO

insert into PRODUCT (CREATION, AREA, LABEL) values ('2015-01-15', 'one', 'Love')
GO
insert into PRODUCT (CREATION, AREA, LABEL) values ('2015-01-15', 'one', 'Joy')
GO
insert into PRODUCT (CREATION, AREA, LABEL) values ('2015-01-15', 'one', 'Beauty')
GO

insert into PRODUCT (CREATION, AREA, LABEL) values ('2020-01-15', 'two', 'Wisdom')
GO
insert into PRODUCT (CREATION, AREA, LABEL) values ('2020-01-15', 'two', 'Peace')
GO
insert into PRODUCT (CREATION, AREA, LABEL) values ('2020-01-15', 'two', 'Strength')
GO
