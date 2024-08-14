#!/bin/bash

clear
docker-compose exec -T postgresql ./support/test.sh ./postgresql/configured_select
