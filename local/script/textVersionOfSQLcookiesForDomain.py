#!/usr/bin/python
# Extract cookies.txt-like file from FF3 sqlite3 cookies file.  e.g.:
#  cookies-sql2txt ~/.mozilla/*/cookies.sqlite launchpad
#
# Copyright 2008 Kees Cook <kees@outflux.net>
# License: GPLv2
import sys
from pysqlite2 import dbapi2 as sqlite

def usage():
    print >>sys.stderr, "Usage: %s SQLITE3DB DOMAIN"
    sys.exit(1)

try:
    filename = sys.argv[1]
    match = '%%%s%%' % sys.argv[2]
except:
    usage()

con = sqlite.connect(filename)

cur = con.cursor()
cur.execute("select host, path, isSecure, expiry, name, value from moz_cookies where host like ?", [match])

ftstr = ["FALSE","TRUE"]

print '# HTTP Cookie File'
for item in cur.fetchall():
    print "%s\t%s\t%s\t%s\t%s\t%s\t%s" % (
        item[0], ftstr[item[0].startswith('.')], item[1],
        ftstr[item[2]], item[3], item[4], item[5])

# 20110811 http://hackerstv.blogspot.com/2008/07/convert-firefox-3-cookiessqlite-to.html
#
# If you want to convert firefox 3's cookies from the new extension .sqlite to old readable format .txt file, you have to follow those simple steps:
#
# 1) Download this [ http://launchpadlibrarian.net/12045790/cookies-sql2txt ] script written in python
#
# 2) Download ActiveState Python 2.5.2.2 for you OS and install it.
#
# 3) Download and install pysqlite module
#
# 3) Launch from your shell or command's prompt having your basedir where you downloaded cookies-sql2txt file:
#
# cookies-sql2txt ~/.mozilla/*/cookies.sqlite DomainName >> out.txt
#
# Domain name will be the domain that you looked for.
#
# Instead, the command ">> 0ut.txt" writes all results in a out.txt file.

