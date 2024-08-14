#!/bin/bash

./support/katas/run.sh
fswatch -o ./postgresql/kata -e "run.output" | xargs -n1 ./support/katas/run.sh