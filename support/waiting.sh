# See https://github.com/ericminio/learning-bash

function waiting {
    local command=$2;
    local tries=10;
    local ready=0;
    while [ "$ready" -eq "0" ]
    do    
        ready=$(eval "$command")
        if [ "$ready" -eq 0 ]; then 
            tries=$(( tries - 1 ))
            if [ "$tries" -eq "0" ]; then 
                echo "Stopped after 10 seconds";
                exit 1;
            fi
            echo "Waiting for $1"
            sleep 1;
        fi
    done;
    echo "$1 is ready";
}
