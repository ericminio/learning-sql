USE exploration
GO
SET NOCOUNT ON
GO
	
DROP TABLE IF EXISTS PRODUCT
GO
CREATE TABLE PRODUCT (
    ID char(1),
    MAXIMUM_PAGE_CAPACITY varchar(8000)
)
GO

insert into PRODUCT (ID, MAXIMUM_PAGE_CAPACITY) values ('1', replicate('A', 1000))
insert into PRODUCT (ID, MAXIMUM_PAGE_CAPACITY) values ('2', replicate('B', 4000))
insert into PRODUCT (ID, MAXIMUM_PAGE_CAPACITY) values ('3', replicate('C', 8000))
update PRODUCT set MAXIMUM_PAGE_CAPACITY = replicate('A', 8000) where ID = '1'
GO

select  index_type_desc, page_count, record_count, forwarded_record_count from sys.dm_db_index_physical_stats(db_id(), object_id('PRODUCT'), null, null, 'detailed')
select  %%lockres%%, ID from PRODUCT 

declare @page int
select top 1 @page = allocated_page_page_id 
from sys.dm_db_database_page_allocations(DB_ID(), OBJECT_ID(N'PRODUCT', N'U'), 0, NULL, N'DETAILED') 
where page_type_desc='DATA_PAGE' 
order by allocated_page_page_id

DBCC IND('exploration', 'PRODUCT', -1)
DBCC TRACEON(3604)
DBCC PAGE('exploration', 1, @page, 3)