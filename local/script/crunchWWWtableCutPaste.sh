#!/bin/bash

function tokenizeLine() {
    local X ;
    if [ $# -lt 1 ] ; then
        X='_'  ;
    else
        X="$1" ;
    fi ;

    tr '\t' '\n'                      | \
    sed -r -e 's/^[[:space:]]*//'       \
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

