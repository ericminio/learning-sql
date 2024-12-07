#!/bin/bash

source ./postgresql/utils.sh

waiting postgresql wait_for_postgresql

execute "alter database exploration set client_min_messages to WARNING"