#!/bin/bash
#
# (re)Arrange stdin (assumed to be something like /etc/exports) such that
# the fields are lined up in columnar format for enhanced readability.
#

function lineupText()  {
    column -t | sed -e 's/\([^ ]\)  /\1 /g'
}

lineupText | sort -bfd | cat -s
