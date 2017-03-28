#!/bin/bash

# ASSUME: stdin is the cut'n'pasted data from a MacOSX Excel spreadsheet.
#
# Prepare the data such that blank cells have a single (dash or
# underscore) in them so that "lineup" will do the right thing,
# and also replace all Space chars with (dashes or underscores)
# to keep cell contents containing spaces from confusing "lineup"
# into thinking they're multiple cells.
#

# This is the DASH version:
#
sed -e 's/^	/-	/g' \
    -e 's/	(blank)	/	-	/g' \
    -e 's/	(blank)	/	-	/g' \
    -e 's/	(blank)$/	-/g' \
    -e 's/		/	-	/g' \
    -e 's/		/	-	/g' \
    -e 's/ /-/g' | lineup

exit

# This is the UNDERSCORE version:
#
sed -e 's/^	/_	/g' \
    -e 's/	(blank)	/	_	/g' \
    -e 's/	(blank)	/	_	/g' \
    -e 's/	(blank)$/	_/g' \
    -e 's/		/	_	/g' \
    -e 's/		/	_	/g' \
    -e 's/ /_/g' | lineup

exit

