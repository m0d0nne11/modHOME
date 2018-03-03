# hashBang line disabled to accommodate Termux's nonstandard filesystem layout...
#!/bin/bash

function showSymlinkChainFor()  {
    if ! [ -L "$1"  ] ; then
        echo    "$1"
    else
        echo -n "$1 -> "
        showSymlinkChainFor $(dirname "$1")/$(readlink "$1")
    fi
}

if ! bin=$(type $1 | fmt -1 | tail -1) 2> /dev/null ; then
    echo "Can't find $1 ?"
    exit 1
fi

for l in $(ldd $bin | fmt -1 | fgrep /) ; do
    showSymlinkChainFor $l
done

