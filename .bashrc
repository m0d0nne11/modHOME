unset isLinux ; if uname -a | fgrep -qi -e linux ; then export isLinux="isLinux" ; fi

function bashRCfunc()  {
    local d
    local f
    local t

    # For all pre-packaged instances of modHOME init files,
    # prefer to execute the localized .custom version if present...
    #
    if pushd "$modHOME"/.BASHRClib > /dev/null 2>&1 ; then
        for t in ENVARphase0 ENVARphase1 ALIAS FUNCTION COMMAND ; do
            if [ -d "${t}" ] ; then
                for f in $(find "${t}" -xdev -type f ) ; do
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

    # ...then for all .custom init scripts, if there's also a pre-packaged
    # version we assume we've already executed this .custom version.
    #
    if pushd "$modHOME".custom/.BASHRClib > /dev/null 2>&1 ; then
        for t in ENVARphase0 ENVARphase1 ALIAS FUNCTION COMMAND ; do
            if [ -d "${t}" ] ; then
                for f in $(find "${t}" -xdev -type f ) ; do
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

