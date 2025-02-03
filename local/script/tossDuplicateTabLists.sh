#!/bin/bash

[ "$XXX_MIKE_DEBUG" ] && set -x

# Having asked Firefox to periodically remember its list
# of open tabs we try to minimize storage requirements by
# detecting when multiple lists are (essentially) the same.

##############################################################################
#
#export PATH=/home/mod/UNPORTABLE/local/script:/home/mod/PORTABLE/local/script:/home/mod/UNPORTABLE/local/bin:/etc/alternatives:/home/mod/PORTABLE/local/bin.i686:/sbin:/bin:/usr/bin:/usr/sbin:/usr/bin/mh:/usr/bin/X11:/usr/local/bin:/usr/local/sbin:/usr/games:/usr/local:/usr/local/firefox:/usr/local/games:/usr/local/natspeak/bin:/usr/local/share

#export PATH=~/local/script:~/local/bin:~/local/bin.i686:/etc/alternatives:/sbin:/bin:/usr/bin:/usr/sbin:/usr/bin/mh:/usr/bin/X11:/usr/local/bin:/usr/local/sbin:/usr/games:/usr/local:/usr/local/firefox:/usr/local/games:/usr/local/natspeak/bin:/usr/local/share:.

#export PATH=/Users/mod/modHOME/local/script:/Users/mod/modHOME/local/bin:/Users/mod/modHOME/local/symlink:/sbin:/bin:/usr/sbin:/opt/local/sbin:/opt/local/bin:/usr/local/bin:/usr/local:/usr/bin:/usr/X11:/usr/X11/bin:.

#export PATH=/Users/mi25714/modHOME/local/script:/Users/mi25714/modHOME/local/alternative:/sbin:/bin:/usr/sbin:/usr/local:/usr/local/bin:/opt/local/bin:/opt/local/sbin:/usr/bin:/usr/X11:/usr/X11/bin:.

#export PATH=/home/mod/modHOME/local/script:/home/mod/modHOME/local/alternative:/etc/alternatives:/sbin:/bin:/usr/sbin:/usr/local:/usr/local/bin:/usr/local/sbin:/usr/local/firefox:/usr/local/games:/usr/local/share:/usr/bin:/usr/bin/X11:/usr/games:.

#export PATH=/Users/mi25714/modHOME/local/script:/Users/mi25714/modHOME/local/alternative:/bin:/sbin:/usr/bin:/usr/sbin:/Applications/MacVim.app/Contents/MacOS:/Users/mi25714/modHOME/local/alternative/osxVMwareFusionLibrarySymlink:/Users/mi25714/modHOME/local/alternative/osxVMWareOVFtoolDir:/usr/local:/usr/local/bin:/usr/local/sbin:/usr/local/share:/usr/X11:/usr/X11/bin:.

#export PATH=/home/mod/modHOME.custom/local/script:/home/mod/modHOME/local/script:/home/mod/modHOME.custom/local/bin:/home/mod/modHOME.custom/local/bin.i686:/home/mod/modHOME/local/alternative:/home/mod/modHOME/local/bin:/etc/alternatives:/sbin:/bin:/usr/bin:/usr/sbin:/usr/local/sbin:/usr/local/bin:/usr/bin/X11:/usr/local/share:/usr/local/games:/usr/local/firefox:/usr/games:/usr/bin/mh:/usr/local:.

 export PATH=/home/mod/modHOME.custom/local/script:/home/mod/modHOME/local/script:/home/mod/modHOME.custom/local/bin.x86_64:/home/mod/modHOME.custom/local/alternative:/home/mod/modHOME.custom/local/bin:/home/mod/modHOME/local/alternative:/home/mod/modHOME/local/bin:/home/mod/.local/bin:/etc/alternatives:/sbin:/bin:/usr/bin:/usr/sbin:/usr/local/sbin:/usr/local/bin:/usr/bin/X11:/usr/local/share:/usr/local/games:/usr/local/firefox:/usr/lib/firefox:/usr/games:/usr/local

##############################################################################
# Never mind extraneous info (like which window it's in, etc)
# about each URL - just generate a sorted uniq list of URLs...
#
function canonicalizedTabLines() { extractURLs | LC_ALL=C sort -bfd | uniq ; }

##############################################################################
#

#cd ~mod/.mozilla/firefox/wq7jkb5f.default || exit 1

#cd ~/Library/"Application Support"/Firefox/Profiles/adrmdgba.default || exit 1
#cd ~/.mozilla/firefox/wq7jkb5f.default                               || exit 1

tempFile=/tmp/tempFile$$.$(tds)

  (for f in opentabs--2*.txt ; do echo $(md5sum < <(canonicalizedTabLines < $f) | word1) $f ; done) > "${tempFile}"

# (for f in opentabs--2*.txt ; do echo $(md5    < <(canonicalizedTabLines < $f) | word1) $f ; done) > "${tempFile}"

dupMD5list=$(word1 < "${tempFile}" | LC_ALL=C sort | uniq -d)

# ASSUME: list sorted in temporal order, so only keeping earliest.
#
for m in ${dupMD5list} ; do
    toss=$(fgrep -e $m "${tempFile}" | word2 | sed -e 1d)
    rm -f $toss
done

if ! [ "$XXX_MIKE_DEBUG" ] ; then
    rm -f "${tempFile}"
fi

