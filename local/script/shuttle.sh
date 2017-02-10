#!/bin/bash

###############################################################################
# Use rsync to shuttle hierarchies back and forth between systems.
#
# Specify pathnames for root nodes of hierarchies below, between
# the "yourDirectoryListHere" markers, one per line.  Specified
# hierarchies must exist relative to home dir on both hosts.
#

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
function usage() {
    echo ""
    echo USAGE:
    echo "   ${myName}" -[io] [-d]
    echo Syncs specified hierarchies inbound/outbound via
    echo  rsync with other host "(currently '${otherHost}')"
    echo  ""
    echo  WARNING: the -d option accomplishes complete sync by
    echo  permiting ruthless deletion of destination files.
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Complain and die.
#
function FAILED()  {
    local msg

    if [ $# -lt 1 ] ; then
        msg="(unspecified error)"
    else
        msg="${*}"
    fi

    echo "${myName} FAILED: ${msg}" >&2
    usage
    exit 1
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

   myName="${0}"
    myPID=$$
otherHost=otherHostNotYetDefined

unset direction # No default

unset otherUser     # Defaults to current user
#otherUser=MI25714@ # NOTE: if set, otherUser must have trailing @
#otherUser=mi25714@ # NOTE: if set, otherUser must have trailing @

options=""
currentOptArg=""
while getopts "iod" currentOptArg ; do
    case "$currentOptArg" in
    '?')                                                # End of supplied args.
        FAILED unexpected option
        ;;
    i)
        direction="inbound"
        ;;
    o)
        direction="outbound"
        ;;
    d)
        options="${options} --delete" # Permit ruthless deletion of dest files.
        ;;
    *)
        failed "Unexpected commandline parameter: $currentOptArg"
        ;;
    esac
done

  #  #  #  #  #  #  #  #

[ "${direction}" ] || FAILED must specify -o or -i

[ "${otherHost}" ] || FAILED other host not specified

cd ~               || FAILED "Cannot cd ~ ?"

  #  #  #  #  #  #  #  #

while read dir ; do
    [ -d "${dir}"/. ] || FAILED "${dir}" "...not a Directory?"
    if ! [ "${dir}" ] ; then
        echo '  #### SKIPPING null entry - blank line between yourDirectoryListHere tags?'
        continue
    fi
    echo "  #### BEGIN $direction ${otherUser}${otherHost}":"'${dir}'"/.

    if [ "$direction" = "outbound" ] ; then
        rsync -vax ${options} "${dir}"/. ${otherUser}"${otherHost}":"'${dir}'"/.
    else
        rsync -vax ${options}            ${otherUser}"${otherHost}":"'${dir}'"/. "${dir}"/.
    fi
    echo "  ##### DONE $direction ${otherUser}${otherHost}":"'${dir}'"/.

done <<"yourDirectoryListHere"
Desktop/exampleShuttleDirectory
yourDirectoryListHere

# Specify (in the list above) root nodes of hierarchies to transfer,
# one per line, between the "yourDirectoryListHere" lines.  Assumed
# to be relative to home directory; absolute paths may also work...
#
