#!/bin/bash

source ./postgresql/utils.sh

waiting postgresql wait_for_postgresql
waiting postgres-read wait_for_postgres_read

execute "alter database exploration set client_min_messages to WARNING"