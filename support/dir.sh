#!/bin/bash

function current_dir {
    echo $( cd "$( dirname "$1" )" >/dev/null 2>&1 && pwd )    
}