# hashBang line disabled to accommodate Termux's nonstandard filesystem layout...
#!/bin/bash
#
# Compare the output of two dpkg -l runs, showing only the basic package
# names and omitting stuff like version, platform and descriptive info.
#

L=$1
R=$2

function lineupSDIFFhits()  {
	fgrep -e '<' -e '>' -e '|' | expand | sed -e 's/^ /sPaCe /' | column -t | sed -e 's/\([^ ]\)  /\1 /g' | sed -e 's/^sPaCe/     /'
}

function liveListEntriesInDPKG-Loutput() {
	sed -E -e 's/^[[:space:]]+//' | grep -E -e '^ii[[:space:]]+' | sed -E -e 's/^ii[[:space:]]+//' -e 's/[[:space:]].*$//' | sort -bfd
}

echo '##########' "${L}" versus "${R}"

sdiff <(liveListEntriesInDPKG-Loutput < "${L}") <(liveListEntriesInDPKG-Loutput < "${R}") | lineupSDIFFhits

