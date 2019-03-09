#
# Found in my MH mail hierarchy a number of unexplained
# instances where various files were multiply linked to the
# same inode so I wrote this script to report such instances
# and, in the case when one file is a "live" file (ie. has no
# comma in the name) to recommend deletion of the others.
# NOTE: these multi-linked files seem to be part of MH's
# approach to deleting/sorting/relocating message files and
# are not a "problem"
#

MH_HIERARCHY_ROOT=/home/mod/.mail

function listOfMHfilesWithBetween2and7dirLinks() {
    local i;
    local l;
    local f;
    for i in $(for l in $(seq 2 7) ; do find . -xdev -type f -links $l ; done \
             | while read f ; do ls -id1 $f ; done | word1 | sort -nu);
    do
        echo $(find . -xdev -inum $i | sed -e s/..// );
    done
}

function MHfilesLinkedToSameInode() {
    local c;    # Comma files
    local cc;   # Comma files(count)
    local l;
    local x;    # Normal files
    local xc;   # Normal files(count)
    while read l; do
        c=$(echo "$l" | fmt -1 | fgrep    -e ',');
        x=$(echo "$l" | fmt -1 | fgrep -v -e ',');
        cc=$(echo "$c" | wc -w);
        xc=$(echo "$x" | wc -w);
        if [ $xc -eq 1 -a $cc -ge 1 ]; then
            echo KEEP $x TOSS $c;
        else
            echo INVESTIGATE X:$xc C:$cc $x $c;
        fi;
    done
}

cd $MH_HIERARCHY_ROOT && \
  listOfMHfilesWithBetween2and7dirLinks | MHfilesLinkedToSameInode
