#!/bin/bash

# Some GUI tools on MacOS (Finder, et al...) stooopidly refuse
# to show directories that it's sometimes necessary to access,
# so we create a little subdirectory (folder!) containing
# useful symlinks pointing at destinations we might like to
# visit and which are then usable from the Finder and such...
#

[ "$XXX_MIKE_DEBUG" ] && set -x ;

###########################################################################
#
function FAIL()  { echo FAIL: "$*" ; exit 1 ; }

###########################################################################

cd ~                                    || FAIL 'No HOME directory?'

cd Desktop                              || FAIL 'No ~/Desktop directory?'

[ -d SymlinkTo/. ] || mkdir SymlinkTo   || FAIL "Can't create directory ~/Desktop/SymlinkTo?"

cd SymlinkTo/.                          || FAIL "Can't cd directory ~/Desktop/SymlinkTo?"

rm -f root tmp usr homeDir Library

ln -sf /                 root           || FAIL "Can't create symlink to root directory?"

ln -sf root/tmp/.        tmp            || FAIL "Can't create symlink to /tmp directory?"

ln -sf root/usr/.        usr            || FAIL "Can't create symlink to /usr directory?"

ln -sf root"$(echo ~)"/. homeDir        || FAIL "Can't create symlink to HOME directory?"

ln -sf homeDir/Library/. homeDirLibrary || FAIL "Can't create symlink to ~/Library directory?"

