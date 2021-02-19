#!/bin/bash

function updated_record_is_moved_in_first_page_with_enough_room {
    DIR=$(current_dir ${BASH_SOURCE[0]})
    
    executeFile ${DIR}/explore.sql > ${DIR}/explore.output
}
