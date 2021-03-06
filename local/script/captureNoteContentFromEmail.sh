#!/bin/bash

#set -x -v

###############################################################################
#
function exitHandler()  {
    if [ -n "$MIKE_DEBUG" ] ; then
        echo Leaving TEMP files behind for debug: $tempFile $tempDir
    else
        rm -rf $tempFile $tempDir
    fi
}

###############################################################################
#
function tidySpaceFunc()  {
    sed -r  -e 's/[[:space:]]+$//g' \
            -e '${ s/$/\
/ }' | cat -s | sed -r -e '1{ /^$/d }' -e '${ /^$/d }'
}

###############################################################################
#
trap exitHandler EXIT

# Create our tempFile and use it to capture all of stdin before moving on.
#
tempDir=$(mktemp -d /tmp/captureNoteContentD.XXXXXXXX) || { echo FAILED mktemp -d /tmp/captureNoteContentD.XXXXXXXX ; exit 1 ; }
cd $tempDir                                            || { echo FAILED cd $tempDir ; exit 1 ; }
tempFile=$(mktemp   /tmp/captureNoteContentF.XXXXXXXX) || { echo FAILED mktemp    /tmp/captureNoteContentF.XXXXXXXX ; exit 1 ; }

cat > $tempFile

munpack -q -t < $tempFile >/dev/null 2>&1 # From the MH mpack package

x=$(find . -xdev -type f | wc -l)

if [ $x -gt 0 ] ; then
	while read f ; do
		tidySpaceFunc < "${f}"
	done < <(find . -xdev -type f)
else
	sed -e '1,/^$/d' < $tempFile | tidySpaceFunc
fi

