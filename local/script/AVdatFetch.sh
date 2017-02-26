#!/bin/bash

# Fetch latest McAfee AntiVirus signature files etc for Windows/Linux.

###########################################################################
# NOTE: some MacOSX versions of wget are apparently compatible
#       with the Linux version, some aren't...
#
# ASSUME: blindly assume MacOS if not Linux.
#
#       If isLinux not available, uncomment the following:
#if uname -a | fgrep -qi -e linux ; then
 if                       isLinux ; then
     PROGRESS_OPTION="--progress=bar"  # Linux  wget
 else
     PROGRESS_OPTION="--show-progress" # MacOSX wget
 fi

###########################################################################
# Show what's left after tossing everything that's NOT a digit...
#
function digitsInString() { echo "$@" | tr -d -C '[:digit:]' ; }

###########################################################################
#
function FAIL()  { echo FAIL: "$*" ; exit 1 ; }

###########################################################################
# Functions defined, commence execution:

###########################################################################
# From these remote directories...
#

exeSource=http://download.nai.com/products/datfiles/4.x/nai     #Win7
wget -O - "${exeSource}"/ >exeSourceHTML.txt 2>&1

zipSource=http://download.nai.com/products/commonupdater       #Linux
wget -O - "${zipSource}"/ >zipSourceHTML.txt 2>&1

# ...deduce URLS for target files (.exe and .zip) of interest...
#
unset HREF
eval $(fmt -1 < exeSourceHTML.txt | fgrep -i -e 'href=' | fgrep -e           .exe  | sed -e 's/>.*$//' | sort | tail -1)
x=$HREF ; [ "$x" ] || FAIL cannot deduce .exe URL... # .exe URL

unset HREF
eval $(fmt -1 < zipSourceHTML.txt | fgrep -i -e 'href=' |  grep -e 'avvdat.*\.zip' | sed -e 's/>.*$//' | sort | tail -1)
z=$HREF ; [ "$z" ] || FAIL cannot deduce .zip URL... # .zip URL

# Do some fairly weak sanity checks before downloading...
#
# Are these today's images?

dateMonYear=$(date '+%d-%b-%Y') # Same format as used in the HTML
xDateOK=$(fgrep -e "$x" < exeSourceHTML.txt | sed -e 's/^.*HREF=//' | fmt -1 | fgrep -e "${dateMonYear}")
zDateOK=$(fgrep -e "$z" < zipSourceHTML.txt | sed -e 's/^.*HREF=//' | fmt -1 | fgrep -e "${dateMonYear}")

if [ "${xDateOK}" != "${dateMonYear}" -o "${zDateOK}" != "${dateMonYear}" ] ; then
    echo "##########################################################################"
    echo '#### WARNING: available images not both dated today?'
   (fgrep -e "$x" < exeSourceHTML.txt | sed -e 's/^.*HREF=//';
    fgrep -e "$z" < zipSourceHTML.txt | sed -e 's/^.*HREF=//') | column -t
    read -p 'Hit Return to proceed, Ctl-C to abort...   ' rzq
fi

# Are same numerals present in same sequence in both names?
#
if [ "$(digitsInString $x)" != "$(digitsInString $z)" ] ; then
    echo "##########################################################################"
    echo '#### WARNING: numeric portions of available AVdat files different (?!)'
   (fgrep -e "$x" < exeSourceHTML.txt | sed -e 's/^.*HREF=//';
    fgrep -e "$z" < zipSourceHTML.txt | sed -e 's/^.*HREF=//') | column -t
    read -p 'Hit Return to proceed, Ctl-C to abort...   ' rzq
fi

# ...and then finally download most recent images.
#
wget "${PROGRESS_OPTION}" --verbose "${exeSource}"/$x || FAIL $x
wget "${PROGRESS_OPTION}" --verbose "${zipSource}"/$z || FAIL $z

rm -f exeSourceHTML.txt zipSourceHTML.txt

ls -lF $x $z                                          || FAIL $x $z

echo $z $x $(date)
if ! isLinux ; then
    open --reveal .     # Pop a Finder dialog in case we want to burn a DVD.
fi

exit 0

