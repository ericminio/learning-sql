USE exploration
GO
SET NOCOUNT ON
GO
	
DROP TABLE IF EXISTS PAYMENT_ORDER
DROP TABLE IF EXISTS PAYMENT_BATCH
CREATE TABLE PAYMENT_ORDER (
    ID int,
    PAID bit
)
CREATE TABLE PAYMENT_BATCH (
    SESSION int,
    PAYMENT_ORDER_ID int,
    STATUS varchar(10)
)
GO
insert into PAYMENT_ORDER (ID, PAID) values (1, 0)
insert into PAYMENT_ORDER (ID, PAID) values (2, 1)
insert into PAYMENT_ORDER (ID, PAID) values (3, 0)
insert into PAYMENT_BATCH (SESSION, PAYMENT_ORDER_ID, STATUS) values (1, 2, "SUCCESS")
GO

insert into PAYMENT_BATCH (SESSION, PAYMENT_ORDER_ID, STATUS)
    select  2, ID, "READY" 
    from    PAYMENT_ORDER
    where   PAID = 0

select * from PAYMENT_BATCH