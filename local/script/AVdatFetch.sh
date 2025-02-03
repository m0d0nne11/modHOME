#!/bin/bash
#
# Fetch latest McAfee AntiVirus signature downloads for Windows/Linux.

# We'll use z, x and v to refer to the .zip (Linux) download and
# the 2 .EXE flavors, respectively.

# Script's default mode reflects its original intent - to be used
# in a one-off manner in which it prompts if it encounters any
# unexpected conditions, allowing user to decide whether to proceed.
#
# The FAIL_WITH_STATUS hack was introduced to change that default
# behavior causing it to instead exit immediately, allowing the
# script to then be used in a simple shell loop something like this:
#
#   while ! FAIL_WITH_STATUS=setInCommandLine ./AVdatFetch.sh ;
#     do (echo SLEEP 257 $(date) ) ; sleep 257 ; done
#
# ...which (in this example) will cause it to loop, retrying every
# 257 seconds until all offered versions are marked as being today's,
# at which point they'll be downloaded.
#
# We now also finish by showing some example commands for
# creating the ISO, burning it (at least on Mike's MacOS
# workstation), distributing some items via the Data Diode,
# and emailing a version string as a reminder.

# 20180717 - converted to curl as wget isn't available in default MacOS.
# 20190325 - added support for grabbing McAfee's Version3 .exe files.
# 20190927 - removed dependencies on my personalized environment
#
# NOTE: possible additional/alternate sources for signature files:
#
# http://download.nai.com/products/datfiles/V3DAT/
# http://download.nai.com/products/datfiles/V3DAT/V3_3680dat.exe
# http://download.nai.com/products/licensed/superdat/english/intel/
# http://download.nai.com/products/licensed/superdat/english/intel/9229xdat.exe
#

 [ "$XXX_MIKE_DEBUG" ] && set -x
myName=$0
 myPID=$$


###########################################################################
# Developed on MacOS but has also been lightly tested on Linux.
#
function isLinux()  { uname -a | grep -qi -e linux ; }

###########################################################################
# Some extremely precious child decided to clutter the output of
# the MacOSX md5 utility with lots of gratuitous crap that makes
# it difficult to use in further parsing/processing steps.  In
# particular, the presence of parentheses, equals signs and "MD5"
# qualify as noise, while positioning the filenames (with their
# highly variable layouts/formats) early in the string (ahead of
# invariant stuff like the MD5 hash itself) unnecessarily increases
# the complexity of the parsing task.  Here we attempt to rewrite
# the output layout to match that of the Gnu/Linux md5sum tool...
#
# The intent is to convert stuff like this:
#    MD5 (/my Annoyingly/formatted( file % name)/don't forget this part!)  d41d8cd98f00b204e9800998ecf8427e
# ...into this:
#    d41d8cd98f00b204e9800998ecf8427e /my Annoyingly/formatted( file % name)/don't forget this part!
#

function md5sumSane() {
    if uname -a | grep -qi -e linux ; then
#       echo "WARNING: $FUNCNAME intended to run against the MacOSX md5"
#       echo "         program but you appear to be in a Linux system,"
#       echo "         so just using md5sum..."
        md5sum $@
    else                  # Reformat output from dainbramaged MacOS version
        md5   "$@" | sed -e 's/^MD5 (\(..*\)) = \(..*$\)/\2 \1/'
    fi
}

###########################################################################
# Utter current date in YYYYMMDD format
#
function ymd() { date '+%Y%m%d' ; }

###########################################################################
# Show what's left after tossing everything that's NOT a digit...
#
function digitsInString() { echo "$@" | tr -d -C '[:digit:]' ; }

###########################################################################
#
function FAIL()  {
    echo FAIL: "$*" ;
    if [ "$XXX_MIKE_DEBUG" ] ; then
        echo KEEPING  ${v3exeSourceBaseHTML} \
                        ${exeSourceBaseHTML} ${zipSourceBaseHTML} ;
    else
                rm -f ${v3exeSourceBaseHTML} \
                        ${exeSourceBaseHTML} ${zipSourceBaseHTML} ;
    fi ;
    exit 1 ;
}

###########################################################################
#
function sortedHREFlinesFrom()  { fmt -1 < "$1"     | fgrep -i -e 'href=' \
                                | sed -e 's/>.*$//' | sort -bfd ; }

###########################################################################
###########################################################################
# Functions defined, commence execution...

#FAIL_WITH_STATUS=setInScript # Can be forced here for testing

 [ "$XXX_MIKE_DEBUG" ] && echo FAIL_WITH_STATUS:$FAIL_WITH_STATUS

 [ "$FAIL_WITH_STATUS" ] || cat << "EOF"
You may want to consider this alternate usage example...
 ########
while ! FAIL_WITH_STATUS=setInCommandLine ./AVdatFetch.sh ; do (echo SLEEP 257 $(date) ) ; sleep 257 ; done
 ########

EOF

if ! [ $(basename $PWD) = "AVdat" ] ; then
    FAIL Please move this script into a subdirectory named AVdat\
         and execute from there...
fi ;

ls -laCFl
rm -f     [0-9]*dat.exe avvdat*.zip v3_*.exe

###########################################################################
# Obtain listings of these remote McAfee directories...
#
export exeSourceBaseHTML=/tmp/exeSourceBaseHTML.txt
export  exeSourceBaseURL=http://download.nai.com/products/datfiles/4.x/nai #Win7
curl "${exeSourceBaseURL}"/   > ${exeSourceBaseHTML}   2>&1

export zipSourceBaseHTML=/tmp/zipSourceBaseHTML.txt
export  zipSourceBaseURL=http://download.nai.com/products/commonupdater    #Linux
curl "${zipSourceBaseURL}"/   > ${zipSourceBaseHTML}   2>&1

export v3exeSourceBaseHTML=/tmp/v3exeSourceBaseHTML.txt
export  v3exeSourceBaseURL=http://download.nai.com/products/datfiles/V3DAT #Win10
curl "${v3exeSourceBaseURL}"/ > ${v3exeSourceBaseHTML} 2>&1

# ...then deduce URLS for target files (.exe and .zip) of interest...
#
unset HREF
eval $(sortedHREFlinesFrom ${exeSourceBaseHTML}   | fgrep -e .exe            | tail -1)
x=$HREF ; [ "$x" ] || FAIL cannot deduce .exe URL... # .exe URL

unset HREF
eval $(sortedHREFlinesFrom ${zipSourceBaseHTML}   |  grep -e 'avvdat.*\.zip' | tail -1)
z=$HREF ; [ "$z" ] || FAIL cannot deduce .zip URL... # .zip URL

unset HREF
eval $(sortedHREFlinesFrom ${v3exeSourceBaseHTML} |  grep -e 'v3_.*\.exe'    | tail -1)
v=$HREF ; [ "$v" ] || FAIL cannot deduce v3exe URL... # v3exe URL

# Perform some fairly lame sanity checks prior to downloading...
#
# Are these today's images?  See if timestamp string in vendor's
# HTML matches today's date rendered in their same format.
#
dateMonYear=$(date '+%d-%b-%Y')         # Different format from our ymd()

xDate=$(fgrep -e "$x" < ${exeSourceBaseHTML}   | sed -e 's/^.*HREF=//' | fmt -1 | fgrep -e "${dateMonYear}")
zDate=$(fgrep -e "$z" < ${zipSourceBaseHTML}   | sed -e 's/^.*HREF=//' | fmt -1 | fgrep -e "${dateMonYear}")
vDate=$(fgrep -e "$v" < ${v3exeSourceBaseHTML} | sed -e 's/^.*HREF=//' | fmt -1 | fgrep -e "${dateMonYear}")

if [    "${xDate}" != "${dateMonYear}" \
     -o "${zDate}" != "${dateMonYear}" \
     -o "${vDate}" != "${dateMonYear}" ] ;
then
    echo "##########################################################################"
    echo '#### WARNING: available images not all dated today?'
   (fgrep -e "$x" < ${exeSourceBaseHTML}   | sed -e 's/^.*HREF=//';
    fgrep -e "$z" < ${zipSourceBaseHTML}   | sed -e 's/^.*HREF=//';
    fgrep -e "$v" < ${v3exeSourceBaseHTML} | sed -e 's/^.*HREF=//') | column -t
    [ "$FAIL_WITH_STATUS" ] && FAIL _WITH_STATUS rather than wait for input.
    read -p 'Hit Return to proceed, Ctl-C to abort...   ' rzq
fi

# Are same numerals present in same sequence in the x and z filenames?
# (this test N/A for the v file as its digit sequence apparently unrelated)
#
if [ "$(digitsInString $x)" != "$(digitsInString $z)" ] ; then
    echo "##########################################################################"
    echo '#### WARNING: numeric portions of available AVdat files different (?!)'
   (fgrep -e "$x" < ${exeSourceBaseHTML} | sed -e 's/^.*HREF=//';
    fgrep -e "$z" < ${zipSourceBaseHTML} | sed -e 's/^.*HREF=//') | column -t
    [ "$FAIL_WITH_STATUS" ] && FAIL _WITH_STATUS rather than wait for input.
    read -p 'Hit Return to proceed, Ctl-C to abort...   ' rzq
fi

# ...and then finally download most recent images.
#
curl -O --verbose   "${exeSourceBaseURL}"/$x || FAIL $x
curl -O --verbose   "${zipSourceBaseURL}"/$z || FAIL $z
curl -O --verbose "${v3exeSourceBaseURL}"/$v || FAIL $v

rm -f ${exeSourceBaseHTML} ${zipSourceBaseHTML} ${vexeSourceBaseHTML}

ls -lF     $x $z $v || FAIL ls $x $z $v
echo       $x $z $v $(date)
md5sumSane $x $z $v > MD5sums.txt

vDigits=$( digitsInString "$(echo $v | sed -e 's/v3_//')" )

ISOname=AVdat."$(digitsInString $x)".${vDigits}.$(ymd)
echo "####" RECOMMEND ISO BE LABELLED: "${ISOname}".iso

cd ..
[ ! -d AVdat ] && read -p 'Not in AVdat parent dir ? (Ctl-C please...)' x ;

cat <<EOF
# FURTHER PROCESSING OF "${ISOname}" MIGHT (on MacOS) INCLUDE:
                ISOname="${ISOname}"               ; \\
cd $PWD      ; \\
zip -o -r               "\${ISOname}".zip AVdat                   ; \\
scp                     "\${ISOname}".zip mod@llcad-e7dev:.       ; \\
ssh mod@aehf-bridge /usr/local/fecftp/send-aehf "\${ISOname}".zip ; \\
echo Downloaded components for "\${ISOname}".iso |\
  mail -s"\${ISOname}" michael.odonnell@ll.mit.edu,lbressler@ll.mit.edu ; \\
hdiutil makehybrid                                                 \\
   -default-volume-name "\${ISOname}"                               \\
   -iso                                                            \\
   -iso-volume-name     "\${ISOname}"                               \\
   -joliet                                                         \\
   -joliet-volume-name  "\${ISOname}"                               \\
   -udf                                                            \\
   -udf-volume-name     "\${ISOname}"                               \\
   -o                   "\${ISOname}".iso AVdat                   ; \\
macDVDburnAddonics.sh   "\${ISOname}".iso                         ; \\
tar cvzf                "\${ISOname}".tar AVdat                   ; \\
scp                     "\${ISOname}".tar mod@llcad-e7dev:.

EOF

exit 0


 #    #    ##    #    #
 #    #   #  #    #  #
 ######  #    #    ##
 #    #  ######    ## ...work in progress (grafted on from
 #    #  #    #   #  # another script) not yet implemented.
 #    #  #    #  #    #


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
function usage() {
    cat << EOF
$myName
    -l Loop until today's images all available
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
    v)
        verbose=setFromCmdLine
        ;;
    *)
        FAIL Unexpected commandline parameter: $currentOptArg
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



  ####   #       #####   ######  #####
 #    #  #       #    #  #       #    #
 #    #  #       #    #  #####   #    #
 #    #  #       #    #  #       #####
 #    #  #       #    #  #       #   #
  ####   ######  #####   ######  #    #

#!/bin/bash

# Pull some current AVdat files from McAFee to a local staging area.
# ASSUME: McAfee page contains valid URLs for latest versions.

# Establish (what we hope are) useful proxy-related envars if not already in place.
 export             PROXY="${PROXY:-http://llproxy.llan.ll.mit.edu:8080}"
 export             proxy="${proxy:-${PROXY}}"
 export   HTTP_PROXY="${HTTP_PROXY:-${PROXY}}"
 export   http_proxy="${http_proxy:-${PROXY}}"
 export HTTPS_PROXY="${HTTPS_PROXY:-${PROXY}}"
 export https_proxy="${https_proxy:-${PROXY}}"

        STAGING_DIR=/tmp/DeleteMe.AVdatSTAGING.$$ ;

###########################################################################
#
function currentAVdatDownloadURLs()  {
curl 2>/dev/null 'https://www.mcafee.com/enterprise/en-us/downloads/security-updates.html'                    \
       | grep -e 'https://download.nai.com/products/datfiles/4.x/NAI/mediumepo[[:digit:]][[:digit:]]*dat.zip' \
              -e 'https://download.nai.com/products/datfiles/V3DAT/epoV3_[[:digit:]][[:digit:]]*.0dat.zip'    \
       | tr -s '"\t ' '\n'                                                                                    \
       | fgrep -e 'products/datfiles' ;
}

###########################################################################

mkdir -p "${STAGING_DIR}" || { echo "#### $0 Can't" mkdir ${STAGING_DIR} ; exit 1 ; } ;
cd       "${STAGING_DIR}" || { echo "#### $0 Can't"    cd ${STAGING_DIR} ; exit 1 ; } ;

#for f in $(currentAVdatDownloadURLs ) ; do wget --no-check-certificate "${f}" ; done ;
 for f in $(currentAVdatDownloadURLs ) ; do wget                        "${f}" ; done ;

echo "#### RESULTS:" ; ls -laCF1 ${STAGING_DIR}/* ;

exit ;

  ####   #       #####   ######  #####
 #    #  #       #    #  #       #    #
 #    #  #       #    #  #####   #    #
 #    #  #       #    #  #       #####
 #    #  #       #    #  #       #   #
  ####   ######  #####   ######  #    #


 #    #  ######  #####    ####      #     ####   #    #
 #    #  #       #    #  #          #    #    #  ##   #
 #    #  #####   #    #   ####      #    #    #  # #  #
 #    #  #       #####        #     #    #    #  #  # #
  #  #   #       #   #   #    #     #    #    #  #   ##
   ##    ######  #    #   ####      #     ####   #    #


# hashBang line disabled to accommodate Termux's nonstandard filesystem layout...
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

