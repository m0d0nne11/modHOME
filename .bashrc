unset isLinux ; if uname -a | fgrep -qi -e linux ; then export isLinux="isLinux" ; fi

function bashRCfunc()  {
    local d
    local f
    local t
    for d in $modHOME/.BASHRClib "$modHOME".custom/.BASHRClib ; do
        if pushd "${d}" > /dev/null 2>&1 ; then 
            for t in ALIAS ENVARphase0 ENVARphase1 FUNCTION COMMAND ; do
                if [ -d "${t}" ] ; then
                    for f in $(find "${t}" -type f ) ; do
                        . "${f}"
                    done
                fi
            done
            popd >/dev/null
        fi
    done
}

bashRCfunc > /dev/null
