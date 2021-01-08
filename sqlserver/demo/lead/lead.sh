#!/bin/bash

source ./support/execute.sh

function test_lead {
    execute ./demo/lead/create-table-product.sql
    execute ./demo/lead/insert-products.sql
    execute "select FIELD, LEAD(CREATION, 2, NULL) over (order by CREATION) from PRODUCT" > ./demo/lead/lead.output
    actual=`grep Love ./demo/lead/lead.output | grep -o '.$'`

    assertequals "$actual" "3"
}
