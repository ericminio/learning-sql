SET enable_seqscan = off;
SET enable_bitmapscan = off;

EXPLAIN select AREA, LABEL, count(ID) from PRODUCT where CREATION > '2020-01-01' GROUP BY AREA, LABEL;

SET enable_bitmapscan = on;
SET enable_seqscan = on;
