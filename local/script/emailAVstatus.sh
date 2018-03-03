# hashBang line disabled to accommodate Termux's nonstandard filesystem layout...
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
    echo Usage: $myNAME "<AVdat number>"
    die
}

if [ $# -ne 1 ] ; then
    usage Missing filename
fi

if ! echo $1 | grep -E -q -e '^timesheetMichaelODonnell201[[:digit:]]{5}-[[:digit:]]{2}\+[[:digit:]]{2}.\.xlsx$' ; then
    usage $1 '- unexpected filename layout. (?)'
fi

#echo Transmitting uuencoded $1 to michael.odonnell@ll.mit.edu ...

#cat <(echo -e "\n\nAttached please find unsigned $1\n\n" $1) <(uuencode $1 < $1) | mail -s"$1" michael.odonnell@ll.mit.edu

