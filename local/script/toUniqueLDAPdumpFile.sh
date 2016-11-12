tempFile=/tmp/LDAPtemp$$.$(tds)
sed -e '/^$/d' > "${tempFile}"
name="$(head -1 < "${tempFile}" | sed -e 's/, MIT_LINCOLN_LABORATORY.*$//' -e 's/\\2C/,/' -e 's/\\20/ /g' -e 's/^# *//' -e 's/ //g')"
if ! [ -e "${name}" ] ; then
    echo MOVE "${tempFile}" "${name}"
    mv        "${tempFile}" "${name}"
else
    echo HAVE               "${name}"
fi

rm -f "${tempFile}"
