#!/bin/bash
# Some very precious person decided to lard the output from
# the MacOSX md5 utility with lots of extra glop that makes
# it difficult to use in further parsing/processing steps.
# In particular, the presence of parentheses, equals signs
# and "MD5" qualify as noise while positioning the filenames
# (with their highly variable layouts/formats) early in the
# string (ahead of invariant stuff like the MD5 hash itself)
# unnecessarily increases the complexity of the parsing task.
# Here we attempt to rewrite the output layout to match that
# of the Gnu/Linux md5sum tool...
#  
# The intent is to convert stuff like this:
#    MD5 (/my Annoyingly/formatted( file % name)/don't forget this part!)  d41d8cd98f00b204e9800998ecf8427e
# ...into this:
#    d41d8cd98f00b204e9800998ecf8427e /my Annoyingly/formatted( file % name)/don't forget this part!
#    

if uname -a | grep -qi -e linux ; then
    echo "WARNING: intended to run against the MacOSX md5 program"
    echo "         but you appear to be in a Linux system..."
fi
     
md5 "$@" | sed -e 's/^MD5 (\(..*\)) = \(..*$\)/\2 \1/'

