# hashBang line disabled to accommodate Termux's nonstandard filesystem layout...
#!/bin/bash

# ASSUME: alternating lines, filename then attributes...
# See captureStat.sh

errorFile=/tmp/statVerify$$

while read f ; do
    read s1 || break ;
    if ! read s2 < <(captureStat.sh "${f}" 2> $errorFile | sed 1d) ; then
        echo " #### FAIL: ${f}"
        echo "      OLD: ${s1}"
        echo "     " $(cat $errorFile)
        rm -f              $errorFile
    elif [ "${s1}" != "${s2}" ] ; then
        echo " #### FAIL: ${f}"
        echo "      OLD: ${s1}"
        echo "      NEW: ${s2}"
    else 
        :
#       echo " #### PASS: ${s1}" # To-Do: add getopt control
    fi
done

exit

