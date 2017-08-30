
echo "#### PROBLEM - this script needs work...  $0 $@"

exit 1

  set -x

function cleanupTempFiles()  {
    rm -f $pathList $dirList $anchored $unanchored
    exit
}

trap cleanupTempFiles EXIT

if [ $# -lt 1 ]
then
        echo Usage:
        echo "        $0 objectFile_to_extract_fileList_from"
        exit 1

echo "#### PROBLEM - this script needs work...  $0 $@"

exit 1

  set -x

function cleanupTempFiles()  {
    rm -f $pathList $dirList $anchored $unanchored
    exit
}

trap cleanupTempFiles EXIT

if [ $# -lt 1 ]
then
        echo Usage:
        echo "        $0 objectFile_to_extract_fileList_from"
        exit 1
fi

  pathList=$(mktemp /tmp/pathList.XXXXXXXX)   || { echo FAILED mktemp /tmp/pathList.XXXXXXXX   ; exit 1 ; }
   dirList=$(mktemp /tmp/dirList.XXXXXXXX)    || { echo FAILED mktemp /tmp/dirList.XXXXXXXX    ; exit 1 ; }
  anchored=$(mktemp /tmp/anchored.XXXXXXXX)   || { echo FAILED mktemp /tmp/anchored.XXXXXXXX   ; exit 1 ; }
unanchored=$(mktemp /tmp/unanchored.XXXXXXXX) || { echo FAILED mktemp /tmp/unanchored.XXXXXXXX ; exit 1 ; }


# Gather a list of all files mentioned in the object file in question.
# We attempt to "canonicalize" every name in the list...
#
objdump -s -G $1 \
        | fgrep -e ' BINCL ' -e ' EXCL ' -e ' SO ' -e ' SOL ' \
        | sed -r -e 's/[[:space:]]+$//' -e 's/^.*[[:space:]]//' \
        | sort -fd \
        | uniq \
        | canonicalPath \
        | sort -fd \
        | uniq > $pathList

cat /dev/null > $dirList
cat /dev/null > $anchored
cat /dev/null > $unanchored

# For every pathname mentioned in that list...
#
while read f
do
        if [ -f "${f}" ]             # If we can immediately ID it as a file...
        then
                echo "${f}" >> $anchored
        elif [ -d "${f}" ]      # If we can immediately ID it as a directory...
        then
                echo "${f}" >> $dirList
        else
                echo "${f}" >> $unanchored    # ...hope we can anchor it later.
        fi
done < $pathList

while read f            # for every unanchored file mentioned in the objdump...
do
    hit=0
    while read d              # for every directory mentioned in the objdump...
    do
        if [ -f "${d}"/"${f}" ]
        then
            echo "${d}"/"${f}" >> $anchored
            let hit++
        fi
    done < $dirList

    if [ $hit -eq 0 ]
    then
        if [ "${f}" != "0" ]       # Special case: Ignore objdump output quirk.
        then
            echo "######### Can't find ${f}"
        fi
    fi
done < $unanchored

canonicalPath < $anchored | sort -u                         # ...one last time.

# cleanupTempFiles # Handled via the trap

