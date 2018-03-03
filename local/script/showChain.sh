# hashBang line disabled to accommodate Termux's nonstandard filesystem layout...
#!/bin/bash

# set -x

startDir=$PWD
#append="\n\t"
append=" => "

for f in $@ ; do
	chain="${f}"

	if [ -L "${f}" ] ; then
	        while [ -L "${f}" ] ; do
	                d1="$(dirname "${f}")"
	                cd "${d1}"
	                l="$(readlink "${f}")"
	                d2="$(cd $(dirname "${l}") ; echo $PWD)"
	                f="${d2}/$(basename ${l})"
	                chain="${chain}${append}${f}"
	                cd "${d2}"
	        done
	fi

	echo -e "${chain}"
done
