use exploration
go
set nocount on
go
drop table if exists PAYMENT_BATCH
create table PAYMENT_BATCH (
    ORDER_ID int identity(1,1),
    STATUS varchar(10) default ("READY"),
    PAGE int default (NULL)
)
go
insert into PAYMENT_BATCH default values
go 7

create or alter function next_page() returns table as return (
    select  top 3 ORDER_ID 
    from    PAYMENT_BATCH 
    where   status = "READY"
)
go
create or alter procedure charge(@id int) as
begin
    update  PAYMENT_BATCH 
    set     STATUS = "SUCCESS"
    where   ORDER_ID = @id
end
go

declare @page TABLE (ID int)
declare @page_number int = 0

insert into @page select * from next_page()
while (select count(1) from @page) > 0
begin
    set @page_number = @page_number + 1
    declare candidates cursor for select ID from @page
    open candidates
    declare @id int
    fetch next from candidates into @id
    while @@fetch_status = 0
    begin
        update PAYMENT_BATCH set PAGE = @page_number where ORDER_ID = @id
        execute charge @id
        fetch next from candidates into @id
    end
    close candidates
    deallocate candidates

    delete from @page
    insert into @page select * from next_page()
end

select  count(*) as COUNT
from    PAYMENT_BATCH 
group by PAGE