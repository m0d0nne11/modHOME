#!/bin/bash
#
# (re)Arrange stdin (assumed to be something like /etc/fstab) such that
# the fields are lined up in columnar format for enhanced readability.
# Only processes the NFS lines.
#

function lineupText()  {
    column -t | sed -e 's/\([^ ]\)  /\1 /g'
}

timeStamp=$$$(date '+%Y%m%d%H%M%S')
 tempFile=/tmp/lineupFSTABtemp$$.$timeStamp

##############################################################################
#
function tidyFSTABfuncNFS()  {

grep -E -v -e '^[[:space:]]*#.*fileSystem.*<type>'    \
           -e '^[[:space:]]*#.*mountPoint.*<options>' \
           -e '^[[:space:]]*#.*\| *\|'      > $tempFile

cat <<EOF
#<fileSystem>             <type>                                              <pass>
# |          <mountPoint>  |          <options>                             <dump>|
# |           |            |           |                                        | |
EOF

fgrep -iv -e nfs < $tempFile
echo
fgrep -i  -e nfs < $tempFile | lineupText | sort -bfd
rm -f              $tempFile
}

##############################################################################

sed -e 's/[[:space:]]+$//' | tidyFSTABfuncNFS | cat -s
