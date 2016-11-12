#!/bin/bash
#
# This script assumes that stdin is a list of filenames in tds.md5 form
# and tries to ensure that the file(s) in question actually exist and
# that their filesystem timestamps and their MD5 sums agree with those
# indicated by the file's name.
#
# Note: tds=TimeDateStamp which is my term for the yyyymmddhhmmss form
#
# The tds.md5 form of these filenames looks like this:
#
#    yyyymmddhhmmss.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
#
# ...where the x's represent the 32 hex digits of that file's MD5 sum.
#
# If the MD5 portion is wrong then the file will be renamed such that
# its current MD5 sum is reflected in the new name.  An attempt is
# then always blindly made to force the file's time/date metadata in
# the filesystem to agree with the tds portion of the filename.  IOW,
# the MD5 portion of the filename may be changed if it's not the same
# as is calculated for the file's contents, but neither the file's
# contents or the tds portion of its name will ever be changed.
#
# For backwards compatibility with previous versions that didn't handle
# the MD5 stuff, it is permitted that filenames be in simple tds form
# without any MD5 portion; an MD5 sum will be calculated and the file
# renamed accordingly.  And, yes - I know that MD5 is now regarded as
# being insecure because various flaws and exploits have been discovered
# but security isn't a concern here...

# Adding PON's (Painfully Obvious Note) to aid in designing the
# Python version.
#
###############################################################################

function tdsMD5retagFunc()  {

    local base
    local contrived
    local dir
    local f
    local md5
    local md5p
    local others
    local proposed
    local tds

    f=$1

    dir="`dirname $f`" # Extract from the specified pathname the directory the NoteFile resides in.
    if ! cd "${dir}" ; then           # Attempt to stand in specified directory
        echo "can't CD to dirname($f)"
        return 1
    fi

    base="`basename $f`"    # Extract the basename from the specified filename.
    if ! [ -f "${base}" ] ; then                          # Verify file exists.
        echo "no basename($f) in $dir"
        return 1
    fi

    # We require that the filename be laid out in tds.md5 format:
    #    yyyymmddhhmmss.md5xmd5xmd5xmd5xmd5xmd5xmd5xmd5x
    # ...specifying Year/Month/Day/Hour/Minute/Second followed
    # by the 32 hex characters of its MD5 sum.  For historical
    # purposes we allow filenames without the MD5 info, in which
    # case we contrive some temporary fake MD5 characters prior to
    # recomputing the actual MD5 sum.
    #
    if ! echo "${base}" | grep -q -E '^[[:digit:]]{14}\.[[:xdigit:]]{32}$' ;
    then                         # Not tds.md5 form - is it plain old tds form?
        if ! echo "${base}" | grep -q -E '^[[:digit:]]{14}$' ; then
            echo '####' Filename "${base}" not in tds or tds.md5 form
            return 1
        fi

    # If plain old unadorned tds form, contrive an md5 portion that's
    # intended never to match the name of a legitimate Notefile...
    #
        contrived="${base}".0123456789abcdef
        if [ -e "${contrived}" ] ; then                   # Should never happen
            echo "#### Already have file $contrived in $dir($base)"
            return 1
        fi
        if ! mv "${base}" "${contrived}"; then
            echo "#### Can't mv ${base} ${contrived} in ${dir}"
            return 1
        fi
        base="${contrived}"
    fi

    # At this point we know that the file has a name we can work with,
    # even if it's contrived...
    #
    tds=`echo   "${base}" | sed -e 's/\..*$//'` # Isolate just the TDS portion.
    md5=`md5sum "${base}" | word1`                    # Compute proper MD5 sum.
    proposed="$tds.$md5"           # Now we know what the file SHOULD be named.

    if [ "$base" != "$proposed" ] ; then                 # File has wrong name?
        if [ -e $proposed ] ; then
            md5p=`md5sum "${proposed}" | word1`
            if [ "${md5}" = "${md5p}" ] ; then
                echo "#### $base has duplicate ($proposed) in $dir - deleting..."
                rm -f "${proposed}"
            else
                echo "#### $proposed needs retag in $dir - can't rename $base"
                return 1
            fi
        fi

        if others="$(echo "${tds}".* | fmt -1 | grep -v -e "^${base}\$" | fgrep -e "${tds}")" ; then
            echo "#### Multiple files in $dir w/same TDS - will not rename..."
            echo -e '\t'${base} ${others} | fmt -1
            return 1
        fi

        if ! mv $base $proposed ; then
            echo "#### Couldn't mv $base $proposed in $dir"
            return 1
        fi
    fi

    # OK - file now exists with correct name.  Force timestamp...

    if ! tdsTouch $tds $proposed ; then
        echo "#### Couldn't tdsTouch $tds $proposed"
        return 1
    fi

    if [ "${base}" != $proposed ] ; then
        echo "${base} ->"
        echo "${proposed}"
        echo
    fi

    return 0
}

startDir=$PWD

GRONK
exit

while read f ; do
    cd $startDir                    # Pathnames may be relative to initial dir.
    tdsMD5retagFunc "${f}"
done

