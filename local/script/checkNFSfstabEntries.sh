#!/bin/bash
#
#  For each NFS mount specification line in the FSTAB_FILE we
#  verify that (A) the specified host is reachable, (B) the remote
#  node is a directory, (C) the local mountpoint is a directory
#  and (D) no local mountpoint is mentioned more than once.
#
#  ASSUME: remote hosts are reachable via SSH, preferably w/o
#          needing a password.
#

test -n "$MIKE_DEBUG" && set -x

FSTAB_FILE=/etc/fstab

while read fstabLine ; do
    read h r l x < <(echo $fstabLine)                 # host/remote/local/other
    echo "#### CHECKING" $h:$r $l
    if ! ssh $h ls -laCFd $r/. < /dev/null > /dev/null 2>&1 ; then
        echo "######## CAN'T VERIFY REMOTE DIR:" $h:$r/.
    fi
    if ! ls -laCFd $l/. > /dev/null 2>&1 ; then
        echo "######## CAN'T VERIFY  LOCAL DIR:" $l/.
    fi
done < <(sed -e 's/#.*$//' -e 's/[[:space:]]*$//' < $FSTAB_FILE | grep '[[:space:]]nfs[[:space:]]' | tr ':' ' ')

dups="$(sed  -e 's/#.*$//' -e 's/[[:space:]]*$//' < $FSTAB_FILE | grep '[[:space:]]nfs[[:space:]]' | awk '{ print $1 }' | sort -bfd | uniq -d)"
if [ -n "$dups" ] ; then
    echo "######## REMOTE DIRS MENTIONED MULTIPLE TIMES:"
    echo "$dups" | fmt -1
fi

dups="$(sed  -e 's/#.*$//' -e 's/[[:space:]]*$//' < $FSTAB_FILE | grep '[[:space:]]nfs[[:space:]]' | awk '{ print $2 }' | sort -bfd | uniq -d)"
if [ -n "$dups" ] ; then
    echo "########  LOCAL DIRS MENTIONED MULTIPLE TIMES:"
    echo "$dups" | fmt -1
fi

