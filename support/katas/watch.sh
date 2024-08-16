#!/bin/bash

./support/yop-testing-bash/dist/.*sh$
fswatch -o ./postgresql/configured_select -e "run.output" | xargs -n1 ./support/yop-testing-bash/dist/.*sh$