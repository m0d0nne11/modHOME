#!/bin/bash
# Version=20100401 MD5=2a7ffa4f7b1976752c9188869898867f
#
# Copyright (c)2009 WSI Corp. 20090417
#
# Compare two files (File1 and File2, assumed to be zone info descriptions)
# and generate resultFile which will be File1 without any of the zones that
# are mentioned in File2, ie. it will only have zones unique to File1.
# NOTE: We have seen that zone files sometimes contain "clone-zones" -
#       that is, multiple definitions of exactly the same zone.
#       This script does nothing about that...
#
#####################################################################modonnell#

test -n "$MIKE_DEBUG" && set -x

myName=$(basename $0)

###############################################################################
#
function exitHandler()  {
    if [ -n "$MIKE_DEBUG" ] ; then
        echo Leaving TEMP files behind for debug: $tempFile1 $tempFile2
    else
        rm -f $tempFile1 $tempFile2
    fi
}

trap exitHandler EXIT

###############################################################################
#
function FAIL()  {
    echo $myName FAILED: $@
    echo "Usage:"
    echo "      $myName File1 File2 resultFile"
    echo "      resultFile will be zones from File1 that are not present in File2"
    echo "      File1 and File2 will not be modified."
    echo "Example:"
    echo "      $myName someFireFile someWeatherFile newFireFile"
    exit 1
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Functions defined - commence execution...
#
if [ $# -ne 3 ] ; then
    FAIL wrong number of commandline parameters
fi

launch="$(date)"
file1=$1
file2=$2
file3=$3

test -e $file3                            && FAIL File $file3 already exists
test -r $file1                            || FAIL File $file1 unreadable
test -r $file2                            || FAIL File $file2 unreadable
tempFile1=$(mktemp /tmp/zoneName.XXXXXXXX) || FAIL mktemp1 /tmp/zoneName.XXXXXXXX
tempFile2=$(mktemp /tmp/zoneName.XXXXXXXX) || FAIL mktemp2 /tmp/zoneName.XXXXXXXX

# Assemble a list of strings identifying the unique zones.
# Don't be fooled by duplicate zones in file1.
#
zT=0 # zonesTotal
zU=0 # zonesUnique

echo "############## Collecting zone tags unique to $file1..."
while read tag ; do
    let zT++
    if ! fgrep -q -e "${tag}" $file2 ; then
        let zU++
        echo "${tag}"
        echo "${tag}" >> $tempFile1                  # Accumulate target lines.
    fi
done < <(grep -e '"' $file1 | sort -bfd | uniq)      # Duplicates filtered out.

set -e                                                  # Now errors are fatal.

# Convert zone tags into sed commands that capture the region
# from the specified zone tag to the END directive.
# ASSUME: no characters in the zone tags qualify as regular expression
#         metacharacters except the slashes, which we escape here.
#
echo "############## Converting zone tags to sed expressions..."
sed -e 's/\//\\\//g' -e 's/^/\/^/' -e 's/$/$\/,\/^END$\/p/' < $tempFile1 > $tempFile2
sort -bfd --key=2 < $tempFile2 > $tempFile1

# Turn sed loose on the zone file, controlled by the script file $tempFile1
# NOTE: If this ever fails because there are too many expressions in
#       the sed script file, that script file can be split into smaller
#       pieces and then each one fed to sed with the results concatenated.
#
echo "############## Generating $file3 from $file1 using sed (be patient)..."
sed -n -f $tempFile1 < $file1 > $file3

echo "LAUNCH -> FINISH:  $launch -> $(date)"
echo "RESULTS: ${file3} is ${file1} with $zU unique zones out of $zT"
ls -laCFl $file1 $file2 $file3

