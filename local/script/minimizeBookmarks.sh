
function isMacOSfunc() { uname -a | fgrep -q -e Darwin ; }

if isMacOSfunc ; then
	sed	-E					\
		-e 's/FOLDED ADD_DATE/ADD_DATE/g'	\
		-e 's/ (ICON|ICON_URI|ID|ADD_DATE|LAST_CHARSET|LAST_VISIT|LAST_MODIFIED)="[^"]*"/ /g'	\
		-e 's/  *>/ >/g'
else
	sed						\
		-e 's/FOLDED ADD_DATE/ADD_DATE/g'	\
		-e 's/ \(ICON\|ICON_URI\|ID\|ADD_DATE\|LAST_CHARSET\|LAST_VISIT\|LAST_MODIFIED\)="[^"]*"/ /g'	\
		-e 's/  *>/ >/g'
fi
