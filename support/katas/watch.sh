#!/bin/bash

./support/katas/run.sh
fswatch -o ./postgresql/configured_select -e "run.output" | xargs -n1 ./support/katas/run.sh