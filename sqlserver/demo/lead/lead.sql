USE exploration
GO
select FIELD, LEAD(CREATION, 1, NULL) over (order by CREATION) from PRODUCT
GO