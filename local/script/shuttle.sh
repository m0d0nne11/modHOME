#!/bin/bash

###############################################################################
# Script using rsync to shuttle hierarchies back and forth between systems.

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# BEGIN CONFIGURABLES:

otherHost=otherHostNotYetDefined

unset otherUser     # Defaults to current user when undefined/unset
#otherUser=mi25714@ # NOTE: if defined/set, otherUser *MUST* have trailing @

# Modify utterDirList() here to specify pathnames for root directories
# (not individual files) of any hierarchies to be recursively rsync'd.
# Those pathnames:
#  - must appear 1 per line between the "DIR_LIST_BOUNDARY" lines.
#  - are assumed to be pathnames relative to the home directory;
#    absolute paths may also work but have not been exercised...

function utterDirList() {
    cat <<"DIR_LIST_BOUNDARY"
relativePaths/to/your/directory/here
DIR_LIST_BOUNDARY
}

# Modify utterFileList() here to specify pathnames for individual
# files to be rsync'd.  Those pathnames:
#  - must appear 1 per line between the "FILE_LIST_BOUNDARY" lines.
#  - are assumed to be pathnames relative to the home directory;
#    absolute paths may also work but have not been exercised...

function utterFileList() {
    cat <<"FILE_LIST_BOUNDARY"
relativePaths/to/your/file/here
FILE_LIST_BOUNDARY
}

# END CONFIGURABLES
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
function usage() {
    echo ""
    echo USAGE:
    echo "   ${scriptName}" -[io] [-d] [-F]
    echo Syncs the specified hierarchies inbound/outbound via
    echo rsync with other host "(currently '${otherHost}')"
    echo "One of -i or -o must be present"
    echo "-d optionally specifies '--delete'"
    echo "-F optionally specifies '--dry-run' (i.e. Fake)"
    echo ""
    echo WARNING: the -d option accomplishes complete sync by
    echo permitting ruthless deletion of destination files...
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

    echo "${scriptName} FAILED: ${msg}" >&2
    usage
    exit 1
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

scriptName="${0}"
 scriptPID=$$

unset direction # No default

      rOptions=""
currentOptArg=""

while getopts "iodF" currentOptArg ; do
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
        rOptions="${rOptions} --delete" # Permit ruthless deletion of dest files.
        ;;
    F)
        rOptions="${rOptions} --dry-run" # Fake it.
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

# The main loops - entire hierarchies first, then single files...

utterDirList | while read dir ; do
    if ! [ "${dir}" ] ; then
        echo '  #### SKIPPING null entry - blank line between DIR_LIST_BOUNDARY tags?'
        continue
    fi
    if ! [ -d "${dir}"/. ] ; then
        echo SKIPPING "${dir} - not a Directory?"
        continue
    fi
    echo "  #### BEGIN $direction ${rOptions} ${otherUser}${otherHost}":"'${dir}'"/.

    if [ "$direction" = "outbound" ] ; then
        rsync -vax ${rOptions} "${dir}"/. ${otherUser}"${otherHost}":"'${dir}'"/.
    else
        rsync -vax ${rOptions}            ${otherUser}"${otherHost}":"'${dir}'"/. "${dir}"/.
    fi
    echo "  ##### DONE $direction ${rOptions} ${otherUser}${otherHost}":"'${dir}'"/.
done

utterFileList | while read f ; do
    if ! [ "${f}" ] ; then
        echo '  #### SKIPPING null entry - blank line between FILE_LIST_BOUNDARY tags?'
        continue
    fi
    if ! [ -f "${f}" ] ; then
        echo SKIPPING "${f} - not a File?"
        continue
    fi
    echo "  #### BEGIN $direction ${rOptions} ${otherUser}${otherHost}":"'${f}'"

    if [ "$direction" = "outbound" ] ; then
        rsync -vax ${rOptions} "${f}" ${otherUser}"${otherHost}":"'${f}'"
    else
        rsync -vax ${rOptions}        ${otherUser}"${otherHost}":"'${f}'" "${f}"
    fi
    echo "  ##### DONE $direction ${rOptions} ${otherUser}${otherHost}":"'${f}'"
done

