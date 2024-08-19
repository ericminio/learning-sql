#!/bin/bash

clear
docker-compose exec -T postgresql ./support/yop-testing-bash/dist/test.sh ./postgresql/kata
