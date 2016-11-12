#!/bin/bash

# ASSUME: stdin is the cut'n'pasted data from a MacOSX Excel spreadsheet.
#
# Prepare the data such that blank cells have a single dash in them
# so that "lineup" will do the right thing, and also replace all Space
# chars with underscores to keep cell contents containing spaces from
# confusing "lineup" into thinking they're multiple cells.
#

sed -e 's/^	/-	/g' \
    -e 's/	(blank)	/	-	/g' \
    -e 's/	(blank)	/	-	/g' \
    -e 's/	(blank)$/	-/g' \
    -e 's/		/	-	/g' \
    -e 's/		/	-	/g' \
    -e 's/ /-/g' | lineup

