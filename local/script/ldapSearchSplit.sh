# hashBang line disabled to accommodate Termux's nonstandard filesystem layout...
#!/bin/bash

unset fileName
unset lastLine

sed -e 's/^ /RZQ /' | while read -r l ; do

    if echo "${l}" | grep -q -e '^RZQ ' ; then
#echo CONTINUATION
        lastLine="${lastLine}"$(echo "${l}" | sed -e 's/^RZQ //')
        continue
    fi

    if ! [ "${l}" ] ; then
#echo EMPTY
        [ "${lastLine}" ] && echo "${lastLine}" >>"${fileName}"
        lastLine="${l}"
        continue
    fi

    if echo "${l}" | grep -q -e '^#' ; then
#echo COMMENT
        [ "${lastLine}" ] && echo "${lastLine}" >>"${fileName}"
        unset lastLine
        continue
    fi

    if echo "${l}" | grep -q -e '^dn:' ; then
#echo NEWNAME
        [ "${lastLine}" ] && echo "${lastLine}" >>"${fileName}"
        lastLine="${l}"
        fileName=$(echo "${l}" | sed -e 's/^dn: cn=//' -e 's/,o=.*$//' -e 's/\\//g' -e 's/  *//g')
        continue
    fi

    [ "${lastLine}" ] && echo "${lastLine}" >>"${fileName}"
    lastLine="${l}"

done

[ "${lastLine}" ] && echo "${lastLine}" >>"${fileName}"

exit

# Hints for further crunching the results...

for f in * ; do echo "${f}" $(grep -e '^uid:' -e '^mail:' -e '^roomNumber:' -e '^telephoneNumber:' -e '^mobile:' < "${f}" | sort) ; done

for f in * ; do echo "${f}"                                                         \
    UID:$(grep    -e '^uid:'             < "${f}" | sed -e 's/^uid://')             \
    MAIL:$(grep   -e '^mail:'            < "${f}" | sed -e 's/^mail://')            \
    GROUP:$(grep  -e '^profitCenter:'    < "${f}" | sed -e 's/^profitCenter://')    \
    ROOM:$(grep   -e '^roomNumber:'      < "${f}" | sed -e 's/^roomNumber://')      \
    PHONE:$(grep  -e '^telephoneNumber:' < "${f}" | sed -e 's/^telephoneNumber://') \
    MOBILE:$(grep -e '^mobile:'          < "${f}" | sed -e 's/^mobile://')          \
    TITLE:$(grep  -e '^title:'           < "${f}" | sed -e 's/^title://')           ;
done

