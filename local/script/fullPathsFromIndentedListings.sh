#!/bin/bash
#
# Given explicit pathnames of the form /a/b/c/d we are sometimes
# instead presented with "prettified" listings of file hierarchies
# that use indentation to represent the tree structure.
#
# We can recreate the explicit pathnames in a two-phase process:
#
#    Recognize the nesting level being represented by each line in the
#    indented listing.
#
#    Utter the reconstructed path by mentioning all nodes we've seen so
#    far up to that level.

# An experimental Bash script that was used to capture the indentation
# information early in development before switching to AWK:
# 
# declare -a pathComp=("") ;
# while read l ; do
#     level=$(   echo "${l}" | sed -e 's/ .*$//') ;
#     nodeName=$(echo "${l}" | sed -r -e 's/^[[:digit:]]+ //') ;
#     pathComp[$level]="${nodeName}" ;
#     i=0 ;
#     while [ $i -le $level ] ; do
#         echo -n "${pathComp[$i]}"/ ;
#         let i++ ;
#     done ;
#     echo "" ;
# done
# 

# Strip the CSV (comma separated values) stuff from an indented list
# and then reconstruct the original explicit pathnames.

# AWK_OPTIONS="--characters-as-bytes"
  TABWIDTH=5

awk ${AWK_OPTIONS} '
BEGIN {
    tabWidth = '${TABWIDTH}';
};

{
    sub( "^\"", "" );                 # Strip leading CSV doubleQuote and...
    sub( "\".*$", "" );               # everything after remaining doubleQuote.

    s = $0;                           # Snapshot for indentation computation,
    sub( "[^[:space:]].*$", "", s );  # only preserving leading whitespace.
    i = length( s ) / tabWidth;

    sub( "^[[:space:]]*", "" );       # Toss indentation before remembering
    pathComp[i] = $0;                 # this pathname component.

    for( level=0; level <= i;  level++ ) {
        if( level > 0 ) {
            printf( "/%s", pathComp[level] );
        } else {
            printf( "%s",  pathComp[level] );
        }
    }
    printf( "\n" );
}
'

