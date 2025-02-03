#!/bin/bash

# ASSUME: my lineup script is available.  If not,
# as simplified version would be something like:
# function lineupColumns()  { column -t | sed -e 's/\([^ ]\)  /\1 /g' ; }
#
function tokenizeLine() {
    local X ;
    if [ $# -lt 1 ] ; then
        X='_'  ;
    else
        X="$1" ;
    fi ;

    tr        '\t' '\n'               | \
    sed -E -e 's/^[[:space:]]*//'       \
           -e  's/[[:space:]]*$//'      \
           -e 's/^$/-/'                 \
           -e 's/[[:space:]]+/'$1'/g' | \
    fmt -2400 ;
}

function tokenizeLines() {
    while read l ; do
        echo "${l}" | tokenizeLine '_' ;
    done ;
}

tokenizeLines | lineup

