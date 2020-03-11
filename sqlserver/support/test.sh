#!/bin/bash

files=$1/*.sh
for f in $files; do source $f; done

function assertequals {
    if [ "$1" = "$2" ]; then
        return 0
    else
        FAILED_EXPECTATION="FAILURE\n\nExpected: $2 \nBut was : $1"
        return 1
    fi
}

function all {
    cat $files | grep test_
}
function only {
    grep test_only
}
function count {
    wc -l
}
function names {
    cut -d" " -f2
}
function run_test {
    echo $1
    $1
    if (( $? != 0 )); then
        echo -e "$FAILED_EXPECTATION"
        exit 1
    fi
}

test=`all`
if (( `echo "$test" | only | count` > 0 )); then
    test=`echo "$test" | only`
fi

for name in `echo "$test" | names`; do
    run_test $name
done
echo "SUCCESS"
