#!/bin/bash

 myPID=$$
myNAME=$0

function die() {
    kill -9 $myPID ;
}

function usage() {
    if [ $# -gt 0 ] ; then
        echo ERROR: "$@"
    fi
    echo Usage: $myNAME 'timesheetMichaelODonnell201ymmdd-hh+xxh.xlsx [additionalSubjectLineStuff]'
    die
    exit 1
}

if [ $# -ne 1 ] ; then
    usage Missing filename
fi

f=$1
shift

if ! echo $f | grep -E -q -e '^timesheetMichaelODonnell201[[:digit:]]{5}-[[:digit:]]{2}\+[[:digit:]]{2}.\.xlsx$' ; then
    usage $f '- unexpected filename layout. (?)'
fi

echo Transmitting uuencoded $f to michael.odonnell@ll.mit.edu ...
echo Subject: line will be: "$f $*"

cat <(echo -e "\n\nAttached please find unsigned $f\n\n" $f) <(uuencode $f < $f) | mail -s"$f $*" michael.odonnell@ll.mit.edu

