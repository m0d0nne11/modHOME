#!/usr/bin/perl

# 20240128_XXX_MIKE_OBTAINED_FROM_CHAT_GPT:
# I see the following in some perl code and I wonder how it works:
#      ($a, $b, $c, $d) = unpack("NCC C90", myFile);
#
# ChatGPT:
#
# The line of Perl code you provided uses the unpack function to extract
# values from a binary string.  Let's break down the components of the
# unpack function:
#
# ($a, $b, $c, $d) = unpack("NCC C90", myFile); #
#     myFile:
# 	This appears to be a file handle or a file descriptor.
# 	It represents the file from which the data will be read.  #
#     unpack:
# 	This function is used to extract values from a binary string
# 	based on a specified format.  It takes two arguments: the format
# 	and the string to unpack.  #
#     "NCC
# 	C90": This is the format string that specifies how to interpret
# 	the binary data.  Let's break it down: #
#         N:
# 	This represents an unsigned long in network order (typically
# 	32 bits).  It will extract the first 4 bytes from the binary
# 	string and assign them to the variable $a.  #
#         CC:
# 	These represent two unsigned characters (typically 8 bits each).
# 	They will extract the next two bytes from the binary string and
# 	assign them to the variables $b and $c.  #
#         C90:
# 	This represents 90 unsigned characters.  It will extract the
# 	next 90 bytes from the binary string and assign them to the
# 	variable $d.
#
# In summary, the unpack function is reading data from the file specified
# by myFile and interpreting it based on the provided format string.
# The extracted values are then assigned to the variables $a, $b, $c,
# and $d.  The format string specifies how many bytes and how the bytes
# should be interpreted for each variable.
#
# END_CHAT_GPT

# Why does the world need another rpm2cpio?  Because the existing one
# won't build unless you have half a ton of things that aren't really
# required for it, since it uses the same library used to extract RPMs.
# In particular, it won't build on the HPsUX box I'm on.

#
# Expanded quick-reference help by Rick Moen (not the original author
# of this script).
#

# add a path if desired
$gzip = "gzip";

sub printhelp {
  print "\n";
  print "rpm2cpio, perl version by orabidoo <odar\@pobox.com>\n";
  print "\n";
  print "use: rpm2cpio [file.rpm]\n";
  print "dumps the contents to stdout as a GNU cpio archive\n";
  print "\n";
  print "In case it's non-obvious, you'll need to redirect output\n";
  print "from this script, e.g., './rpm2cpio package.rpm > package.cpio'.\n";
  print "Then, unpack in, say, /tmp with a cpio incantation like this one:\n";
  print "'cpio -ivd < package.cpio'\n";
  print "\n";
  print "You can optionally combine both steps:\n";
  print "'rpm2cpio package.rpm | cpio -iduv'\n";
  print "\n";
  print "In either event, you will also need the 'cpio' utility available\n";
  print "on your system.  If you can't find it elsewhere, source code for\n";
  print "GNU cpio is always available at ftp://ftp.gnu.org/gnu/cpio/.)\n";
  print "You'll also, of course, need Perl, and will want this Perl script\n";
  print "set as executable, i.e., by doing 'chmod 775 rpm2cpio'\n";
  print "\n";
  print "Be aware that this script works ONLY on version 3-format RPM\n";
  print "archives.  You can check an archive's RPM-format version using\n";
  print "the Unix 'file' utility.  Also, be aware that the 'cpio'\n";
  print "incantations above will unpack files at the current directory\n";
  print "level.\n";
  print "\n";

  exit 0;
}

if ($#ARGV == -1) {
  printhelp if -t STDIN;
  $f = "STDIN";
} elsif ($#ARGV == 0) {
  open(F, "< $ARGV[0]") or die "Can't read file $ARGV[0]\n";
  $f = 'F';
} else {
  printhelp;
}

printhelp if -t STDOUT;

# gobble the file up
undef $/;
$|=1;
$rpm = <$f>;
close ($f);

($magic, $major, $minor, $crap) = unpack("NCC C90", $rpm);

die "Not an RPM\n" if $magic != 0xedabeedb;
die "Not a version 3 RPM\n" if $major != 3;

$rpm = substr($rpm, 96);

while ($rpm ne '') {
  $rpm =~ s/^\c@*//s;
  ($magic, $crap, $sections, $bytes) = unpack("N4", $rpm);
  $smagic = unpack("n", $rpm);
  last if $smagic eq 0x1f8b;
  die "Error: header not recognized\n" if $magic != 0x8eade801;
  $rpm = substr($rpm, 16*(1+$sections) + $bytes);
}

die "bogus RPM\n" if $rpm eq '';

open(ZCAT, "|gzip -cd") || die "can't pipe to gzip\n";
print STDERR "CPIO archive found!\n";

print ZCAT $rpm;
close ZCAT;

