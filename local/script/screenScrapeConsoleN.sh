# console{Dev,Width,Height} can all be
# overridden from environment or commandline.
# Current defaults: /dev/vcs1,80,24
# 
l=0
while [ $l -lt ${consoleHeight:-24} ] ; do
    dd if=${consoleDev:-/dev/vcs1} bs=${consoleWidth:-80} \
       skip=$l count=1 2>/dev/null | strings
    let l++
done

