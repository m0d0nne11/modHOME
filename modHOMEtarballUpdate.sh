#!/bin/bash

# Create a tarball from a working modHOME installation.

# Propagation of my modHOME mess can be accomplished using these tarballs
# but it will probably always be better to pull a copy over the wire from
# github.com or from another machine with a snapshot already installed:
#
#    cd; git clone https://github.com/m0d0nne11/modHOME
#    cd; git clone ssh://someUserID@someHost/some/path/to/modHOME
#
# When creating tarballs with this script only the modHOME
# hierarchy is captured; the modHOME.custom hierarchy is
# assumed to be private and specific to the local machine.
#
# Note that this script was previously the primary method
# of propagation before converting to Git, so test carefully
# as it is not maintained much since then...

[ -n "$MIKE_DEBUG" ] && set -x

myName="${0}"
myPID=$$

archSpecificOpts=""

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Echo the commandline args (if any and they refer to existing files)
# and indicate whether there were any.
# NOTE: filenames with whitespace will lead to sorrow...
#
function anyFilesPresent()  {
	local z=0
	while [ $# -gt 0 ] ; do
		if [ -e "$1" ] ; then
	 		echo $1
			let z++
		fi
		shift
	done
	[ $z -ne 0 ] # The return value.
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# isMacOS
#
function isMacOS()  {
	uname -a | fgrep -q -e Darwin
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Complain and die.
#
function FAILED()  {
        local msg

        if [ $# -lt 1 ]
        then
                msg="(unspecified error)"
        else
                msg="${*}"
        fi

        echo "${myName} FAILED: ${msg}" >&2
	kill -9 $myPID
        exit 1
}

if ! [ -d modHOME/. -a -L Bmod ] ; then
	FAILED must execute in parent directory of modHOME
	exit 1
fi

if ! timeStamp=`date '+%Y%m%d%H%M%S'` ; then
	FAILED "Can't compute timeStamp?"
	exit 1
fi

if isMacOS ; then
	echo "NOTICE: execution under MacOS not recommended as the"
	echo "        case-insensitive file system allows name collisions."
	archSpecificOpts="--disable-copyfile"
	COPYFILE_DISABLE=1
fi

STAGING=modHOMEstaging$timeStamp
mkdir           $STAGING         || exit 1
cp -a modHOME/. $STAGING/modHOME || exit 1
cd              $STAGING         || exit 1

( cd modHOME/. &&							\
	( rm -rf         .Adobe           .adobe        .config		\
		.dbus    Desktop          .gconf        .gconfd		\
		.gnome2  hostDir          .ICEauthority .kde		\
		.lesshst .mcop            .mozilla      .p4qt		\
		.qt      .rhn-applet.conf .screen       .ssh		\
		.viminfo .vnc             .xauth*       .Xauthority ;	\
	  cat .historyOK > .history ;					\
	  ( cd local/. && rm -f bin && ln -sf bin.x86_64 bin ; )        \
	)								\
)

rm -f                                     modHOME/modHOMEsnapshotVersion*
echo                         $timeStamp > modHOME/modHOMEsnapshotVersion.$timeStamp
ln -s modHOMEsnapshotVersion.$timeStamp   modHOME/modHOMEsnapshotVersion

# Now using vimSymlinkInit() instead of tarball
#vimInitFiles=".exrc .vim .vimrc"
#for f in        $vimInitFiles ; do ln -s modHOME/$f ; done
#tar cvzf modHOME/vimInitFiles.tgz $archSpecificOpts $vimInitFiles

(chmod -R mod.mod modHOME) >&/dev/null # OK to fail
ln -s modHOME/Bmod
tar cvzf modHOME.tgz.$timeStamp $archSpecificOpts Bmod modHOME

mv modHOME.tgz.$timeStamp ..
cd ..
rm -rf $STAGING

echo "#### GENERATED modHOME.tgz.$timeStamp"

