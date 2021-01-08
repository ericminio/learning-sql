#!/bin/bash

source ./support/execute.sh

function test_lead {
    execute ./demo/lead/create-table-product.sql
    execute ./demo/lead/insert-products.sql
    execute ./demo/lead/lead.sql > ./demo/lead/output
    actual=`grep Love ./demo/lead/output | grep -o '.$'`

    assertequals "$actual" "2"
}
