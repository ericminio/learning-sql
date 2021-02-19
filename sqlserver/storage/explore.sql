USE exploration
GO
SET NOCOUNT ON
GO
	
DROP TABLE IF EXISTS PRODUCT
GO
CREATE TABLE PRODUCT (
    Field8kbLong varchar(8000)
)
GO

insert into PRODUCT (Field8kbLong) values (replicate('A', 1000))
insert into PRODUCT (Field8kbLong) values (replicate('B', 4000))
insert into PRODUCT (Field8kbLong) values (replicate('C', 8000))
select  index_type_desc, page_count, record_count, forwarded_record_count from sys.dm_db_index_physical_stats(db_id(), object_id('PRODUCT'), null, null, 'detailed')
select	allocated_page_page_id, page_free_space_percent, page_type_desc
	from	sys.dm_db_database_page_allocations(DB_ID(), OBJECT_ID(N'PRODUCT', N'U'), 0, NULL, N'DETAILED')
	where	page_type_desc is not null
select  %%lockres%%, substring(Field8kbLong, 1, 1) as RECORD from PRODUCT 

DBCC IND('exploration', 'PRODUCT', -1)
DBCC TRACEON(3604)
-- DBCC PAGE('exploration', 1, 304, 1)

update PRODUCT set Field8kbLong = replicate('A', 8000) where Field8kbLong like 'A%'

select  index_type_desc, page_count, record_count, forwarded_record_count from sys.dm_db_index_physical_stats(db_id(), object_id('PRODUCT'), null, null, 'detailed')
select	allocated_page_page_id, page_free_space_percent, page_type_desc
	from	sys.dm_db_database_page_allocations(DB_ID(), OBJECT_ID(N'PRODUCT', N'U'), 0, NULL, N'DETAILED')
	where	page_type_desc is not null
select  %%lockres%%, substring(Field8kbLong, 1, 1) as RECORD from PRODUCT 

DBCC IND('exploration', 'PRODUCT', -1)
DBCC TRACEON(3604)
DBCC PAGE('exploration', 1, 304, 3)
