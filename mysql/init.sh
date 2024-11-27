#!/bin/bash

source ./mysql/utils.sh

waiting mysql wait_for_database

execute_as_root "SET GLOBAL local_infile=1" > $DIR/init.output