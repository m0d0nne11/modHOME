#!/bin/bash

# Lookup vendor IDs for MACaddrs in stdin or on cmdline.
#
# m0d0nne11 20161214
# Developed on MacOSX 10.11 - may need tweaks for Linux and such.
#
# Regex for MAC addrs involves (nested) repetition controls:
#   ([[:xdigit:]]{2}:){5}[[:xdigit:]]{2}

myName=$0
 myPID=$$

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# If we find any strings in the commandline args that look to be MAC
# addrs we ask for a lookup, optionally (as controlled by [shudder!]
# global variables) echoing back the entire line we were handed prior
# to reporting the results and optionally uttering some additional
# glop that may possibly be useful in further parsing the output...
#
function MACvendorFor()  {
    local m

    if [ "$repeat" ] ; then
        echo -n "$@" ;
    fi ;

    if ! echo "$@" | grep -E -q -e '([[:xdigit:]]{2}:){5}[[:xdigit:]]{2}' ;
    then
        echo "" ;
        return ;
    fi ;

    for m in $( echo "$@" | sed -E -e 's/(([[:xdigit:]]{2}:){5}[[:xdigit:]]{2})/ RZQmac=\1 /g' \
                          | fmt -1 | grep -e 'RZQmac=' | sed -e 's/RZQmac=//' ) ;
    do
        if [ "$verbose" ] ; then
            echo -n " MACvendor($m)=$(curl http://api.macvendors.com/$m 2>/dev/null | tr ' ' _ )" ;
        else
            echo -n               " $(curl http://api.macvendors.com/$m 2>/dev/null | tr ' ' _ )" ;
        fi ;
    done ;

    echo "" ;

    return ;
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
function usage() {
    cat << EOF
$myName
    -v Verbose
    -r Repeat input
    -m MAC(s) specified instead of from stdin
EOF
    kill -9 $myPID
}


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
unset OPTARG
unset repeat
unset specified
unset verbose

currentOptArg=""
while : ; do
    getopts "hvm:r" currentOptArg

    case "$currentOptArg" in
    'h')                                                # End of supplied args.
        usage
        ;;
    '?')                                                # End of supplied args.
        break
        ;;
    r)
        repeat=setFromCmdLine
        ;;
    m)
        specified="${specified} $OPTARG"
        verbose=impliedSpecified
        unset repeat
        ;;
    v)
        verbose=setFromCmdLine
        ;;
    *)
        failed "Unexpected commandline parameter: $currentOptArg"
        ;;
    esac
done

if [ "$specified" ] ; then
    MACvendorFor "${specified}" ;
else # stdin
    (while read l ;
    do
        MACvendorFor "${l}" ;
    done < <(sed -e 's/^/X /') ) | sed -e 's/^X //' -e 's/^X$//'
    # XXX_MIKE: Inserting and then removing the leading 'X '
    #           guarantees that no lines start with whitespace
    #           which seems to keep bash from collapsing the
    #           whitespace when echoing the whole line...  (?)
    #
fi ;

exit ;

