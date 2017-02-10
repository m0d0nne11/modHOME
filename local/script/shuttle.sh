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
    echo USAGE:
    echo "   ${myName}" -[io] [-d]
    echo Syncs specified hierarchies inbound/outbound with
    echo  other host "(currently '${otherHost}')"
    echo  WARNING: the -d option permits ruthless deletion
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
otherHost=vmobuntu1404

unset ruthlessDelete
unset otherUser
unset direction # No default
otherUser=MI25714@ # NOTE: must have trailing @

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
        ruthlessDelete="--delete"
        ;;
    *)
        failed "Unexpected commandline parameter: $currentOptArg"
        ;;
    esac
done

  #  #  #  #  #  #  #  #

[ "${direction}" ] || FAILED must specify -o or -i

[ "${otherHost}" ] || FAILED - other host not specified in script

cd ~               || FAILED "Cannot cd ~ ?"

  #  #  #  #  #  #  #  #

while read dir ; do
    [ -d "${dir}"/. ] || FAILED "${dir}" "...not a Directory?"
    if ! [ "${dir}" ] ; then
        echo '  #### SKIPPING null entry - maybe blank line in list?'
        continue
    fi
    echo "  #### BEGIN $direction ${otherUser}${otherHost}":"${dir}"/.

    if [ "$direction" = "outbound" ] ; then
        rsync -vax ${ruthlessDelete} "${dir}"/. ${otherUser}"${otherHost}":"${dir}"/.
    else
        rsync -vax ${ruthlessDelete}            ${otherUser}"${otherHost}":"${dir}"/. "${dir}"/.
    fi
    echo "  ##### DONE $direction ${otherUser}${otherHost}":"${dir}"/.

done <<"yourDirectoryListHere"
Desktop/exampleShuttleDirectory
yourDirectoryListHere

# Specify root nodes of hierarchies to transfer in the list above,
# one per line, between the yourDirectoryListHere lines.

