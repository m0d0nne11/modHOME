#!/bin/bash
#
# One contributing factor in the perpetration/perpetuation of fstab
# file errors is the jumbled way these files are often maintained.
# Looking at even just a single NFS entry by itself can be enough to give
# you a headache, but when there's a dozen such entries tangled together
# there's little chance that typos and other errors will be noticeable.
#
# This script is a std/stdout pipe that expects its input to be the
# contents of an /etc/fstab file and it will attempt to tidy it up by
# segregating the non-NFS entries from the NFS entries and then lining
# up the fields such that certain kinds of errors are more apparent.
#
# Typical usage:
#   cp  /etc/fstab /etc/fstab.b4tidy
#   tidyFSTAB.sh < /etc/fstab.b4tidy > /etc/fstab
#

function lineupText()  {
    column -t | sed -e 's/\([^ ]\)  /\1 /g'
}

timeStamp=$$`date '+%Y%m%d%H%M%S'`
 tempFile=/tmp/lineupFSTABtemp$$.$timeStamp

##############################################################################
# This version tries to tidy the non-NFS lines, as well...
#
function tidyFSTABfunc()  {

  sed        -e 's/[[:space:]]+$//'                    | \
  grep -E -v -e  '^[[:space:]]*#.*fileSystem.*<type>'    \
             -e  '^[[:space:]]*#.*mountPoint.*<options>' \
             -e  '^[[:space:]]*#.*\| *\|'      > $tempFile

cat <<EOF
#<fileSystem>             <type>                                              <pass>
# |          <mountPoint>  |          <options>                             <dump>|
# |           |            |           |                                        | |
EOF

 grep -E -v -e '^[[:space:]]*#' < $tempFile | fgrep -iv -e nfs | lineupText
 echo
 grep -E    -e '^[[:space:]]*#' < $tempFile | fgrep -iv -e nfs | lineupText
 echo

# Use --field-separator to sort by remote directory instead of local mountpoint.
# fgrep < $tempFile -i -e nfs | lineupText | sort -bfd --field-separator=: --key=2
  fgrep < $tempFile -i -e nfs | lineupText | sort -bfd                     --key=2

  rm -f   $tempFile
}

##############################################################################

tidyFSTABfunc | cat -s
