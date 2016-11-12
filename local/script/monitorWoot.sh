#!/bin/bash
#
# Poll the Woot! WWW site and send email to interested parties whenever
# the product description changes.  Yes, something like RSS would probably
# be more straightforward but I don't know how to use it...
#
# Non-debug invocation: thisScript < /dev/null > /dev/null 2>&1 &
#
# Typical /etc/inittab invocation:
#
# w0:5:respawn:su -l modonnel -c '(monitorWoot.sh < /dev/null > /dev/null 2>&1) < /dev/null > /dev/null 2>&1'
#
###############################################################################

# To maintain the following list of functions, position (in vi) the cursor on
# the first line in the list and then execute one of the following verbatim:
#
# !}grep -e '^function ' % | awk '{ print $2 }' | sort -bfd | sed -e 's/^/\# /'
# !}grep -e '^function ' % | awk '{ print $2 }' |             sed -e 's/^/\# /'
# FUNCTIONS:

# log1()
# FAIL()
# wootMonitorLoop()

# ASSUME: some of Mike's other scripts available:
#   extractURLs - reports URLs found in stdin
#   junkFix     - remove/replace bogus characters
#   noCR        - remove CR from DOS-style CR/LF pairs (tr -d "\015")
#   eatwhite    - collapse whitespace
#   paraCrunch  - collapse/reformat text

# ASSUME: the MH mail package is available

if [ -n "$MIKE_DEBUG" ] ; then
    set -x
         LOG_FUNC=cat
 EMAIL_RECIPIENTS=mod.wootMonitor@b0rken.com
else
         LOG_FUNC=log1
#EMAIL_RECIPIENTS=mod.wootMonitor@b0rken.com,smellott@wsi.com,jgunter@wsi.com
#EMAIL_RECIPIENTS=michael.odonnell@comcast.net,smellott@wsi.com,jgunter@wsi.com
 EMAIL_RECIPIENTS=michael.odonnell@comcast.net
fi

###############################################################################
#export      PATH=$PATH:/bin:/usr/bin:/usr/local/bin   # Needed if run by cron?
 export      PATH=/home/mod/local/script:/home/mod/local/bin.i686:/etc/alternatives:/usr/local/bin:/usr/local/sbin:/usr/bin/mh:/usr/bin:/usr/bin/X11:/usr/games:/usr/sbin:/bin:/sbin:/usr/local:/usr/local/firefox:/usr/local/games:/usr/local/natspeak/bin:/usr/local/share:.

 export     SHELL=/bin/bash                # Defend against [t]csh dainbramage.
             argv=$*
       scriptName=$0
          VERSION=1.0.20100820
         HOSTNAME=`hostname`
        LAST_DESC=/tmp/lastWoot
        THIS_DESC=/tmp/currentWoot
        tempFile1=`mktemp /tmp/monitorWoot.XXXXXXXXXX`
         htmlTemp="$tempFile1".html
          diffLog="$tempFile1".diffLog

# Next cycle started ASAP but no sooner than SECONDS_PER_CYCLE after
# start of previous cycle.
SECONDS_PER_CYCLE=133

###############################################################################
# Accumulate stdout data somewhere
#
# SEE ALSO: man {logger,syslog,syslog.conf}
#
function log1()  {

#   cat # >> /tmp/monitorWoot.logFile                        # for debugging...
#   logger -t monitorWoot -p local5.info    # Use different syslog channel/file
    logger -t monitorWoot                 # Tagged entries to /var/log/messages
}

###############################################################################
# Complain and die...
#
function FAIL()  {
        local msg=""
        if [ $# -lt 1 -o -z "$*" ] ; then
                msg="(unspecified)"
        else
                msg="$*"
        fi

        echo FAIL: "${msg}" | $LOG_FUNC

        exit 1
}

###############################################################################
# Mail stdin to the specified recipient(s) from the specified sender.
# NOTE: this version assumes MH is available for email processing.
#
function mail2func()
{
    if [ $# -ne 3 ]                                   # Number of args correct?
    then #               0          1          2        3
        echo "usage: $FUNCNAME emailAddr{s} fromAddr subject <stdin"
        return 1
    fi
    tempFile=/tmp/mail2funcTemp$$`tds`
    echo "To: $1"                  >$tempFile
    echo "From: $2"               >>$tempFile
    echo "Subject: $3"            >>$tempFile
    echo ""                       >>$tempFile
    cat                           >>$tempFile
   /usr/lib/mh/post -watch -verbose $tempFile
    rm                              $tempFile
}

###############################################################################
# The main loop, encapsulated in a function.
#
function wootMonitorLoop()  {
    local deadline
    local now
    local seconds
    local subj
    local url

    echo "$scriptName(v.$VERSION)" $argv
    echo "(RE-)STARTING wootMonitorLoop()..."
    cat /dev/null > $THIS_DESC
    cat /dev/null > $LAST_DESC

    while : ; do

        # Next cycle should begin ASAP after...
        #
        deadline=$[$(date '+%s') + $SECONDS_PER_CYCLE]
if [ -n "$MIKE_DEBUG" ] ; then
    echo DEADLINE:$deadline
fi

        # Preemptively toss temp files (but not DESC files) unless debugging
        #
        if ! [ -n "$MIKE_DEBUG" ] ; then
            rm -f $htmlTemp $diffLog $tempFile1 ]
        fi

        # Capture slightly cleansed version of Woot main page HTML.
        #
#       wget --user-agent="Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)"
        wget --user-agent="Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101 Firefox/45.0" \
             -O - http://www.woot.com/ 2>/dev/null \
                                       | noCR | eat | junkFix > $htmlTemp
        if file $htmlTemp | fgrep -i zip ; then
if [ -n "$MIKE_DEBUG" ] ; then
    echo SKIPPING gzipped content...
fi
            continue               # WTF? Woot occasionally xmits gzipped data?
        fi

if [ -n "$MIKE_DEBUG" ] ; then
    echo CAPTURED HTML_TEMP:
    cat $htmlTemp
fi

        # Extract phrases of interest and assemble into item description.
        #
#       lynx -dump $htmlTemp | paraCrunch | grep -e '^ Product: ' -e '^ Condition: ' -e '^ \$' | sort -bfdr | sed -e 's/^ Product: /WOOT: /' -e 's/^ Products: /WOOT: /' | paraCrunch | fmt -2300 > $THIS_DESC
        lynx -dump $htmlTemp | paraCrunch | fmt -2300 | grep -e '^ Product: ' -e '^ Condition: ' -e '^ \$' -e '^ Products: ' | sort -bfdur | sed -e 's/^ Product: /WOOT: /' -e 's/^ Products: /WOOT: /' | paraCrunch | fmt -2300 > $THIS_DESC

if [ -n "$MIKE_DEBUG" ] ; then
    echo THIS_DESC:
    cat $THIS_DESC
fi

        # Send email only if this (non-null) DESC differs from previous.
        #
        subj="`cat $THIS_DESC`"
        if [ -n "${subj}" ] ; then
if [ -n "$MIKE_DEBUG" ] ; then
    echo SUBJ:
    echo "${subj}"
fi
            if ! diff -U5 $LAST_DESC $THIS_DESC > $diffLog 2>&1 ; then
if [ -n "$MIKE_DEBUG" ] ; then
    echo DIFFLOG:
    cat $diffLog
fi
                # Include URL for item in msg body...
                url=$(fgrep -e 'Discussion on Today' $htmlTemp | head -1 | extractURLs | head -1)
                if [ -z "$url" ] ; then                          # Fall-back...
                    url=$(extractURLs < $tempFile1 | fgrep -e 'PostID=' | head -1)
                fi
#               cat $THIS_DESC <(echo $url; echo diffLog:) $diffLog | mail -s"${subj}" $EMAIL_RECIPIENTS
                cat $THIS_DESC <(echo $url; echo diffLog:) $diffLog | mail2func $EMAIL_RECIPIENTS michael.odonnell@comcast.net "${subj}"
            fi
            cat $THIS_DESC > $LAST_DESC
        fi

        # Time before deadline? sleep, else next cycle starts immediately...
        #
        now=$(date '+%s')
        if [ $now -lt $deadline ] ; then
            seconds=$[$deadline - $now]
            sleep $seconds
        fi
    done
}

###############################################################################
# The main loop, encapsulated in a function.
#
function NEWwootMonitorLoop()  {
    local deadline
    local now
    local seconds
    local subj
    local url

    echo "$scriptName(v.$VERSION)" $argv
    echo "(RE-)STARTING wootMonitorLoop()..."
    cat /dev/null > $THIS_DESC
    cat /dev/null > $LAST_DESC

    while : ; do

        # Next cycle should begin ASAP after...
        #
        deadline=$[$(date '+%s') + $SECONDS_PER_CYCLE]

if [ -n "$MIKE_DEBUG" ] ; then
    echo DEADLINE:$deadline
fi

lynx -width=2400 -dump -useragent="Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101 Firefox/45.0"  http://www.woot.com/ 2>/dev/null | sed -e '1,/woot-off-light/d' | sed -e '/woot-off-light/d' -e '/ Share:/,$d' | paraCrunch | fmt -2400 | sort -bfdu > /tmp/rzq
grep -e  '^ Condition: ' /tmp/rzq | sed -e 's/^ Condition: /(/' -e 's/$/)/'
grep -e  '^ Products*: ' /tmp/rzq | sed -e 's/^ Products*: //'
fgrep -e '$' /tmp/rzq

RZQ RZQ RZQ

        # Preemptively toss temp files (but not DESC files) unless debugging
        #
        if ! [ -n "$MIKE_DEBUG" ] ; then
            rm -f $htmlTemp $diffLog $tempFile1 ]
        fi

        # Capture slightly cleansed version of Woot main page HTML.
        #
        wget --user-agent="Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101 Firefox/45.0" \
             -O - http://www.woot.com/ 2>/dev/null \
                                       | noCR | eat | junkFix > $htmlTemp
        if file $htmlTemp | fgrep -i zip ; then
if [ -n "$MIKE_DEBUG" ] ; then
    echo SKIPPING gzipped content...
fi
            continue               # WTF? Woot occasionally xmits gzipped data?
        fi

if [ -n "$MIKE_DEBUG" ] ; then
    echo CAPTURED HTML_TEMP:
    cat $htmlTemp
fi

        # Extract phrases of interest and assemble into item description.
        #
#       lynx -dump $htmlTemp | paraCrunch | grep -e '^ Product: ' -e '^ Condition: ' -e '^ \$' | sort -bfdr | sed -e 's/^ Product: /WOOT: /' -e 's/^ Products: /WOOT: /' | paraCrunch | fmt -2300 > $THIS_DESC
        lynx -dump $htmlTemp | paraCrunch | fmt -2300 | grep -e '^ Product: ' -e '^ Condition: ' -e '^ \$' -e '^ Products: ' | sort -bfdur | sed -e 's/^ Product: /WOOT: /' -e 's/^ Products: /WOOT: /' | paraCrunch | fmt -2300 > $THIS_DESC

if [ -n "$MIKE_DEBUG" ] ; then
    echo THIS_DESC:
    cat $THIS_DESC
fi

        # Send email only if this (non-null) DESC differs from previous.
        #
        subj="`cat $THIS_DESC`"
        if [ -n "${subj}" ] ; then
if [ -n "$MIKE_DEBUG" ] ; then
    echo SUBJ:
    echo "${subj}"
fi
            if ! diff -U5 $LAST_DESC $THIS_DESC > $diffLog 2>&1 ; then
if [ -n "$MIKE_DEBUG" ] ; then
    echo DIFFLOG:
    cat $diffLog
fi
                # Include URL for item in msg body...
                url=$(fgrep -e 'Discussion on Today' $htmlTemp | head -1 | extractURLs | head -1)
                if [ -z "$url" ] ; then                          # Fall-back...
                    url=$(extractURLs < $tempFile1 | fgrep -e 'PostID=' | head -1)
                fi
#               cat $THIS_DESC <(echo $url; echo diffLog:) $diffLog | mail -s"${subj}" $EMAIL_RECIPIENTS
                cat $THIS_DESC <(echo $url; echo diffLog:) $diffLog | mail2func $EMAIL_RECIPIENTS michael.odonnell@comcast.net "${subj}"
            fi
            cat $THIS_DESC > $LAST_DESC
        fi

        # Time before deadline? sleep, else next cycle starts immediately...
        #
        now=$(date '+%s')
        if [ $now -lt $deadline ] ; then
            seconds=$[$deadline - $now]
            sleep $seconds
        fi
    done
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Functions now defined - commence actual execution
#

wootMonitorLoop 2>&1 | $LOG_FUNC

exit 1

