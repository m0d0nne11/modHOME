unset isLinux ; if uname -a | fgrep -qi -e linux ; then export isLinux="isLinux" ; fi

function bashRCfunc()  {
    local d
    local f
    local t

    # For all pre-packaged instances of modHOME init files,
    # prefer to execute the localized version if present...
    #
    if pushd "$modHOME"/.BASHRClib > /dev/null 2>&1 ; then
        for t in ALIAS ENVARphase0 ENVARphase1 FUNCTION COMMAND ; do
            if [ -d "${t}" ] ; then
                for f in $(find "${t}" -type f ) ; do
                    if [ -r "$modHOME".custom/.BASHRClib/"${f}" ] ; then
                        .   "$modHOME".custom/.BASHRClib/"${f}"
                    else
                        .                                "${f}"
                    fi
                done
            fi
        done
        popd >/dev/null
    fi

    # ...then assume we only need to execute files which are not
    # localized instances of the pre-packaged versions.
    #
    if pushd "$modHOME".custom/.BASHRClib > /dev/null 2>&1 ; then
        for t in ALIAS ENVARphase0 ENVARphase1 FUNCTION COMMAND ; do
            if [ -d "${t}" ] ; then
                for f in $(find "${t}" -type f ) ; do
                    if ! [ -r "$modHOME"/.BASHRClib/"${f}" ] ; then
                        . "${f}"
                    fi
                done
            fi
        done
        popd >/dev/null
    fi
}

bashRCfunc > /dev/null

