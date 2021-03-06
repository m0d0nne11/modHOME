# hashBang line disabled to accommodate Termux's nonstandard filesystem layout...
#! /bin/sh
set -e

# Set the variables below to fit your site. You can then use cron to have this
# script run daily to automatically update your copy of the archive
#
# TO is the destination for the base of the debian directory (the dir that
# holds dists/ and ls-lR)
#
# RSYNC_HOST is the site you have chosen from the mirrors file
#
# RSYNC_DIR is the directory given in the Archive-rsync: line of the
# mirrors file for the site you have chosen to mirror.
#
# chmod 744 anonftpsync
#
# You MUST have rsync 2.0.16-1 or newer which is available in slink

# With a blank EXCLUDE you will mirror the entire archive.
#EXCLUDE="--exclude *alpha.deb --exclude *m68k.deb --exclude \
#    *powerpc.deb --exclude stable/ --exclude bo/ --exclude \
#    /contrib/ --exclude /non-free/ --exclude source/ --exclude \
#    /Debian-1.3* --exclude binary-alpha/ --exclude binary-m68k/ \
#    --exclude binary-powerpc/ --exclude Incoming/ --exclude \
#    local/ --exclude bo-unstable/ --exclude bo-updates/ "

TO=/huge/mirror/debian
RSYNC_HOST=mirrors.kernel.org
RSYNC_DIR=mirrors/debian/
EXCLUDE="--exclude *m68k.deb --exclude binary-m68k/ --exclude *s390.deb --exclude binary-s390/ \
	 --exclude *hppa.deb --exclude binary-hppa/ --exclude *ia64.deb --exclude binary-ia64/ \
	 --exclude *mips.deb --exclude binary-mips/ --exclude *mipsel.deb --exclude binary-mipsel"

LOCK="${TO}/Archive-Update-in-Progress-$(hostname -f)"

# Get in the right directory and set the umask to be group writable
# 
cd $HOME
umask 002

# Check to see if another sync is in progress
if lockfile -! -l 43200 -r 0 "$LOCK"; then
  echo $(hostname) is unable to start rsync, lock file exists
  exit 1
fi
trap "rm -f $LOCK > /dev/null 2>&1" exit  

set +e
rsync -rltvz --delete \
     --exclude "Archive-Update-in-Progress-$(hostname -f)" \
     --exclude "project/trace/$(hostname -f)" \
     $EXCLUDE \
     $RSYNC_HOST::$RSYNC_DIR $TO > rsync.log 2>&1
date -u > "${TO}/project/trace/$(hostname -f)"
savelog rsync.log > /dev/null 2>&1
