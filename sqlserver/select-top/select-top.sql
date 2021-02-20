USE exploration
GO
SET NOCOUNT ON
GO
	
DROP TABLE IF EXISTS PAYMENT_BATCH
CREATE TABLE PAYMENT_BATCH (
    SESSION int,
    PAYMENT_ORDER_ID int,
    STATUS varchar(10)
)
insert into PAYMENT_BATCH (SESSION, PAYMENT_ORDER_ID, STATUS) values (1, 1, "SUCCESS")
insert into PAYMENT_BATCH (SESSION, PAYMENT_ORDER_ID, STATUS) values (2, 2, "READY")
insert into PAYMENT_BATCH (SESSION, PAYMENT_ORDER_ID, STATUS) values (2, 3, "READY")
insert into PAYMENT_BATCH (SESSION, PAYMENT_ORDER_ID, STATUS) values (2, 4, "READY")
insert into PAYMENT_BATCH (SESSION, PAYMENT_ORDER_ID, STATUS) values (2, 5, "READY")
GO
CREATE OR ALTER FUNCTION payments()
RETURNS TABLE
AS 
RETURN (
    select top 2 PAYMENT_ORDER_ID 
    from PAYMENT_BATCH 
    where status = "READY"
)
GO

declare @ids TABLE (ID int)

insert into @ids (id) select * from payments()
while (select count(ID) from @ids ) > 0
begin
    update PAYMENT_BATCH 
        set STATUS = "SUCCESS" 
        where PAYMENT_ORDER_ID in (select ID from @ids)
    
    delete from @ids
    insert into @ids (id) select * from payments()
end    

select count(*) as COUNT from PAYMENT_BATCH where STATUS = "SUCCESS"