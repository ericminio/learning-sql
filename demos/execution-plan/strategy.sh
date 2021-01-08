#!/bin/bash

function strategy {
    grep "|--" $1 | cut -d"(" -f1 | cut -d"-" -f3 | tail -1
}
