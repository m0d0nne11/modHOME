# hashBang line disabled to accommodate Termux's nonstandard filesystem layout...
#!/bin/bash
#!/usr/bin/bash
#!/u/bin/bash
#!/opt/local/bin/bash
#!/n/viewserver/home/merlin/home2/bin/sun4/sos4/bash
#!/bin/sh

#
# labannex - connect to lab systems connected via their console
#            ports to various Annex serial-port concentrators.
#

myName=$0

command=( \
    "xterm -n blue80x60  -bg dodgerblue4  -dc -cm -bdc -ulc -cb -cr yellow -fg white -fn -misc-fixed-medium-r-normal--14-110-100-100-c-70-iso8859-1 -geometry 80x60  -ls -sb -sl 5000" \
    "xterm -n grey80x60  -bg gray30       -dc -cm -bdc -ulc -cb -cr yellow -fg white -fn -misc-fixed-medium-r-normal--14-110-100-100-c-70-iso8859-1 -geometry 80x60  -ls -sb -sl 5000" \
    "xterm -n red80x60   -bg firebrick4   -dc -cm -bdc -ulc -cb -cr yellow -fg white -fn -misc-fixed-medium-r-normal--14-110-100-100-c-70-iso8859-1 -geometry 80x60  -ls -sb -sl 5000" \
    "xterm -n white80x60 -bg navajoWhite3 -dc -cm -bdc -ulc -cb -cr yellow -fg black -fn -misc-fixed-medium-r-normal--14-110-100-100-c-70-iso8859-1 -geometry 80x50  -ls -sb -sl 5000" \
    "xterm -n greyWide   -bg gray30       -dc -cm -bdc -ulc -cb -cr yellow -fg white -fn -misc-fixed-medium-r-normal--14-110-100-100-c-70-iso8859-1 -geometry 160x50 -ls -sb -sl 5000" \
    "xterm -n redWide    -bg firebrick4   -dc -cm -bdc -ulc -cb -cr yellow -fg white -fn -misc-fixed-medium-r-normal--14-110-100-100-c-70-iso8859-1 -geometry 160x50 -ls -sb -sl 5000" \
    "xterm -n whiteWide  -bg navajoWhite3 -dc -cm -bdc -ulc -cb -cr yellow -fg black -fn -misc-fixed-medium-r-normal--14-110-100-100-c-70-iso8859-1 -geometry 160x50 -ls -sb -sl 5000" \
    "xterm -n wideBlue   -bg dodgerblue4  -dc -cm -bdc -ulc -cb -cr yellow -fg white -fn -misc-fixed-medium-r-normal--14-110-100-100-c-70-iso8859-1 -geometry 160x50 -ls -sb -sl 5000" \
)

###############################################################################
function commandForTag()  {
    local indexLimit
    local index
    local string


    if [ $# -ne 1 ]
    then
        echo "Internal error in $FUNCNAME() - need key and value"
        exit 1
    fi

    indexLimit=${#command[*]}
    index=0
    while [ $index -lt $indexLimit ]
    do
        string=( ${command[$index]} )       # Index the database for a command.
        if [ ${string[2]} == $1 ]                  # Find specified window name
        then
            launchDetached ${string[*]}
            return 0
        fi;

        let index++
    done
    return 1
}

###############################################################################
function allCommands()  {
    local indexLimit
    local index

    indexLimit=${#command[*]}
    index=0
    while [ $index -lt $indexLimit ]
    do
        echo ${command[$index]}
        let index++
    done
}

###############################################################################
function usage()  {

    echo "Failed:" $@
    echo ""
    echo "Usage:"
    echo "        $myName windowName"
    echo ""

    echo "where windowName indicates the desired command..."

    allCommands
    exit 1
}

###############################################################################
# True execution actually begins here...
#

if [ $# -eq 1 ]                                       # Number of args correct?
then
    string=( $(commandForTag $1) )
    if [ $? -eq 0 ]                           # Found specified command string?
    then
        echo           ${string[*]}
#       launchDetached "${string[*]}"
        exit 0
    else
        usage "Couldn't find system '$1'"
    fi
else
    usage "exactly one systemName must be specified"
fi

