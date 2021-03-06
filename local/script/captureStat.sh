# hashBang line disabled to accommodate Termux's nonstandard filesystem layout...
#!/bin/bash

stat --printf="\
%n\n\
 STAT_u='%u'\
 STAT_U='%U'\
 STAT_g='%g'\
 STAT_G='%G'\
 STAT_a='%a'\
 STAT_A='%A'\
 STAT_s='%s'\
 STAT_F='%F'\
\n" "$@"

exit

STAT_b='%b' \
STAT_B='%B' \
STAT_C='%C' \
STAT_d='%d' \
STAT_D='%D' \
STAT_f='%f' \
STAT_h='%h' \
STAT_i='%i' \
STAT_m='%m' \
STAT_N='%N' \
STAT_o='%o' \
STAT_t='%t' \
STAT_T='%T' \
STAT_w='%w' \
STAT_W='%W' \
STAT_x='%x' \
STAT_X='%X' \
STAT_y='%y' \
STAT_Y='%Y' \
STAT_z='%z' \
STAT_Z='%Z'" $@

exit

#!/bin/bash

# verifyStat.sh

while : ; do
    read  f || break ;
    echo FILE:"${f}" ;
    read s1 || break ;
    read s2 < <(captureStat.sh "${f}" | sed 1d) ;
    if [ "${s1}" != "${s2}" ] ; then
        echo " #### FAIL:"
        echo "      OLD:${s1}"
        echo "      NEW:${s2}"
    fi
done

exit

#STAT(1)                            User Commands                      STAT(1)
#
#NAME
#       stat - display file or file system status
#
#SYNOPSIS
#       stat [OPTION]... FILE...
#
#DESCRIPTION
#       Display file or file system status.
#
#       -L, --dereference
#              follow links
#
#       -f, --file-system
#              display file system status instead of file status
#
#       -c  --format=FORMAT
#              use the specified FORMAT instead of the default; output a newline after each use of FORMAT
#
#       --printf=FORMAT
#              like --format, but interpret backslash escapes, and do not output a mandatory trailing newline.  If you want a newline, include \n in FORMAT
#
#       -t, --terse
#              print the information in terse form
#
#       --help display this help and exit
#
#       --version
#              output version information and exit
#
#       The valid format sequences for files (without --file-system):
#
#       %a     Access rights in octal
#
#       %A     Access rights in human readable form
#
#       %b     Number of blocks allocated (see %B)
#
#       %B     The size in bytes of each block reported by %b
#
#       %C     SELinux security context string
#
#       %d     Device number in decimal
#
#       %D     Device number in hex
#
#       %f     Raw mode in hex
#
#       %F     File type
#
#       %g     Group ID of owner
#
#       %G     Group name of owner
#
#       %h     Number of hard links
#
#       %i     Inode number
#
#       %m     Mount point
#
#       %n     File name
#
#       %N     Quoted file name with dereference if symbolic link
#
#       %o     I/O block size
#
#       %s     Total size, in bytes
#
#       %t     Major device type in hex
#
#       %T     Minor device type in hex
#
#       %u     User ID of owner
#
#       %U     User name of owner
#
#       %w     Time of file birth, human-readable; - if unknown
#
#       %W     Time of file birth, seconds since Epoch; 0 if unknown
#
#       %x     Time of last access, human-readable
#
#       %X     Time of last access, seconds since Epoch
#
#       %y     Time of last modification, human-readable
#
#       %Y     Time of last modification, seconds since Epoch
#
#       %z     Time of last change, human-readable
#
#       %Z     Time of last change, seconds since Epoch
#
#       Valid format sequences for file systems:
#
#       %a     Free blocks available to non-superuser
#
#       %b     Total data blocks in file system
#
#       %c     Total file nodes in file system
#
#       %d     Free file nodes in file system
#
#       %f     Free blocks in file system
#
#       %i     File System ID in hex
#
#       %l     Maximum length of filenames
#
#       %n     File name
#
#       %s     Block size (for faster transfers)
#
#       %S     Fundamental block size (for block counts)
#
#       %t     Type in hex
#
#       %T     Type in human readable form
#
#       NOTE: your shell may have its own version of stat, which usually supersedes the version described here.  Please refer to your shell's documentation for details about the options it supports.
#
#AUTHOR
#       Written by Michael Meskes.
#
#REPORTING BUGS
#       Report stat bugs to bug-coreutils@gnu.org
#       GNU coreutils home page: <http://www.gnu.org/software/coreutils/>
#       General help using GNU software: <http://www.gnu.org/gethelp/>
#       Report stat translation bugs to <http://translationproject.org/team/>
#
#COPYRIGHT
#       Copyright © 2011 Free Software Foundation, Inc.  License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>.
#       This is free software: you are free to change and redistribute it.  There is NO WARRANTY, to the extent permitted by law.
#
#SEE ALSO
#       stat(2)
#
#       The full documentation for stat is maintained as a Texinfo manual.  If the info and stat programs are properly installed at your site, the command
#
#              info coreutils 'stat invocation'
#
#       should give you access to the complete manual.
#
#GNU coreutils 8.12.197-032bb       September 2011                     STAT(1)

