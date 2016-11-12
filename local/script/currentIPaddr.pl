#!/usr/bin/perl -w

# Date: Fri, 17 Mar 2006 13:08:52 -0500
# From: kclark@mtghouse.com (Kevin D. Clark)
# Subject: get-extern-ip-addr.pl currentIPadd.pl
# To: GNHLUG Discussion <gnhlug-discuss@mail.gnhlug.org>
#
# A little hack that I wrote to help a colleague keep track of how
# often his broadband IP changes.  I thought others might find this to
# be useful too.
#
# Regards,
#  --kevin
# GnuPG ID: B280F24E                  And the madness of the crowd
# alumni.unh.edu!kdc                  Is an epileptic fit -- Tom Waits

# A little program that you can use to keep track of how often your
# broadband IP changes.  This should work through things like NAT boxen, etc.

# author: kevin d. clark (alumni.unh.edu!kdc)

# Usage suggestion: create a crontab for this thusly
#
# 5 0 * * *       $HOME/bin/get-extern-ip-addr.pl >> $HOME/extern-ip
#
# Note:  Think carefully about how often you run this program.
#        You're going to be using somebody else's web-server here; it is
#        anti-social to hog bandwidth/cputime.

use strict;
use LWP::Simple;

# Here is the part that you need to change in order to use this program.
# It is common in CGI tutorials to include a little program that simply
# dumps out each environment variable.  A common name for this program is
# "cgi.pl".  You need to find a webserver that is running such a program
# and modify the URL in the next line to point at that.  If you can't find
# such a server, then this program probably isn't for you.

my $env_pl = "http://localhost/cgi-bin/env.pl";  # MODIFY THIS!!!!


my $quad_re = qr/([01]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])/;
my $dotted_quad_re = qr/\b($quad_re\.){3}$quad_re\b/;

my $content = get($env_pl);
die "Couldn't get remote webpage." unless defined $content;

# $remote_addr is the address that the remote webserver thinks that
# we are at
my ($remote_addr) = $content =~ /remote_addr.*($dotted_quad_re)/i;

die "Problem fetching remote addr!\n" if (! defined($remote_addr));

my $date = `date`;  chomp $date;
print "$remote_addr\t$date\n";

