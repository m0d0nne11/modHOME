#!/bin/bash
#

test -n "$MIKE_DEBUG" && set -xv

###############################################################################
shopt -s nullglob         # So *.x doesn't expand to literal *.x when no match.
unset DISPLAY          # So various apps&libs don't try to get all GUI on us...

export PATH=~/local/script:~/local/bin:/etc/alternatives:~/local/bin.i686:/sbin:/bin:/usr/bin:/usr/sbin:/usr/bin/mh:/usr/bin/X11:/usr/local/bin:/usr/local/sbin:/usr/games:/usr/local:/usr/local/firefox:/usr/local/games:/usr/local/natspeak/bin:/usr/local/share:.


export         SHELL=/bin/bash             # Defend against [t]csh dainbramage.
          scriptName=$0
           timeStamp=$(date '+%Y%m%d%H%M%S')
                argv=$*
             VERSION=1.0.20100201
            HOSTNAME=$(hostname)
             BASEDIR=/tmp/DebugUSB

# Next cycle started ASAP but no sooner than SECONDS_PER_CYCLE from
# start of previous cycle.
SECONDS_PER_CYCLE=100

###############################################################################
# Accumulate stdout data somewhere
#
# SEE ALSO: man {logger,syslog,syslog.conf}
#
function log1()  {
#   cat >> /var/log/WSI/rotateWxSimRecordings.log   # During development...

    # Accumulate output in /var/log/messages
    logger -t monitorUSB
}

###############################################################################
# Utter the (optional) explanation into the log and then die...
#
function FAIL()  {
    local msg=""
    if [ $# -lt 1 -o -z "$*" ] ; then
        msg="(unspecified)"
    else
        msg="$*"
    fi

    echo FAIL: "${msg}" | log1

    exit 1
}

###############################################################################
# The main loop, encapsulated in a function.
#
function monitorUSBloop()  {
    local deadline
    local MSG
    local now
    local rsyncStatus
    local seconds
    local abandon=0

echo "$scriptName(v.$VERSION)" $argv
echo "(RE-)STARTING monitorUSBloop()..."

    mkdir -p $BASEDIR
    if ! cd           "${BASEDIR}" ; then
        FAIL "Can't cd ${BASEDIR}"
    fi

    test ! -e snapshot.last && cat /dev/null > snapshot.last

    while : ; do
        # Next cycle should begin as soon as possible after...
        deadline=$[$(date '+%s') + $SECONDS_PER_CYCLE]

        echo "################################# BEGIN cycle $deadline"

        lsusb -v 2>&1 > snapshot.this
        if ! diff -w -E -b -B snapshot.last snapshot.this > diffLog ; then
            echo "#####################################" DIFFERENCES:
            cat diffLog
            echo "#####################################" CURRENT SNAPSHOT:
            cat snapshot.this
            echo "#####################################" DONE
        fi

        mv snapshot.this snapshot.last

        # Time before deadline? sleep, else start next cycle immediately...
        now=$(date '+%s')
        if [ $now -lt $deadline ] ; then
            seconds=$[$deadline - $now]
            echo "################## SLEEP $seconds before next cycle"
            sleep $seconds
        fi
    done
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Functions now defined - commence actual execution
#

monitorUSBloop < /dev/null 2>&1 | log1

FAIL                           # ASSUME: we never exit main loop voluntarily...

