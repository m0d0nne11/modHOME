#!/bin/bash
#
# This script will quickly remove the specified line from ~/.ssh/known_hosts
# so that it can be rewritten by a subsequent SSH session.
#
# Usage
#    zapKnownHostLine.sh lineNumberInKnownHostsFile [homeDirToUse]
#
# Example:
#
#  ######## 449---> ssh root@remoteSystem
#  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#  @    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
#  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#  IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
#  Someone could be eavesdropping on you right now (man-in-the-middle attack)!
#  It is also possible that the RSA host key has just been changed.
#  The fingerprint for the RSA key sent by the remote host is
#  a3:2a:4c:08:03:e1:92:a5:52:f7:4f:79:f2:66:bc:b5.
#  Please contact your system administrator.
#  Add correct host key in /home/modonnel/.ssh/known_hosts to get rid of this message.
#  Offending key in /home/modonnel/.ssh/known_hosts:348
#  RSA host key for remoteSystem has changed and you have requested strict checking.
#  Host key verification failed.
#
#  ######## 450---> zapKnownHostLine.sh 348
#  zapKnownHostLine.sh deleting line 348 from /home/modonnel/.ssh/known_hosts
#  (temp files: /tmp/zapKnownHostLineTEMP.KtDCMk9151 /tmp/zapKnownHostLineTEMP.hqfOqD9152)
#  348d347
#  < remoteSystem,10.81.80.221 ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAIE...................v04vVqDWbE=
#
#  ######## 451---> ssh root@remoteSystem
#  The authenticity of host 'remoteSystem (10.81.80.221)' can't be established.
#  RSA key fingerprint is a3:2a:4c:08:03:e1:92:a5:52:f7:4f:79:f2:66:bc:b5.
#  Are you sure you want to continue connecting (yes/no)? yes
#  Warning: Permanently added 'remoteSystem,10.81.80.221' (RSA) to the list of known hosts.
#  root@remoteSystem's password:
#  /usr/X11R6/bin/xauth:  creating new authority file /root/.Xauthority
#  [root@unconfigured root]#
#
function zapKnownHostLine()  {
    if [ $# -gt 1 ] ; then
        homeDir=`eval "echo ~$2"`
    else
        if [ "`whoami`" = "root" ] ; then
            homeDir=`eval "echo ~root"`
        else
            homeDir=~
        fi
    fi
    if ! [ -d $homeDir/. ] ; then
        echo "Can't find presumed home directory $homeDir"
        echo $FUNCNAME will operate by default on $homeDir/.ssh/known_hosts
        return 1
    fi
    if ! [ -d $homeDir/.ssh ] ; then
        echo "Can't find $homeDir/.ssh"
        echo $FUNCNAME will operate by default on $homeDir/.ssh/known_hosts
        return 1
    fi
    if [ $# -lt 1 ] ; then
        echo usage: $FUNCNAME 'lineNumber [userID]'
        echo $FUNCNAME will operate by default on $homeDir/.ssh/known_hosts
        return 1
    fi
    tempFile1=`mktemp /tmp/zapKnownHostLineTEMP.XXXXXXXXXX`         || return 1
    tempFile2=`mktemp /tmp/zapKnownHostLineTEMP.XXXXXXXXXX`         || return 1
    echo $FUNCNAME deleting line $1 from $homeDir/.ssh/known_hosts
    echo "(temp files: $tempFile1 $tempFile2)"
    cat            $homeDir/.ssh/known_hosts > $tempFile1           || return 1
    sed -e "$1"d  > $tempFile2               < $tempFile1           || return 1
    diff $tempFile1 $tempFile2
    cat             $tempFile2 > $homeDir/.ssh/known_hosts          || return 1
    chmod go-w                   $homeDir/.ssh/known_hosts
    rm   $tempFile1 $tempFile2
    return 0
}

zapKnownHostLine $@

