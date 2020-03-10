#!/bin/bash

function assertequals {
    if [ "$1" = "$2" ]; then
        return 0
    else
        FAILED_EXPECTATION="FAILURE\n\nExpected: $2 \nBut was : $1"
        return 1
    fi
}