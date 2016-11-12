cat <<"EndOfShellSkell"

# To maintain the following list of functions, position (in vi) the cursor on
# the first line in the list and then execute one of the following verbatim:
#
# !}grep -e '^function ' % | awk '{ print $2 }' | sort -bfd | sed -e 's/^/\# /'
# !}grep -e '^function ' % | awk '{ print $2 }' |             sed -e 's/^/\# /'
# FUNCTIONS:

############## SCRIPT ./1letterPerLine
sed -e 's/\(.\)/\
\1/g'

############## SCRIPT ./anna
 fromHack | sed -e 's/^[Tt][Oo]:[	 ].*$/To: AnnaBracken@aol.com/'

############## SCRIPT ./autoInc
echo HEY - just say '"inc"'...
exit 1

#banner autoinc running >/dev/ttyp6
#ps -j -a -x -Oc        >/dev/ttyp6

date
time expect <<EOF
#
# Send 1 char at a time, 100 millis apart
#
set send_slow {1 0.1}
#spawn /usr/bin/mh/inc -host world.std.com -norpop
 spawn /usr/bin/mh/inc -host pop.ne.mediaone.net -norpop
#expect "Password (world.std.com:mod): "
expect "Password (pop.ne.mediaone.net:mod):"
#
# Sleep to allow the terminal settings to
# be changed to avoid echoing the password...
#
sleep 2
#send -s w1rld1\r
send -s HSD9086\r
set timeout -1
expect eof
EOF

############## SCRIPT ./AWK/calcFormatString.awk
BEGIN  {
    mostFields = 0
}

{
    if( NF > mostFields )  {
        mostFields = NF
    }
    for( i = 1;  i <= NF;  ++i )  {
        width = length( $i );
        if( width > widest[ i ] )  {
            widest[ i ] = width;
        }
    }
}

END  {
    if( mostFields > 0 )  {
        printf( "{ printf( \"%%%ds", widest[ 1 ] );

        if( mostFields > 1 )  {
            for( i = 2;  i <= mostFields;  ++i )  {
                printf( " %%%ds", widest[ i ] );
            }
        }
        printf( "\\n\"" );
        for( i = 1;  i <= mostFields;  ++i )  {
            printf( ", $%d", i );
        }
        printf( " ); }\n" );
    }
}

############## SCRIPT ./AWK/splitNotes
BEGIN  {
    outFile = /dev/null
};

/^########NOTE######## [0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]$/  {
    outFile = $2
};

/./  {
    print >> outFile
};

############## SCRIPT ./base64decode
# Decode a "base64" stream

awk '/./ {
	s = s $0
	while (length(s) >= 4) {
		print substr(s, 1, 4)
		s = substr(s, 5)
	}
}' $@ |
awk 'BEGIN {
	alph = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
	alph = alph "0123456789+/"
	for (i = 1; i <= length(alph); i++)
		value[substr(alph, i, 1)] = i - 1;
}
{
	v1 = value[substr($0, 1, 1)]
	v2 = value[substr($0, 2, 1)]
	v3 = value[substr($0, 3, 1)]
	v4 = value[substr($0, 4, 1)]
	o1 = v1*4 + int(v2/16)
	o2 = (v2%16)*16 + int(v3/4)
	o3 = (v3%4)*64 + v4
	printf "%c%c%c", o1, o2, o3
}' | tr -d '\015'

############## SCRIPT ./bc++cmnt
echo '//'
rq '// '
echo '//'

############## SCRIPT ./bccmnt
echo "/*"
detab | awk '{ printf( " * %s\n", $0 ); }'
echo " */"

############## SCRIPT ./bccmnti
if [ "$#" -ge 1 ]
then
    indent=$[$1 * 4]
else
    indent=4
fi

spaceString=""
while [ "$indent" -gt 0 ]
do
    spaceString=$spaceString" "
    indent=$[$indent - 1]
done

bccmnt | rq "$spaceString"

############## SCRIPT ./bc++cmntl
( \
  echo "----------------------------------------------------------------------------" ;\
  cat ) | bc++cmnt

############## SCRIPT ./bccmntl
( \
  echo "----------------------------------------------------------------------------" ;\
  cat ) | bccmnt

############## SCRIPT ./blu
fromHack | sed -e '/^To:/s/^.*$/To: discuss@blu.org/' -e '/^cc:/d' -e 's/mod@std.com/mod+blu@std.com/'

############## SCRIPT ./c++2ccmnt
sed -f ~/local/script/SED/c++2ccmnt.sed

############## SCRIPT ./caitlin
#fromHack | sed -e 's/^[Tt][Oo]:[	 ].*$/To: acr416@aol.com/'
 fromHack | sed -e 's/^[Tt][Oo]:[	 ].*$/To: Caitlin <acroh@cox.net>/'

############## SCRIPT ./calScript
YEAR=`date '+%Y'`
for f in 01 02 03 04 05 06 07 08 09 10 11 12
do
    cal $f $YEAR                \
    | eat                       \
    | fmt -1                    \
    | sed -e 1,9d               \
          -e 's/ //g'           \
          -e '/^[0-9]$/s/^/0/'  \
          -e '/^$/d'            \
    | rq $YEAR$f
done

############## SCRIPT ./carly
#fromHack | sed -e 's/^[Tt][Oo]:[	 ].*$/To: roh214@aol.com/'
 fromHack | sed -e 's/^[Tt][Oo]:[	 ].*$/To: Carly Rohrbacher <cakarksky@yahoo.com>/'

############## SCRIPT ./catAll
echo "######################################################################"
echo "######## This concatenated file generated "`date`
echo "######################################################################"
for f in $@
do
    echo "######## BEGIN $f"
    echo "##################################################################"
    cat $f
    echo "##################################################################"
    echo "########## END $f"
    echo "##################################################################"
done

############## SCRIPT ./catMail
#!/bin/csh -f
set rzq=" "
foreach f ( $argv )
        if ( X$rzq == "X " ) then
                set rzq=$f
        else
                banner next >>$rzq
                cat $f      >>$rzq
                rm $f
        endif
end

############## SCRIPT ./c++cmnt
detab | rq '// '

############## SCRIPT ./ccmnt
detab | awk '{ printf( "/* %s */\n", $0 ); }'

############## SCRIPT ./CCURformat
#! /bin/sh
# @(#)format	9.3 MASSCOMP (LOCAL) 5/10/90
# ex: se ts=5 :
if [ $debug ]; then
	# setting -x causes output to go into $err, triggering calls to geterror()
	# this needs to be fixed
	echo format: WARNING: setting debug true causes fatal error in geterror
	set -x
fi
PATH="/bin:/usr/bin:/usr/local:/usr/lib/format/bin"; export PATH
pid=$$; export pid
BIN=/usr/lib/format/bin
TMPDIR=/usr/lib/format/tmp
LOGDIR=/usr/lib/format/logfiles
tmp1=${TMPDIR}/fxxx1.$pid
tmp2=${TMPDIR}/fxxx2.$pid
logfile=${LOGDIR}/$LOGNAME.$pid
keywordfile=${TMPDIR}/fkywdf.$pid
err=${TMPDIR}/ferrxxx.$pid
inx=${TMPDIR}/inx$pid
toc=${TMPDIR}/\[tg\]\[HFET\].\*$pid
# Following line to be deleted as soon as cT refs are removed from macros
# cT=${TMPDIR}/cT.$$
# Following files used in macros. Reference here is solely so that we
# can delete the file with "trap" in case the format job is aborted
gptr=${TMPDIR}/gptr$pid
figsz=${TMPDIR}/Pf.size.$pid

roff="troff"; ditdev="-Timp"; options="-rf1 -r#$$ -rt1"
sed="|sed -f /usr/lib/format/macros/sed.t"
cat="cat"; macros="/usr/lib/tmac/tmac.S"

# nullify some macros we don't want to find in our environment from
# extraneous sources
dbg=
eqn=
pic=
files=
index=
noscan=
tbl=
throwaway=
tocsrc=
toconly=
globaltoconly=
yadc=

trap "rm -f $tmp1 $tmp2 $err $inx $toc $gptr $keywordfile $figsz; trap '' 0; exit" 0 1 2 3 15

echo "######################################################" > $logfile
date >> $logfile
chmod +w $logfile
pwd >> $logfile
echo "Command line: $0 $@" >> $logfile
echo "######################################################" >> $logfile

#########################################################################
# error handler
#########################################################################
geterror() {
if [ -s "$err" ]; then
	if [ "$1" = "fatal" ]; then
		echo "format: fatal error:" 1>&2
	fi
	cat $err | tee -a $logfile 1>&2
	rm -f $err
	[ "$1" = "fatal" ] && exit
fi
}

#########################################################################
# Read arguments.  This procedure gets executed immediately after its
# definition, and again after the pre-scanning of the input if
# "FormatArgs" have been defined.  Thus, FormatArgs take precedence over
# command-line arguments.  The only way to override this precedence is
# to use the -n (noscan) command-line argument.  Then the user must
# explicitly specify yadc, tbl, eqn, and so on, as necessary.
#########################################################################
readargs() {
	while [ "$#" != "0" ]; do
	   case $1 in
		-m*)	macsuffix=`expr "$1" : "..\(.*\)"`
			[ "$macsuffix" ] && macros="/usr/lib/tmac/tmac.$macsuffix"
			sed="";;
		-dps*|-ps|-qms2b)
			ditdev="-Tdps"
			picopts="-T720"
			eqnopts="-Taps -r720 -m3";;
		-psc*|-tps|-qms1|-qms2a)
			ditdev="-Tpsc"
			picopts="-T576"
			eqnopts="-Taps -r576 -m2";;
		-ips*)
			ditdev="-Tips"
			picopts="-T576"
			eqnopts="-Taps -r720 -m3";;
		-imp*|-i300|-s3|-imagen|-i2308)
			ditdev="-Timp"
			picopts="-T300"
			eqnopts="-r300 -m6";;
		-i5320*)
			echo "$0: $1 not a valid printer name" | tee -a $logfile 1>&2
			exit;;
		-t)	roff="nroff -e"
			post="| ul -i";;
		-l|-lpr)
			roff="nroff -e"; options="$options -u5"
			post="| col -bx | ul -t pnec";;
	      -p) if [ "$#" -ge "2" ]; then
				shift
		 		options="$options -rP$1"
		  	else	echo "\'-p\' flag requires separate width argument" |
				tee -a $logfile 1>&2
				exit
		  	fi;;
 		-w)	if [ "$#" -ge "2" ]; then
				shift
		 		options="$options -rW$1"
		  	else	echo "\'-w\' flag requires separate width argument" |
				tee -a $logfile 1>&2
				exit
			fi;;
# use of troff register t:
#	t=0	no toc
#	t>0	toc
#	t=2	toc source file requested from command line
#	t=3	globaltoconly but not toc source file requested from command line
#	t=4	globaltoconly and toc source file requested from command line
#	t=5	set only in mktoc, to prevent troff from removing g[HFET]* file
		-notoc)
			# number register t used by mS macros
			options="$options -rt0";;
		-tocsrc)
			tocsrc=true
			# number register t used by mS macros
			[ "$globaltoconly" ] && options="$options -rt4"
			[ ! "$globaltoconly" ] && options="$options -rt2";;
		-toconly)
			toconly=true
			throwaway="> /dev/null";;
		-globaltoconly)
			toconly=true; globaltoconly=true
			[ "$tocsrc" ] && options="$options -rt4"
			[ ! "$tocsrc" ] && options="$options -rt3"
			throwaway="> /dev/null";;
		-index)
			# number register x used by mS macros. If x != 1, index
			# macros are undefined
			index=true; options="$options -rx1";;
		-indexonly)
			index=true; options="$options -rx1"
			throwaway="> /dev/null";;
		-pic)
			pic="| pic";;
		-eqn)
			eqn="| eqn";;
		-tbl)
			tbl="| tbl";;
		-y)	yadc="yadc -mS";;
		-yopt)
			shift; yadcopts="$yadcopts $1";;
		-n)	noscan=true;;
		-nosed)
			sed="";;
		-debug)
			dbg=true;;
		-dbg)
			options="$options -rd1"
			# leave most temp files in place; for debugging
			trap "rm -f $tmp1 $tmp2; trap '' 0; exit" 0 1 2 3 15;;
		-*)	options="$options $1";;
		 *)	if [ -f $1 ]; then
				files="$files $1"
			else echo "format: $1: cannot open" | tee -a $logfile 1>&2
				exit
			fi;;
	   esac
	   shift
	done
}
readargs $@

if [ ! "$files" -a -t 0 ]; then
	echo "format: no files specified" | tee -a $logfile 1>&2
	exit
fi

[ ! -t 0 ] && stdin=true

# If we are doing debugging only...
[ "$dbg" ] && eval "cat $files | $BIN/ckroff > /dev/null; exit"

###########################################################################
# Do pre-scanning if user does not prevent it
###########################################################################
rm -f $keywordfile
if [ ! "$noscan" ]; then
	awk '
	NR == 1 && $0 ~ /^x T / {
		printf ("ditoutfile=true\n") >> "'"$keywordfile"'"
	}
	$1 ~ /^\.PS/	{ pic = 1 }
	$1 ~ /^\.EQ/	{ eqn = 1 }
	$1 ~ /^\.TS/	{ tbl = 1 }
	$0 ~ /.*\\#/	{ yadc = 1 }
	$1 ~ /^\.\\"\.ditroff_MC/ {
		ditroff_MC="true"
	}
	$1 ~ /^\.\\"\.AllFiles:/ {
		if (AFflag == 0) {
			for (i=2; i <= NF; ++i) {
				AllFiles=AllFiles $i " "
			}
			AFflag = 1
		}
	}
	$1 ~ /^\.\\"\.CurrentFile:/ {
		CurrentFiles=CurrentFiles $2 " "
		print (".ds cF " $2)
	}
	$1 ~ /^\.\\"\.FormatArgs:/ {
		if (FAflag == 0) {
			for (i=2; i <= NF; ++i) {
				FormatArgs=FormatArgs $i " "
			}
			FAflag = 1
		}
	}

	{print}

	END	{
		if (pic == 1)
			printf ("pic=\"| pic\"; export pic\n") >> "'"$keywordfile"'"
		if (eqn == 1)
			printf ("eqn=\"| eqn\"; export eqn\n") >> "'"$keywordfile"'"
		if (tbl == 1)
			printf ("tbl=\"| tbl\"; export tbl\n") >> "'"$keywordfile"'"
		if (yadc == 1) {
			printf ("yadc=\"yadc -mS\"; export yadc\n") >> "'"$keywordfile"'"
		}
		if ( ditroff_MC )
			printf ("ditroff_MC=true\n") >> "'"$keywordfile"'"
		if ( AllFiles )
			printf ("AllFiles=\"%s\"; export AllFiles\n", AllFiles) >> "'"$keywordfile"'"
		if ( CurrentFiles )
			printf ("CurrentFiles=\"%s\"; export CurrentFiles\n", CurrentFiles) >> "'"$keywordfile"'"
		if ( FormatArgs )
			printf ("FormatArgs=\"%s\"; export FormatArgs\n", FormatArgs) >> "'"$keywordfile"'"
	}
	' $files > $tmp1 2>> $logfile

	#############################################################
	# Read the keyword file. Re-process any new format arguments
	[ -r "$keywordfile" ] && . $keywordfile
	if [ "$ditoutfile" = "true" ]; then
		echo "WARNING:  You appear to be formatting a troff output file!" 1>&2
	fi
	if [ "$FormatArgs" ]; then
		set -- $FormatArgs
		readargs $@
	fi
fi

######################################################################
# If we are following the ditroff_MC convention and have yadc symbols,
# we must run all files composing the document through yadc, and then
# extract just the files the user is actually formatting.
######################################################################
if [ "$ditroff_MC" -a "$yadc" ]; then
	scr="sed -n "
	# Following tortured loop creates a sed script to extract just
	# the desired files from the concatenation of all files in the
	# document
	iterate="$files"
	# [ "$stdin" ] && iterate="$CurrentFiles"
	[ "$CurrentFiles" ] && iterate="$CurrentFiles"
	for i in $iterate; do
		if [ $debug ]; then set -x; fi
		# Might be simpler to do following with cat and 'here document'
		scr=''"$scr"' -e '"'"'/^\.\\"\.CurrentFile:[ 	][ 	]*'"$i"'[ 	]*$/,/^\.\\"\.EndOfFile/p'"'"''
	done

	eval cat $AllFiles | $yadc $yadcopts > $tmp2 2>> $err

	if [ $? != 0 ]; then
		echo "format: fatal error:" 1>&2
		cat $err | tee -a $logfile 1>&2
		exit
	fi
	if [ -s "$err" ]; then
		cat $err | tee -a $logfile 1>&2
		rm -f $err
	fi

	rm -f $tmp1
	yadc=""
	yadcopts=""

	eval $scr $tmp2 > $tmp1 2>> $err
	geterror fatal
	rm -f $tmp2
fi

if [ ! "$noscan" ]; then
	files="$tmp1"
fi

########################################################################
# Option checking
########################################################################

# The order of these commands is important
[ "$pic" ] && pic="$pic $picopts"
[ "$eqn" ] && eqn="$eqn $eqnopts"
[ "$roff" = "nroff -e" -a "$eqn" ] && eqn="| neqn"
[ "$roff" = "nroff -e" ] && tblopts="-TX" && ditdev=""
[ "$roff" = "nroff -e" ] && pic=
[ "$tbl" ] && tbl="$tbl $tblopts"
[ "$yadc" ] && cat="$yadc $yadcopts"

########################################################################
# Format the stuff
########################################################################
if [ "$noexec" = "true" ]; then
	echo "noexec:  $cat $files $sed $pic $tbl $eqn | $roff $ditdev $options $macros - $post $throwaway" | tee -a $logfile 1>&2
	exit
fi

# Pass variables along to mktoc and index
export sed roff ditdev options macros post err logfile toconly

# Following line to be deleted as soon as cT refs are removed from macros
# touch $cT

(eval "$cat $files $sed $pic $tbl $eqn | $roff $ditdev $options $macros - $post $throwaway") 2>> $err
geterror

########################################################################
# Now make the index
########################################################################

if [ "$index" = "true" ]; then
	(eval "cat $inx | /usr/lib/format/bin/index |
		tee inx.src.$$ $sed |
		$roff $ditdev $options $macros - $post") > index.out 2>> $err
	geterror
fi

########################################################################
# Clean out log and temp files
########################################################################

find $LOGDIR $TMPDIR -ctime +5 -exec rm -f {} \;

############## SCRIPT ./Cdebug
echo ""
echo "#define MikeDEBUG"
echo "#ifdef MikeDEBUG"
echo "static char _sourceFile[] = __FILE__;"
echo "#endif                                                   /* #ifdef MikeDEBUG */"
echo ""
echo "#ifdef MikeDEBUG"
echo "printf( \"(%s:%d)\\n\", _sourceFile, __LINE__ );"
echo "fprintf( stderr, \"(%s:%d)\\n\", _sourceFile, __LINE__ );"
echo "#endif                                                   /* #ifdef MikeDEBUG */"
echo ""
exit 0

############## SCRIPT ./ceh
sed							\
	-e	'/^[Aa]utoforwarded:/d'			\
	-e	'/^Apparently-To:/d'			\
	-e	'/^Approved:/d'				\
	-e	'/^Article:/d'				\
	-e	'/^Comments:/d'				\
	-e	'/^Content-Disposition:/d'		\
	-e	'/^Content-Description:/d'		\
	-e	'/^Content-Length:/d'			\
	-e	'/^Content-Transfer-Encoding:/d'	\
	-e	'/^Content-Type:/d'			\
	-e	'/^Distribution:/d'			\
	-e	'/^Encoding:/d'				\
	-e	'/^Errors-To:/d'			\
	-e	'/^From /d'				\
	-e	'/^[Ii]mportance:/d'			\
	-e	'/^In-[Rr]eply-[Tt]o:/d'		\
	-e	'/^Keywords:/d'				\
	-e	'/^Lines:/d'				\
	-e	'/^Mail-System-Version:/d'		\
	-e	'/^Message-[Ii][Dd]:/d'			\
	-e	'/^[Mm]ime-Version:/d'			\
	-e	'/^NNTP.*:/d'				\
	-e	'/^Old-Return-Path:/d'			\
	-e	'/^Organization:/d'			\
	-e	'/^Original-Encoded-Information-.*:/d'	\
	-e	'/^Path:/d'				\
	-e	'/^[Pp]riority:/d'			\
	-e	'/^Precedence:/d'			\
	-e	'/^Received:/d'				\
	-e	'/^Replied:/d'				\
	-e	'/^Reply-To:/d'				\
	-e	'/^Resent-Date:/d'			\
	-e	'/^Resent-From:/d'			\
	-e	'/^Resent-Message-[Ii][Dd]:/d'		\
	-e	'/^Resent-Sender:/d'			\
	-e	'/^Resent-To:/d'			\
	-e	'/^Return-Path:/d'			\
	-e	'/^[Rr][Ee][Ff][Ee][Rr][Ee][Nn].*:/d'	\
	-e	'/^Sender:/d'				\
	-e	'/^Status:/d'				\
	-e	'/^User-Agent:/d'			\
	-e	'/^[Uu]a-Content-Id:/d'			\
	-e	'/^X-Accept-Language:/d'		\
	-e	'/^X-Authentication-Warning:/d'		\
	-e	'/^X-Corel-.*:/d'			\
	-e	'/^X-[Ff]ace:/d'			\
	-e	'/^X-Incognito-.*:/d'			\
	-e	'/^X-Juno-.*:/d'			\
	-e	'/^X-Listprocessor-Version:/d'		\
	-e	'/^X-Loop:/d'				\
	-e	'/^X-Mail-Agent:/d'			\
	-e	'/^X-Mailer:/d'				\
	-e	'/^X-Mailing-List:/d'			\
	-e	'/^X-Mimeole:/d'			\
	-e	'/^X-Mozilla-Status:/d'			\
	-e	'/^X-Msmail.*:/d'			\
	-e	'/^X-Mts:/d'				\
	-e	'/^X-Newsreader:/d'			\
	-e	'/^X-Pgp-Fingerprint:/d'		\
	-e	'/^X-PH:/d'				\
	-e	'/^X-Pmd-Folder:/d'			\
	-e	'/^X-Priority:/d'			\
	-e	'/^Xref:/d'				\
	-e	'/^X-Sender:/d'				\
	-e	'/^X-UIDL:/d'				\
	-e	'/^X-[Uu][Rr][IiLl]:/d'			\
	-e	's/\([Rr][Ee]: *\)\1*/Re: /'		\
	-e	's/[Rr][Ee]: */Re: /g'			\
	-e	's/\(Re: *\)\1*/Re: /'			\

#	-e	'/^[Ss][Uu][Bb][Jj][Ee][Cc][Tt]:/s
#	-e	'/^[Mm][Ii][Mm][Ee].*:/d'		\

############## SCRIPT ./cleanEmailHeader
sed							\
	-e	'/^[Aa]utoforwarded:/d'			\
	-e	'/^Apparently-To:/d'			\
	-e	'/^Approved:/d'				\
	-e	'/^Article:/d'				\
	-e	'/^Comments:/d'				\
	-e	'/^Content-Disposition:/d'		\
	-e	'/^Content-Description:/d'		\
	-e	'/^Content-Length:/d'			\
	-e	'/^Content-Transfer-Encoding:/d'	\
	-e	'/^Content-Type:/d'			\
	-e	'/^Distribution:/d'			\
	-e	'/^Encoding:/d'				\
	-e	'/^Errors-To:/d'			\
	-e	'/^From /d'				\
	-e	'/^[Ii]mportance:/d'			\
	-e	'/^In-[Rr]eply-[Tt]o:/d'		\
	-e	'/^Keywords:/d'				\
	-e	'/^Lines:/d'				\
	-e	'/^Mail-System-Version:/d'		\
	-e	'/^Message-[Ii][Dd]:/d'			\
	-e	'/^[Mm]ime-Version:/d'			\
	-e	'/^NNTP.*:/d'				\
	-e	'/^Old-Return-Path:/d'			\
	-e	'/^Organization:/d'			\
	-e	'/^Original-Encoded-Information-.*:/d'	\
	-e	'/^Path:/d'				\
	-e	'/^[Pp]riority:/d'			\
	-e	'/^Precedence:/d'			\
	-e	'/^Received:/d'				\
	-e	'/^Replied:/d'				\
	-e	'/^Reply-To:/d'				\
	-e	'/^Resent-Date:/d'			\
	-e	'/^Resent-From:/d'			\
	-e	'/^Resent-Message-[Ii][Dd]:/d'		\
	-e	'/^Resent-Sender:/d'			\
	-e	'/^Resent-To:/d'			\
	-e	'/^Return-Path:/d'			\
	-e	'/^[Rr][Ee][Ff][Ee][Rr][Ee][Nn].*:/d'	\
	-e	'/^Sender:/d'				\
	-e	'/^Status:/d'				\
	-e	'/^User-Agent:/d'			\
	-e	'/^[Uu]a-Content-Id:/d'			\
	-e	'/^X-Accept-Language:/d'		\
	-e	'/^X-Authentication-Warning:/d'		\
	-e	'/^X-Corel-.*:/d'			\
	-e	'/^X-[Ff]ace:/d'			\
	-e	'/^X-Incognito-.*:/d'			\
	-e	'/^X-Juno-.*:/d'			\
	-e	'/^X-Listprocessor-Version:/d'		\
	-e	'/^X-Loop:/d'				\
	-e	'/^X-Mail-Agent:/d'			\
	-e	'/^X-Mailer:/d'				\
	-e	'/^X-Mailing-List:/d'			\
	-e	'/^X-Mimeole:/d'			\
	-e	'/^X-Mozilla-Status:/d'			\
	-e	'/^X-Msmail.*:/d'			\
	-e	'/^X-Mts:/d'				\
	-e	'/^X-Newsreader:/d'			\
	-e	'/^X-Pgp-Fingerprint:/d'		\
	-e	'/^X-PH:/d'				\
	-e	'/^X-Pmd-Folder:/d'			\
	-e	'/^X-Priority:/d'			\
	-e	'/^Xref:/d'				\
	-e	'/^X-Sender:/d'				\
	-e	'/^X-UIDL:/d'				\
	-e	'/^X-[Uu][Rr][IiLl]:/d'			\
	-e	's/\([Rr][Ee]: *\)\1*/Re: /'		\
	-e	's/[Rr][Ee]: */Re: /g'			\
	-e	's/\(Re: *\)\1*/Re: /'			\

#	-e	'/^[Ss][Uu][Bb][Jj][Ee][Cc][Tt]:/s
#	-e	'/^[Mm][Ii][Mm][Ee].*:/d'		\

############## SCRIPT ./cleanEmailHeaderBACH
sed							\
	-e	'/^Apparently-To:/d'			\
	-e	'/^Approved:/d'				\
	-e	'/^Article:/d'				\
	-e	'/^Comments:/d'				\
	-e	'/^Content-Description:/d'		\
	-e	'/^Content-Disposition:/d'		\
	-e	'/^Content-[Ll]ength:/d'		\
	-e	'/^Content-[Tt]ransfer-[Ee]ncoding:/d'	\
	-e	'/^Content-[Tt]ype:/d'			\
	-e	'/^Distribution:/d'			\
	-e	'/^Encoding:/d'				\
	-e	'/^Errors-To:/d'			\
	-e	'/^From /d'				\
	-e	'/^In-[Rr]eply-[Tt]o:/d'		\
	-e	'/^Keywords:/d'				\
	-e	'/^Lines:/d'				\
	-e	'/^Mail-System-Version:/d'		\
	-e	'/^Mime-[Vv]ersion:/d'			\
	-e	'/^Message-[Ii][Dd]:/d'			\
	-e	'/^NNTP.*:/d'				\
	-e	'/^Old-Return-Path:/d'			\
	-e	'/^Organization:/d'			\
	-e	'/^Original-Encoded-Information-.*:/d'	\
	-e	'/^Path:/d'				\
	-e	'/^Precedence:/d'			\
	-e	'/^Received:/d'				\
	-e	'/^Replied:/d'				\
	-e	'/^Reply-[Tt]o:/d'			\
	-e	'/^Resent-Date:/d'			\
	-e	'/^Resent-From:/d'			\
	-e	'/^Resent-Message-[Ii][Dd]:/d'		\
	-e	'/^Resent-Sender:/d'			\
	-e	'/^Resent-To:/d'			\
	-e	'/^Return-[Pp]ath:/d'			\
	-e	'/^Sender:/d'				\
	-e	'/^Status:/d'				\
	-e	'/^User-Agent:/d'			\
	-e	'/^X-[Aa]ccept-[Ll]anguage:/d'		\
	-e	'/^X-[Aa]uthentication-[Ww]arning:/d'	\
	-e	'/^X-Corel-.*:/d'			\
	-e	'/^X-Incognito-.*:/d'			\
	-e	'/^X-Juno-.*:/d'			\
	-e	'/^X-Listprocessor-Version:/d'		\
	-e	'/^X-Loop:/d'				\
	-e	'/^X-Mail-Agent:/d'			\
	-e	'/^X-[Mm]ailer:/d'			\
	-e	'/^X-Mailing-List:/d'			\
	-e	'/^X-Mimeole:/d'			\
	-e	'/^X-Mozilla-Status:/d'			\
	-e	'/^X-Msmail.*:/d'			\
	-e	'/^X-Mts:/d'				\
	-e	'/^X-Newsreader:/d'			\
	-e	'/^X-PH:/d'				\
	-e	'/^X-Pgp-Fingerprint:/d'		\
	-e	'/^X-Pmd-Folder:/d'			\
	-e	'/^X-Priority:/d'			\
	-e	'/^X-Sender:/d'				\
	-e	'/^X-UIDL:/d'				\
	-e	'/^X-[Ff]ace:/d'			\
	-e	'/^X-[Uu][Rr][IiLl]:/d'			\
	-e	'/^Xref:/d'				\
	-e	'/^[Aa]utoforwarded:/d'			\
	-e	'/^[Ii]mportance:/d'			\
	-e	'/^[Mm]ime-Version:/d'			\
	-e	'/^[Pp]riority:/d'			\
	-e	'/^[Rr][Ee][Ff][Ee][Rr][Ee][Nn].*:/d'	\
	-e	'/^[Uu]a-Content-Id:/d'			\
	-e	's/[Rr][Ee]: */Re: /g'			\

#	-e	'/^[Ss][Uu][Bb][Jj][Ee][Cc][Tt]:/s
#	-e	'/^[Mm][Ii][Mm][Ee].*:/d'		\

############## SCRIPT ./cleanEmailHeaderOK
for f in				\
	Comments:			\
	Content-Transfer-Encoding:	\
	Content-Type:			\
	In-Reply-To:			\
	In-reply-to:			\
	MIME-Version:			\
	Mail-System-Version:		\
	Message-ID:			\
	Message-Id:			\
	Mime-Version:			\
	Old-Return-Path:		\
	Organization:			\
	Precedence:			\
	Received:			\
	Replied:			\
	Reply-To:			\
	Resent-Date:			\
	Resent-From:			\
	Resent-Message-ID:		\
	Resent-Message-Id:		\
	Resent-Sender:			\
	Resent-To:			\
	Return-Path:			\
	Sender:				\
	Status:				\
	X-Authentication-Warning:	\
	X-Face:				\
	X-Listprocessor-Version:	\
	X-Loop:				\
	X-Mailer:			\
	X-Mailing-List:			\
	X-Newsreader:			\
	X-PH:				\
	X-Pgp-Fingerprint:		\
	X-Pmd-Folder:			\
	X-Sender:			\
	X-UIDL:				\
	X-URL:				\
	X-Uri:				\
	X-Url:				\
	X-face:				\
	X-uri:				\

do
	echo ":g/^$f /d"
done

############## SCRIPT ./coachroh
#fromHack | sed -e 's/^[Tt][Oo]:[	 ].*$/To: CoachRoh@aol.com/'
 fromHack | sed -e 's/^[Tt][Oo]:[	 ].*$/To: coachroh@cox.net/'

############## SCRIPT ./coalesceFiles
#!/bin/bash
tokens=`echo $@`
first=`echo  $tokens | fmt -1 | head -1`
tokens=`echo $tokens | fmt -1 | sed 1d`
if [ -z "$first" ]
then
	echo Cannot determine first item
	exit 1
fi

if [ -z "$tokens" ]
then
	echo Cannot determine any items but one
	exit 1
fi

for f in $tokens
do
	echo Coalesce $first $f
	banner next >>$first && cat $f >>$first && rm $f
done

############## SCRIPT ./margins2wide
cat <<EOF
To:
Subject: layout of your email (`tds`)
Newsgroups: rec.food.cooking

Howdy,                         (This is no big deal, just FYI)

I've wondered if you are aware that the margins in your email
messages have an unconventional appearance, making for difficult
reading.  I have included a sample at the end of this message.

I suspect the problem is that you're using MicroSoft Windows,
for which an email package has yet to be produced which is
anything but mediocre, particularly when it comes to honoring
existing email protocols and conventions (tragic examples:
NetScape, Eudora, CCmail).  One eternal problem with Windows-
based email packages is that they often don't make it obvious
where the line-breaks will occur in a given message as finally
transmitted; various packages seem to use essentially random
decision processes in deciding how long your lines will be.
Please allow me to suggest that you look for a way to tell your
email software that you REALLY DO want it to keep your margins
around 70-75 columns in order that your messages be correctly
displayed by the majority of systems on which your words of
wisdom are likely to appear.

Here's hoping you'll forgive me for being so intrusive - I'll
probably be tilting at this particular windmill forever...

Regards,
 ---------------------------------
 Michael O'Donnell     mod@std.com
 ---------------------------------

P.S.  Here's how a number of people saw your message laid out:

To:
Subject: Narrower margins, please

Howdy,

(Here's hoping you read no ill will into this message,
since it wasn't written with any.)  Please, consider NOT
using arbitrarily wide margins when you post articles.
There are several good reasons to keep your lines around
70 or 75 columns wide; two of them are:

 - There are a LOT of folks whose screens are configured to
   the "standard" 80 columns, either because they have no
   choice or out of long-established habit.  Email messages
   and UseNet news articles with arbitrarily wide margins
   look so bad when displayed under such circumstances that
   many folks won't waste their time on them.  (see below)

 - When your words of wisdom are quoted (and re-re-re-re-
   quoted) you will have left room for expansion.

Regards,
 ---------------------------------
 Michael O'Donnell     mod@std.com
 ---------------------------------

P.S.  Here's what your posting looked like on my screen:

Sorry, but I don't - I'm a UNIX kind of guy and I've never used the
email facilities in NetScape.  Umm, well - wait a minute...

OK, I just fooled around with the email stuff in the NetScape (3.0b4)
I have on my Linux workstation and all I can say is "blecchh!"   It
would appear that they're catering to the lowest common denominator -
they've rounded off all the sharp edges in order that clueless people
not be presented with any actual decisions to make, but this
unfortunately makes the software less than useful for grownups.  I
apologize for letting my annoyance show like that, but that kind of
childproofing *does* annoy me.  It would appear that your only choice
(assuming you continue to use NetScape for email) is to hit Return at
the end of each line as you're composing your messages in order that
you force the line breaks where you want them.  I am *not* saying
that's desirable, or even acceptable (I personally would be foaming
at the mouth in no time under such circumstances) but that's the only
option that comes to mind given my cursory examination.  Another
possibility might be to resize the entire window - maybe a narrower
window would be an indication to NetScape that you don't necessarily
want mile-long lines, though I doubt it based on what I've seen so
far.  I *strongly* encourage you to complain loudly and persistently
to NetScape about this braindamage - they'll never change, otherwise...

EOF

############## SCRIPT ./cric
fromHack | sed -e '/^To:/s/^.*$/To: cric@rent-a-clue.com/' -e '/^cc:/d'

############## SCRIPT ./crudecode
tr -d "\015" | uudecode

############## SCRIPT ./bookmark4
while read input
do
    echo '    <DT><A HREF="'$input'" ADD_DATE="964439188" LAST_VISIT="964439188" LAST_MODIFIED="964439188">'$input'</A>'
done

############## SCRIPT ./Cskel
cat <<END_OF_C_SKELETON
/*
 * ----------------------------------------------------------------------------
 * In general:
 *  - A "limit" is an asymptotic value - one which cannot be reached.
 *  - A "maximum" is the highest value which CAN be reached.
 */

#include <stdio.h>
#include <unistd.h>

#ifdef	ENABLE_THESE_IF_NEEDED
#include <ctype.h>
#include <strings.h>
#endif                                      /* #ifdef ENABLE_THESE_IF_NEEDED */

/*
 * ----------------------------------------------------------------------------
 * Constant #definitions
 */
#undef  TRUE
#undef  FALSE

#define FALSE               (0)
#define TRUE                (!(FALSE))

typedef unsigned       char u8;
typedef   signed       char s8;
typedef unsigned short int  u16;
typedef   signed short int  s16;
typedef   signed long  int  s32;
typedef unsigned long  int  u32;

/*
 * For use with one-dimensional arrays whose size is known at compile time:
 * A maximum is the highest  attainable/valid   value.
 * A limit   is the lowest unattainable/invalid value.
 */
#define ARRAY_ELEMENT_COUNT( array ) (sizeof((array)) / sizeof(((array)[0])))
#define ARRAY_INDEX_LIMIT(   array )           ARRAY_ELEMENT_COUNT(array)
#define ARRAY_POINTER_LIMIT( array ) (&((array)[ ARRAY_INDEX_LIMIT(array) ]))
#define ARRAY_INDEX_MAX(     array )            (ARRAY_INDEX_LIMIT(array) - 1)
#define ARRAY_POINTER_MAX(   array ) (&((array)[   ARRAY_INDEX_MAX(array) ]))

/*
 * SAFE_{COPY,CAT} only usable when compiler can determine sizeof(dest)
 */
#define SAFE_COPY( dest, src )                  \
do  {                                           \
        strncpy( (dest), (src), sizeof(dest) ); \
        (dest)[ARRAY_INDEX_MAX(dest)] = 0;      \
} while( 0 )

/*
 * Efficiently append as much as possible of src onto dest
 * without overrunning it.  Not guaranteed to copy all (or
 * even any) of src, but last byte of dest is guaranteed to
 * be NULL afterwards, even if it previously wasn't.
 */
#define SAFE_CAT( dest, src )                   \
do  {                                           \
        size_t l = strlen( dest );              \
                                                \
        if( l < ARRAY_INDEX_MAX(dest) )  {      \
                strncpy( &((dest)[ l ]), (src), (ARRAY_INDEX_MAX(dest) - l)); \
        }                                       \
        (dest)[ARRAY_INDEX_MAX(dest)] = 0;      \
} while( 0 )

#define MATCH(  x, y )    !strcmp(  (x), (y) )
#define MATCHN( x, y, n ) !strncmp( (x), (y), (n) )

typedef enum  {
	GEE,
	WHIZ,
	BANG,
} thingamajig;

typedef struct nameValueMapEntryStruct  {
    char       *name;
    thingamajig value;
} nameValueMapEntry;

#define NAME_VALUE_MAP_ENTRY( tag ) { name: #tag, value: tag }

nameValueMapEntry nameValueMap[] =  {
    NAME_VALUE_MAP_ENTRY( GEE ),
    NAME_VALUE_MAP_ENTRY( WHIZ ),
    NAME_VALUE_MAP_ENTRY( BANG ),
};

char *
entryNameFor(
    u32                value )
{
    nameValueMapEntry *entry;

    for( entry = nameValueMap;
         entry < ARRAY_POINTER_LIMIT( nameValueMap );
         entry++ )
    {
        if( entry->value == value )  {
            return( entry->name );
        }
    }
    return( 0 );
}

u32
entryValueFor(
    char              *name )
{
    nameValueMapEntry *entry;

    for( entry = nameValueMap;
         entry < ARRAY_POINTER_LIMIT( nameValueMap );
         entry++ )
    {
        if( !strcmp( entry->name, name )  )  {
            return( entry->value );
        }
    }
    return( ~0 );
}

/*
 * ----------------------------------------------------------------------------
 * "map" is a pointer to an array of unsigned ints.
 * Size of that array is unspecified but is assumed
 * to be large enough to hold the necessary bits.
 */
u32
setBitMapBit(
    u32  index,
    u32 *map    )
{
    u32  bit;
    u32  field;

    bit          = 1 << (index & 0x1f);                         /* Modulo 32 */
    index      >>= 5;                                        /* Divide by 32 */
    field        = map[ index ];
    map[ index ] = field | bit;
    return( field & bit );                          /* Previous state of bit */
}

u32
clearBitMapBit(
    u32  index,
    u32 *map    )
{
    u32  bit;
    u32  field;

    bit          = 1 << (index & 0x1f);                         /* Modulo 32 */
    index      >>= 5;                                        /* Divide by 32 */
    field        = map[ index ];
    map[ index ] = field & ~bit;
    return( field & bit );                          /* Previous state of bit */
}

/*
 * A boolean function
 */
u32
bitMapBitIsSet(
    u32  index,
    u8  *map    )
{
    return( map[ index >> 5 ]  &  (1 << (index & 0x1f)) );
}

unsigned char bitmap[ 0x4000 / 8 ];

/*
 * Macro versions of above
 */
#define SET_BITMAP_BIT(    bit, map )  \
              do { (map)[  (bit) >> 5] |=  (1 << ((bit) & 0x1f));  } while( 0 )
#define CLEAR_BITMAP_BIT(  bit, map )  \
              do { (map)[  (bit) >> 5] &= ~(1 << ((bit) & 0x1f));  } while( 0 )
#define BITMAP_BIT_IS_SET( bit, map )  \
              do { ((map)[ (bit) >> 5] &   (1 << ((bit) & 0x1f))); } while( 0 )

/*
 * ----------------------------------------------------------------------------
 * Structure and union templates
 */

/*
 * ----------------------------------------------------------------------------
 * Data
 */
extern               char    *optarg;
extern               int      opterr;
extern               int      optind;
extern               int      optopt;

                     char   **origArgv;
                     int      origArgc;

/*
 * ----------------------------------------------------------------------------
 */
int
localMain( int    argc,
           char **argv,
           char **envp  )
{
    optarg    = NULL;

    if( argc < 2 )  {
	fprintf( stderr, "usage:\n\t%s ThisSpaceForRent\n", origArgv[ 0 ]  );
	exit( 1 );
    }

    while( 1 )  {
        unsigned long int  byte;

        byte = getopt( argc, argv, "n:N:s:S:vV" );

        if( byte == -1 )  {
            break;
        }
        switch( byte )  {
#ifdef	ENABLE_THESE_IF_NEEDED
        case 'n':
        case 'N': someInt      = atoi( optarg ); break;
        case 's':
        case 'S': someCharPtr  = optarg          break;
        case 'v':
        case 'V': verboseFlag  = TRUE;           break;
#endif                                      /* #ifdef ENABLE_THESE_IF_NEEDED */
        default:
            localMain( 1, origArgv, envp );
            exit( 1 );                                         /* NOTREACHED */
        }
    }

    if( someKindOfProblemDeservingUsageMessageAndExit )  {
        localMain( 1, origArgv, envp );       /* Explain usage and bail out. */
    }

#ifdef	ENABLE_THESE_IF_NEEDED
    srandom( time(0) * getpid(), 0 );
#endif                                      /* #ifdef ENABLE_THESE_IF_NEEDED */

    return( 0 );
}

/*
 * ----------------------------------------------------------------------------
 * So recursive calls to "main()" can work without reinvoking __main()
 */
int
main( int    argc,
      char **argv,
      char **envp  )
{
    origArgv = argv;
    origArgc = argc;

    return( localMain( argc, argv, envp )  );
}

END_OF_C_SKELETON

############## SCRIPT ./dateString
date '+%Y%m%d'

############## SCRIPT ./reminder
holdFile=/tmp/holdFile$$
echo ""                            >$holdFile && \
echo Date: Thu, 1 Jan 2009 00:00:00 -0500 >>$holdFile && \
echo "Subject: $@"                        >>$holdFile && \
echo From: --REMINDER--                   >>$holdFile && \
echo ""                           >>$holdFile && \
inc -nosilent -file                         $holdFile && \
rm                                          $holdFile

############## SCRIPT ./eclean
ceh | sed -e 's/[	 ][	 ]*$//' | cat -s

############## SCRIPT ./ELSE
echo "#else /* $1 */" | rjc
cat

############## SCRIPT ./ENDIF
echo -n "#endif $@"
ccmnt

############## SCRIPT ./endif
echo -n "#endif $@"
ccmnt

############## SCRIPT ./expandBUBBAmailFile
#!/bin/csh -f
set file=$argv
if ( -f $file ) then
	echo "##########################" OPEN FILE $file
	foreach line ( `sed -e 's/^[	 ][	 ]*//' -e 's/[	 ].*$//' < $file` )
		$0 $line
	end
	echo "##########################" DONE FILE $file
else
	echo $file
endif

############## SCRIPT ./expn
expect <<EOF
#
# Send 1 char at a time, 100 millis apart
#
set send_slow {1 0.1}
#spawn /usr/bin/mh/inc -host world.std.com       -norpop
spawn  /usr/bin/mh/inc -host pop.ne.mediaone.net -norpop
#
#expect "Password (world.std.com:mod): "
expect  "Password (pop.ne.mediaone.net:mod): "
#
# Sleep to allow the terminal settings to
# be changed to avoid echoing the password...
#
#sleep 1
#send -s somePassWord\r
set timeout -1
expect eof
EOF

############## SCRIPT ./extractEmailAddrs
   sed  -e 's/[]?=[\#%\^|\$>"<\&`:'"'"';\/*,)(!]/ /g'  \
        -e 's/[	 ][	 ]*/\
/g'  \
 | grep -i '[-0-9a-zA-Z_.][-0-9a-zA-Z_+.]*@[-0-9a-zA-Z_][-0-9a-zA-Z_]*\.[-0-9a-zA-Z_][-0-9a-zA-Z_]*' \
 | sort -fdu

# The MCLX version as of 20020428
#
# sed  -e 's/[]?=[\#%\^|\$>"<\&`:'"'"';\/*,)(!]/ /g' -e 's/[       ][      ]*/\
# /g' | grep -i '[-0-9a-zA-Z_][-0-9a-zA-Z_+]*@[-0-9a-zA-Z_][-0-9a-zA-Z_]*\.[-0-9a-zA-Z_][-0-9a-zA-Z_]*' | sort -fdu
#
#
#
# # fmt -1 \
# #  | grep -i '[-0-9a-zA-Z_][-0-9a-zA-Z_+]*@[-0-9a-zA-Z_][-0-9a-zA-Z_]*\.[-0-9a-zA-Z_][-0-9a-zA-Z_]*' \
# #  | sed  -e 's/^/ /' -e 's/[][\#%\^|\$>"<\&`:'"'"';\/*,)(!]/ /g' -e 's/  */ /g' \
# #  | fmt  -1 \
# #  | grep -i '[-0-9a-zA-Z_][-0-9a-zA-Z_+]*@[-0-9a-zA-Z_][-0-9a-zA-Z_]*\.[-0-9a-zA-Z_][-0-9a-zA-Z_]*' \
# #  | sort -fdu
# # grep -i '[-0-9a-zA-Z_][-0-9a-zA-Z_]*@[-0-9a-zA-Z_][-0-9a-zA-Z_]*\.[-0-9a-zA-Z_][-0-9a-zA-Z_]*' \
# #  | sed -e 's/[][\#%\^|\$>"<\&`:'"'"';\/*,)(!]/ /g' -e 's/^/ /' \
# #  | fmt -1 \
# #  | eat \
# #  | grep -i '[-0-9a-zA-Z_][-0-9a-zA-Z_]*@[-0-9a-zA-Z_][-0-9a-zA-Z_]*\.[-0-9a-zA-Z_][-0-9a-zA-Z_]*' \
# #  | sed -e 's/^ //' -e '/^[0-9]/d' \
# #  | sort -fdu
# # grep -i '[-0-9a-zA-Z_][-0-9a-zA-Z_]*@[-0-9a-zA-Z_][-0-9a-zA-Z_]*\.[-0-9a-zA-Z_][-0-9a-zA-Z_]*' \
# #  | sed -e 's/[][\#%\^|\$>"<\&`:'"'"';\/*,)(!]/ /g' -e 's/^/ /' \
# #  | fmt -1 \
# #  | eat \
# #  | grep -i '[-0-9a-zA-Z_][-0-9a-zA-Z_]*@[-0-9a-zA-Z_][-0-9a-zA-Z_]*\.[-0-9a-zA-Z_][-0-9a-zA-Z_]*' \
# #  | sort -fdu

############## SCRIPT ./extractEmailAddrsBACH
grep -i '[-0-9a-zA-Z_][-0-9a-zA-Z_]*@[-0-9a-zA-Z_][-0-9a-zA-Z_]*\.[-0-9a-zA-Z_][-0-9a-zA-Z_]*' \
 | sed -e 's/[][\#%\^|\$>"<\&`:'"'"';\/*,)(!]/ /g' -e 's/^/ /' \
 | fmt -1 \
 | eat \
 | grep -i '[-0-9a-zA-Z_][-0-9a-zA-Z_]*@[-0-9a-zA-Z_][-0-9a-zA-Z_]*\.[-0-9a-zA-Z_][-0-9a-zA-Z_]*' \
 | sed -e 's/^ //' -e '/^[0-9]/d' \
 | sort -fdu

############## SCRIPT ./finc
#!/bin/csh -f

set incFiles=/tmp/incFiles$$

onintr cleanUp

cat >$incFiles
echo '#if OSF_INTEL'
sed -e 's;i860paragon;i860/PARAGON;' <$incFiles
echo ""
echo '#else                                                       /* #if OSF_INTEL */'
cat $incFiles
echo '#endif                                                /* #else #if OSF_INTEL */'

#
# One way or another, we're done.
#
cleanUp:
rm -f          \
    $incFiles

############## SCRIPT ./findHexWords
grep -ix -e '[0123456789abcdefilosz][0123456789abcdefilosz]*' \
   | sed -e 's/[LlIi]/1/g' \
         -e 's/[Oo]/0/g'   \
         -e 's/[Ss]/5/g'   \
         -e 's/[Zz]/2/g'

############## SCRIPT ./findSBfile
#!/bin/csh -f
while ( 1 )
    set file=($<)
    if ( $file == "" ) then
        exit 0
    else if ( -e $file ) then
        ;
    else if ( -e ../link/src/$file ) then
        set file="../link/src/$file"
    else if ( -e ../link/link/src/$file ) then
        set file="../link/link/src/$file"
    else if ( -e ../link/link/link/src/$file ) then
        set file="../link/link/link/src/$file"
    else if ( -e ../link/link/link/link/src/$file ) then
        set file="../link/link/link/link/src/$file"
    else set file="############ Can't find $file"
    endif
    echo "$file" | sed -e 's/\/\.\//\//g' -e 's/^\.\///'
end

############## SCRIPT ./fromHack
#cc: mod@std.com
#From: mod@std.com (Michael O'Donnell)
#Reply-To: mod@std.com

#X-message-flag: ATTENTION! Mouse movement or keyboard activity has been detected - Windows must be restarted before this change can take effect - Reboot now? (y/n)
#X-message-flag: Re-appoint President Cheney in '04!

cat <<EOF
From:             "Michael ODonnell" <michael.odonnell@comcast.net>
Mail-Followup-To: "Michael ODonnell" <michael.odonnell@comcast.net>
Mail-Reply-To:    "Michael ODonnell" <michael.odonnell@comcast.net>
Reply-To:         "Michael ODonnell" <michael.odonnell@comcast.net>
cc:               "Michael ODonnell" <michael.odonnell@comcast.net>
To:
Subject:

EOF

############## SCRIPT ./fromHackMIME
cat <<EOF
From:             "Michael ODonnell" <michael.odonnell@comcast.net>
Mail-Followup-To: "Michael ODonnell" <michael.odonnell@comcast.net>
Mail-Reply-To:    "Michael ODonnell" <michael.odonnell@comcast.net>
Reply-To:         "Michael ODonnell" <michael.odonnell@comcast.net>
cc:               "Michael ODonnell" <michael.odonnell@comcast.net>
Subject: UUencoded message skeleton
MIME-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_modMessageBoundary"

This is a multipart MIME message.

--==_modMessageBoundary
Content-Type: text/plain; charset="us-ascii"
Content-ID: <SomeMessageFrom@std.com>

This part can contain a simple text message

--==_modMessageBoundary
Content-Type: image/jpeg
Content-Description: NameOfUUencodedFile
Content-Transfer-Encoding: x-uuencode

begin 666 NameOfUUencodedFile
end

--==_modMessageBoundary

EOF

############## SCRIPT ./ftp.expect
#!/u/bin/expect -f

set site      [lindex $argv 0]
set dir       [lindex $argv 1]
set theirname [lindex $argv 2]
set myname    [lindex $argv 3]
set password  "$env(USER)@"

set    timeout 60
spawn  ftp $site
expect "*Name*:*"
send   "anonymous\r"
expect "*Password:*"
send   "$password\r"
expect "*ftp>*"
send   "binary\r"
expect "*ftp>*"
send   "cd $dir\r"
expect "*550*ftp>*" {exit 1} "*250*ftp>*"
send   "get $theirname $myname\r"
expect "*550*ftp>*" {exit 1} "*200*226*ftp>*"

close
wait
send_user "FTP transfer ok\n"
exit      0

############## SCRIPT ./gatherEmail

timeStamp=$$`date '+%Y%m%d%H%M%S'`
  tempDir=gather$timeStamp

folder +inbox                           \
 && cd ~/.mail/inbox                    \
 && mkdir ../$tempDir                   \
 && refile +$tempDir `pick -sub "$@" `  \
 && cd ../$tempDir                      \
 && folder +$tempDir                    \
 && refile +inbox `pick -sub "$@" `     \
 && folder +inbox                       \
 && cd ~/.mail/inbox                    \
 && rmdir ../$tempDir

############## SCRIPT ./gatheREMINDER

timeStamp=$$`date '+%Y%m%d%H%M%S'`
  tempDir=gather$timeStamp

folder +inbox                              \
 && cd ~/.mail/inbox                       \
 && mkdir ../$tempDir                      \
 && refile +$tempDir `pick -from reminder` \
 && cd ../$tempDir                         \
 && folder +$tempDir                       \
 && refile +inbox `pick -from reminder`    \
 && folder +inbox                          \
 && cd ~/.mail/inbox                       \
 && rmdir ../$tempDir

############## SCRIPT ./genCscopeFileList
find . -type f -name '*.[chslyS]' | sed -e 's/..//' | sort | grep -v \
        -e '/.config$'               \
        -e '/.config.old$'           \
        -e '/.hdepend$'              \
        -e '/.version$'              \
        -e '/CREDITS$'               \
        -e '/ContenTable'            \
        -e '/Rules.make$'            \
        -e '/System.map$'            \
        -e '/boot/bbootsect$'        \
        -e '/boot/bsetup$'           \
        -e '/boot/tools/build$'      \
        -e '/defconfig$'             \
        -e '/notes'                  \
        -e '/pci\.ids$'              \
        -e '/specs'                  \
        -e 'BUGS-parport'            \
        -e 'MODULES$'                \
        -e '[Cc]hange[Ll]og'         \
        -e '\.a$'                    \
        -e '\.asc$'                  \
        -e '\.awk$'                  \
        -e '\.data$'                 \
        -e '\.depend$'               \
        -e '\.flags$'                \
        -e '\.gz$'                   \
        -e '\.map$'                  \
        -e '\.o$'                    \
        -e '\.o\.flags$'             \
        -e '\.pl$'                   \
        -e '\.reg$'                  \
        -e '\.regions$'              \
        -e '\.scr$'                  \
        -e '\.sed$'                  \
        -e '\.seq$'                  \
        -e '\.sh$'                   \
        -e '\.stamp$'                \
        -e '\.start$'                \
        -e '\.txt$'                  \
        -e '\.uni$'                  \
        -e 'gen-devlist$'            \
        -e 'genCscope'               \
        -e 'onfig\.in$'              \
        -e /4xx_io/                  \
        -e /8260_io/                 \
        -e /8xx_io/                  \
        -e /Documentation/           \
        -e /INTRO                    \
        -e /SCCS/                    \
        -e /acorn/                   \
        -e /acpi/                    \
        -e /alpha/                   \
        -e /amiga/                   \
        -e /arm/                     \
        -e /asm-alpha                \
        -e /asm-arm                  \
        -e /asm-cris                 \
        -e /asm-ia64/                \
        -e /asm-m68k/                \
        -e /asm-mips                 \
        -e /asm-parisc               \
        -e /asm-ppc64/               \
        -e /asm-s390                 \
        -e /asm-sh                   \
        -e /asm-sparc                \
        -e /atm/                     \
        -e /boot/compressed/bvmlinux \
        -e /chrp/                    \
        -e /cris/                    \
        -e /ftape/                   \
        -e /gemini/                  \
        -e /hamradio/                \
        -e /hp/                      \
        -e /iSeries/                 \
        -e /ia64/                    \
        -e /isdn/                    \
        -e /joystick/                \
        -e /m68k/                    \
        -e /macintosh                \
        -e /math-emu/                \
        -e /mips/                    \
        -e /mips64/                  \
        -e /nls/                     \
        -e /paride/                  \
        -e /parisc                   \
        -e /pmac/                    \
        -e /ppc64/                   \
        -e /prep/                    \
        -e /qnx4/                    \
        -e /radio/                   \
        -e /s390/                    \
        -e /s390x/                   \
        -e /sbus/                    \
        -e /sgi/                     \
        -e /sh/                      \
        -e /sound/                   \
        -e /sparc/                   \
        -e /sparc64/                 \
        -e /vmlinux                  \
        -e CHANGES                   \
        -e COPYING                   \
        -e Documentation/            \
        -e FAT.WARNING               \
        -e INSTALL                   \
        -e LICENSE                   \
        -e MAINTAIN                  \
        -e MARKER                    \
        -e README                    \
        -e RELEASE                   \
        -e REPORT                    \
        -e TODO                      \
        -e akefile                   \
        -e appletalk                 \
        -e bzImage                   \
        -e conmakehash               \
        -e copyright                 \
        -e cscope.file               \
        -e hanges                    \
        -e makeLog                   \
        -e scripts/                  \

#       -e /asm-ppc                  \
#       -e /ppc/                     \

############## SCRIPT ./genCtagsForAKM
#!/usr/bin/bash
#!/u/bin/bash
#!/opt/local/bin/bash
#!/n/viewserver/home/merlin/home2/bin/sun4/sos4/bash

####
# This script is intended to be run in the root of an MC/OS source tree,
# typically /vobs/mcos.  It arranges for the construction of a ctags
# database describing the files mentioned in cscope.files - this script
# will also generate some "artificial" entries in that ctags database
# corresponding to the symbols declared in certain assembler-language
# macros like _GLOBAL(), as well as those C-language symbols obscured
# by such irritiating AKM as the type_{struct,declare,define} macros.
#
# Note: The Emacs etags facility seems to be far superior WRT handling
#       of unusual constructs like we're trying to do here...
#
# The format of a ctags line is simply:
#
# symbol<TAB>file<TAB>pattern
#
# where symbol is the "thing" we're chasing, file is where it's found and
# pattern is the regular expression that gets us to the line of interest.
#
# When we're generating the "artificial" entries we're assuming that
# the layout of the constructs in question is such that we can just
# blindly accept everything between the parentheses as the target symbol.
# If that turns out to be insufficient then this script needs work,
# because we just extract that entire parenthesized string intact...
#

####
# The timeStamp is handy for generating any
# unique-per-script-invocation temp files and such...
#
timeStamp=`date '+%Y%m%d%H%M%S'`
 tempFile=tempFile$timeStamp

cat /dev/null >$tempFile

####
# Preserve existing instances of tags, if any...
#
if [ -f tags ]
then
    mv                   tags              tags$timeStamp
    echo "####" Existing tags preserved as tags$timeStamp
fi

####
# First, the "easy" part, just allow the normal output of ctags to accrete:
#
xargs -l5 ctags -at <cscope.files

echo "######## Generating tags for GLOBAL and type_{struct,declare,define}..."

####
# We'll later re-execute a search of all files mentioned in cscope.files
# for the constructs of interest, so it's OK to just blindly toss all ctags
# lines that currently mention those "troublesome" constructs...
#
grep    -e '^type_struct' -e '^type_define' -e '^type_declare' -e '^_\{0,1\}GLOBAL(' tags | fgrep '#define' >$tempFile
grep -v -e '^type_struct' -e '^type_define' -e '^type_declare' -e '^_\{0,1\}GLOBAL(' tags                  >>$tempFile

mv $tempFile tags

####
# We now re-execute the search of files mentioned in cscope.files, looking
# for certain constructs that ctags doesn't understand.  For each one that
# we find we'll generate an "artificial" tag-file entry:
#
xargs -l5 fgrep -e 'type_define'   \
                -e 'type_struct'   \
                -e 'GLOBAL(' /dev/null <cscope.files | while read line
do
    echo "$line"                # Continuing evidence that we're still alive...
    pattern=`echo "$line"    | sed -e 's/: */RZQcolonRZQ/' -e 's/^.*RZQcolonRZQ//' `
       file=`echo "$line"    | sed -e 's/:.*$//' `
     symbol=`echo "$pattern" | sed -e 's/^.*type_struct(//'    \
                                   -e 's/^.*type_define(//'    \
                                   -e 's/^_\{0,1\}GLOBAL(//'   \
                                   -e 's/).*$//' `
    echo -e "$symbol\t$file\t/$pattern" >>tags
done

#sort -fd <tags | uniq >$tempFile
 sort     <tags | uniq >$tempFile
mv $tempFile tags

############## SCRIPT ./genMakeMercuryScript
#!/usr/bin/bash
#!/u/bin/bash
#!/opt/local/bin/bash
#!/n/viewserver/home/merlin/home2/bin/sun4/sos4/bash

# Intended to be fed the output of a "make mercury" run in /vobs/mcos
# with the '-p' option active.  That output will be crunched into a
# script that should execute more quickly than the "make mercury" by
# itself because a certain amount of duplication is eliminated, as well
# as some reduction in the number of subordinate processes spawned.

tempFile=/tmp/tempFile$$

   grep -v -e '	'			\
	-e '\\'				\
	-e '^#'				\
 | sed	-e 's/^/ /'			\
	-e 's/;/\
 /g'					\
 | sed	-e 's/[	 ][	 ]*/ /g'	\
	-e 's/[	 ][	 ]*$//g'	\
 | sort -fd				\
 | uniq				>$tempFile

cat <<EOF
#!/usr/bin/bash
#!/u/bin/bash
#!/opt/local/bin/bash
#!/n/viewserver/home/merlin/home2/bin/sun4/sos4/bash

EOF

echo "xargs -l5 rm -f <<EOF"
grep '^ rm -f ' $tempFile | sed 's/ rm -f / /'
echo "EOF"
echo ""

echo "xargs -l5 mkdir -p <<EOF"
grep '^ mkdir -p ' $tempFile | sed 's/ mkdir -p / /'
echo "EOF"
echo ""

echo 'cat <<EOF | while read src dst; do if [ ! "$src" -o ! "$dst" ]; then break; else cp $src $dst ; fi; done'
grep '^ cp ' $tempFile | sed 's/ cp / /'
echo "EOF"
echo ""

echo 'cat <<EOF | while read src dst; do if [ ! "$src" -o ! "$dst" ]; then break; else ln -s $src $dst ; fi; done'
grep '^ ln -s ' $tempFile | sed 's/ ln -s / /'
echo "EOF"
echo ""

echo "xargs -l5 chmod -f +x <<EOF"
grep '^ chmod -f +x ' $tempFile | sed 's/ chmod -f +x / /' | grep -v -e '\.h$' -e '\.desc$'
echo "EOF"
echo ""

rm -f $tempFile

############## SCRIPT ./getWorldMHmail
export TIMESTAMP=`timeDateString`
ftp world <<EOF
w1rld1
lcd /tmp
bin
hash
prompt
ls worldMailMH
get worldMailMH $TIMESTAMP
dele worldMailMH
quit
quit
EOF
ls -laCF /tmp/$TIMESTAMP

############## SCRIPT ./whomc.pl
#!/u/bin/perl

# 30-Oct-96 hpsiegel; Extract information from phone_list.html also,
#		and add filtering
# 15-Oct-96 hpsiegel; Created

# PURPOSE
#	Extract username information from `ypcat hosts` or, if
#	the '-local' option is used, "/etc/passwd".

# Parse the command line
if ($ARGV[0] =~ /^-h/) {
    print "USAGE: $0 [-local] [<pattern> ...]";
    exit (0);
}
$local = 0;
if ($ARGV[0] =~ /^-l/) {
    $local = 1;
    shift;
}

# Process information from the Mercury WWW phone list
#$phone = "/n/source/www_server_root/www_files/nitty-gritty/phone+email/phone_list.html";
$phone = "/n/source/www_server_root/publish/nitty-gritty/associates/associates.html";
open (PHONE, $phone) or die "Can't open $phone: $!\n";
while (<PHONE>) {
    if (m"^[^ \t]+, .*\.\.x") {
	s"\." "g;
	s"," ";
	@phone = split (' ');
	$key = "$phone[0] $phone[1]";
	$phone	{$key} = sprintf "  %4s, %4s", $phone[2], $phone[3];
	$name	{$key} = "$phone[1] $phone[0]";
    }
}
close (PHONE);

# Now process passwd information

# Open the correct input dataset
if ($local) {
    open (IN, "/etc/passwd")
		or die "Can't read from /etc/passwd: $!";
}
else {
    open (IN, "ypcat passwd |")
		or die "Can't read from 'ypcat passwd': $!";
}

# Process the lines from the input
while (<IN>) {
    ($uname, $passwd, $uid, $gid, $fullname, $home, $shell)
		= split (/:/);
    if ($fullname !~ m"[ \t]") {
	$key = $fullname;
    }
    elsif ($fullname =~ m"account"i) {
	$key = "(Account) $fullname";
    }
    elsif ($fullname =~ m"consultant"i) {
	$key = "(Consultant) $fullname";
    }
    else {
	$fullname =~ m"(.*) ([^ ]*)";
	$key = "$2 $1";
    }
    $passwd	{$key} = sprintf "%6d  %-10s", $uid, $uname;
    $name	{$key} = $fullname;
}

# All done with the input
close (IN);

# Print the header
print "   uid  username      phone\n";
print "   ---  --------    ----------\n";

# Collect all the keys from both %phone and %passwd
@keys = ((keys %phone), (keys %passwd));
# Display their information, sorted by name
foreach $key (sort @keys) {
    $flag = 0;
    if ($passwd{$key} ne "") {
	$line = $passwd{$key};
	$passwd{$key} = "";
	$flag = 1;
    }
    else {
	$line = " " x 18;
    }
    if ($phone{$key} ne "") {
	$line .= $phone{$key};
	$phone{$key} = "";
	$flag = 1;
    }
    else {
	$line .= " " x 12;
    }
    $line .= "  $name{$key}\n";
    if ($flag) {
	if ($#ARGV < 0) {
	    print $line;
	}
	else {
	    foreach $pattern (@ARGV) {
		print $line if $line =~ m"$pattern"i;
	    }
	}
    }
}

############## SCRIPT ./noFF
tr -d "\014"

############## SCRIPT ./schade
 fromHack | sed -e 's/^[Tt][Oo]:[	 ].*$/To: "Norbert+Baerbel Schade" <norbertschade@comcast.net>\
To: "Norbert Schade, Oasis Semi" <schade@oasissemi.com>/'

############## SCRIPT ./rot26

count=0
string=$@
while [ $count -lt 26 ]
do
  echo $string
  string=`echo $string | rot1`
  count=$[$count + 1]
done

############## SCRIPT ./model
mailias | fgrep odel

############## SCRIPT ./emailDate
date '+%a, %d %b %Y %T %Z'

############## SCRIPT ./gnhlug
cat <<EOF
Mail-Reply-To: "Michael ODonnell" <michael.odonnell@comcast.net>
From:          "Michael ODonnell" <michael.odonnell@comcast.net>
Mail-Followup-To: "GNHLUG" <gnhlug-discuss@mail.gnhlug.org>
Reply-To:         "GNHLUG" <gnhlug-discuss@mail.gnhlug.org>
To: gnhlug-discuss@mail.gnhlug.org
Subject:
EOF

############## SCRIPT ./forward2
if [ $# -ne 1 ]
then
	exit 1
fi

    tempFile=/tmp/gzTemp$$`tds`
    tempMsg=/tmp/gzMsgTemp$$`tds`
    cat >$tempFile
    subject="`grep -i '^subject:' $tempFile | head -1 | sed -e 's/^[Ss][Uu][Bb][Jj][Ee][Cc][Tt]: *//'`"
    echo "To: $1"                                                   >$tempMsg
    echo 'From: "Michael ODonnell" <michael.odonnell@comcast.net>' >>$tempMsg
    echo 'cc: "Michael ODonnell" <michael.odonnell@comcast.net>'   >>$tempMsg
    echo "Subject: FWD - $subject"                                 >>$tempMsg
    echo ""                                                        >>$tempMsg
    rq ' '                         <$tempFile                      >>$tempMsg
    /usr/lib/mh/post -watch -verbose                                 $tempMsg
    rm $tempFile $tempMsg

exit 0

############## SCRIPT ./lisa
 fromHack | sed -e 's/^[Tt][Oo]:[	 ].*$/To: lodonnellma@yahoo.com\
To: Lisa.ODonnell@genzyme.com/' -e 's/^X-message-flag:.*$/X-message-flag: IBLY-ooo-ooo/'
#fromHack | sed -e 's/^[Tt][Oo]:[	 ].*$/To: Lisa.ODonnell@genzyme.com/'
#fromHack | sed -e 's/^[Tt][Oo]:[	 ].*$/To: lodonnel@std.com/'

############## SCRIPT ./hipcrime
sed -e '/h[0-9io]pc[rl][0-9io][mn]e/s/[:!].*$/! 0000-0000/'      \
    -e '/cc*rr*ii*mm*ee*hh*ii*pp*/s/[:!].*$/! 0000-0000/'        \
    -e '/ee*mm*ii*rr*cc*pp*ii*hh*/s/[:!].*$/! 0000-0000/'        \
    -e '/hh*.ii*.pp*.cc*.rr*.ii*.mm*.ee*/s/[:!].*$/! 0000-0000/' \
    -e '/hh*.ii*.pp*.cc*.ll*.oo*.nn*.ee*/s/[:!].*$/! 0000-0000/'

############## SCRIPT ./hlog
if [ ! -f /tmp/hourlyLoggingActive ]
then
    hourly on
fi

echo "####################" `timeDateString` >>~/.hlog
cat                                          >>~/.hlog

############## SCRIPT ./hlogs
cat ~/.hlog

############## SCRIPT ./hms
date '+%H%M%S'

############## SCRIPT ./hourly
#!/bin/bash

if [ $# -eq 0 ]
then
    ls -l /tmp/hourlyLoggingActive
    exit 0
fi

if [ $1 = "on" ]
then
    touch /tmp/hourlyLoggingActive
    $0
    echo "###### ACTIVATE #############################################" | hlog
    exit 0
fi

if [ $1 = "off" ]
then
    echo "#### DEACTIVATE #############################################" | hlog
    rm -f /tmp/hourlyLoggingActive
    $0
    exit 0
fi

echo Args not understood: $@
exit 1

############## SCRIPT ./hourlyCronScript
#!/u/bin/bash
#!/opt/local/bin/bash
#!/n/viewserver/home/merlin/home2/bin/sun4/sos4/bash

if [ -e /h/mod/.hourlyLoggingActive ]
then
    echo Subject: "####" HOURLY... | mail mod >/dev/null 2>&1
fi

echo '/h/mod/local/script/hourlyCronScript >/dev/null 2>&1' | at now next hour >/dev/null 2>&1

############## SCRIPT ./amity
#fromHack | sed -e 's/^[Tt][Oo]:[	 ].*$/To: amity@romanauskas.com\
 fromHack | sed -e 's/^[Tt][Oo]:[	 ].*$/To: Amity Baldwin <amity.baldwin@gmail.com>\
X-notReally-To: anybody@else.com/'
#fromHack | sed -e 's/^[Tt][Oo]:[	 ].*$/To: Lisa.ODonnell@genzyme.com/'
#fromHack | sed -e 's/^[Tt][Oo]:[	 ].*$/To: lodonnel@std.com/'

############## SCRIPT ./.IF
echo ".if $@"
cat
echo ".endif #.if $@" | rjshc

############## SCRIPT ./IF
#echo "#define	$@	0"
echo "#if	$@"
cat
echo "#endif /* #if $@ */" | rjc

############## SCRIPT ./.IFDEF
echo ".ifdef $@"
cat
echo ".endif #.ifdef $@" | rjshc

############## SCRIPT ./IFDEF
#echo "#define	$@	0"
echo "#ifdef	$@"
cat
echo "#endif /* #ifdef $@ */" | rjc

############## SCRIPT ./ifdef
#echo "#define	$@	0"
echo "#ifdef	$@"
cat
echo "#endif /* #ifdef $@ */" | rjc

############## SCRIPT ./IFDEFE
#echo "#define	$@	0"
echo "#ifdef	$@"
cat
echo "#else             /* #ifdef $1 */" | rjc
echo "#endif      /* #else #ifdef $1 */" | rjc

############## SCRIPT ./ifdefe
#echo "#define	$@	0"
echo "#ifdef	$@"
cat
echo "#else             /* #ifdef $1 */" | rjc
echo "#endif      /* #else #ifdef $1 */" | rjc

############## SCRIPT ./.IFdefined
echo ".if defined($@)"
cat
echo ".endif #.if defined($@)" | rjshc

############## SCRIPT ./.IFdefinedE
echo ".if defined($@)"
cat
echo ".else #.if defined($@)" | rjshc
echo ".endif #.else .if defined($@)" | rjshc

############## SCRIPT ./.IFE
echo ".if $@"
cat
echo ".else #.if $@" | rjshc
echo ".endif #.else .if $@" | rjshc

############## SCRIPT ./IFE
#echo "#define	$@	0"
echo "#if $@"
cat
echo "#else             /* #if $@ */" | rjc
echo "#endif      /* #else #if $@ */" | rjc

############## SCRIPT ./ife
#echo "#define	$@	0"
echo "#if $@"
cat
echo "#else             /* #if $@ */" | rjc
echo "#endif      /* #else #if $@ */" | rjc

############## SCRIPT ./IFN
#echo "#define	$@	0"
echo "#if	!$@"
cat
echo "#endif /* #if !$@ */" | rjc

############## SCRIPT ./.IFNDEF
echo ".ifndef $@"
cat
echo ".endif #.ifndef $@" | rjshc

############## SCRIPT ./IFNDEF
#echo "#define	$@	0"
echo "#ifndef	$@"
cat
echo "#endif      /* #ifndef $1 */" | rjc

############## SCRIPT ./ifndef
#echo "#define	$@	0"
echo "#ifndef	$@"
cat
echo "#endif      /* #ifndef $1 */" | rjc

############## SCRIPT ./.IFNDEFE
echo ".ifndef $@"
cat
echo ".else #.ifndef $@" | rjshc
echo ".endif #.else .ifndef $@" | rjshc

############## SCRIPT ./IFNDEFE
#echo "#define	$@	0"
echo "#ifndef	$@"
cat
echo "#else       /* #ifndef $1 */" | rjc
echo "#endif      /* else #ifndef $1 */" | rjc

############## SCRIPT ./ifndefe
#echo "#define	$@	0"
echo "#ifndef	$@"
cat
echo "#else       /* #ifndef $1 */" | rjc
echo "#endif      /* else #ifndef $1 */" | rjc

############## SCRIPT ./.IFNdefined
echo ".if !defined($@)"
cat
echo ".endif #.if !defined($@)" | rjshc

############## SCRIPT ./.IFNdefinedE
echo ".if !defined($@)"
cat
echo ".else #.if !defined($@)" | rjshc
echo ".endif #.else .if !defined($@)" | rjshc

############## SCRIPT ./IFNE
#echo "#define	$@	0"
echo "#if !$@"
cat
echo "#else             /* #if !$@ */" | rjc
echo "#endif      /* #else #if !$@ */" | rjc

############## SCRIPT ./incWorldMailMH
#!/bin/csh -f
cd /tmp
mkdir incWorldMailMH$$
cd incWorldMailMH$$
uudecode
uncompress *
inc -file *
cd ..
rm -rf incWorldMailMH$$

############## SCRIPT ./gen
 fromHack | sed -e 's/^[Tt][Oo]:[	 ].*$/To: g_ricard2000@yahoo.com\
X-notReally-To: anybody@else.com/'
#fromHack | sed -e 's/^[Tt][Oo]:[	 ].*$/To: Lisa.ODonnell@genzyme.com/'
#fromHack | sed -e 's/^[Tt][Oo]:[	 ].*$/To: lodonnel@std.com/'

############## SCRIPT ./junkFix
#!/bin/bash
sed -e "s/´/'/g" -e 's/­/-/g' -e "s/’/'/g" -e 's/¾/1\/4/g' -e 's/é/e/g' -e 's/©/(c)/g' -e 's/ü/u/g' -e 's/®/(R)/g' -e 's/ /-/g' -e 's/·/-/g' -e 's/«/<</g' -e 's/»/>>/g' -e "s/°/'/g" -e s/í/i/g -e "s/â€™/'/g" -e 's/“/"/g' -e 's/”/"/g' -e "s/‘/'/g" -e 's;½;(1/2);g' -e 's;¼;(1/4);g' -e "s/â/'/g" -e 's/€/(0x80)/g' -e 's/˜/(0x98)/g' -e 's/Ã/(0xc3)/g' -e 's/Ÿ/(0x9f)/g'

############## SCRIPT ./keep
#!/bin/csh -f
echo "" >>$HOME/keepMailMH
cat             >>$HOME/keepMailMH
echo "" >>$HOME/keepMailMH

############## SCRIPT ./killH
sed -f ~/local/script/SED/killHeader.sed

############## SCRIPT ./julie
if [ -n "$1" ]
then
	echo To: Julie.Rohrbacher@marion.k12.fl.us
fi
#fromHack | sed -e 's/^[Tt][Oo]:[	 ].*$/To: Julie Rohrbacher <julieroh723@yahoo.com>/'
 fromHack | sed -e 's/^[Tt][Oo]:[	 ].*$/To: Julie Rohrbacher <julieroh331@yahoo.com>/'

#fromHack | sed -e 's/^[Tt][Oo]:[	 ].*$/To: Julie Rohrbacher <julieroh723@yahoo.com>, rohrbacj@marion.k12.fl.us/'

############## SCRIPT ./l2bccmnt
decomment | eat | sed 's/^ //' | bccmnt

############## SCRIPT ./lineup
# This shell script employs AWK to read through a text file, treating
# the Nth whitespace-separated token (as recognized by AWK) in each
# line as an element of the corresponding Nth tabular column.  That
# is, the Nth elements of all lines are regarded as being members of
# the Nth column of the input.
#
# After capturing stdin in a temp file, we note the widest token in
# each column, using that information to generate an AWK format string
# suitable for use during a second pass, in which we actually emit (as
# stdout) the text from that same temp file, tabularized.
#
# This version of this script is my first attempt at it - improvements
# are undoubtedly possible...
#
# HACK: supplying ANY args on the command line is regarded as a
#       request that the format string itself be displayed before
#       the results, in a form suitable for use inside VI.
#

   timeStamp=`date '+%Y%m%d%H%M%S'`
    tempFile=/tmp/$$tempFile$timeStamp
formatString=/tmp/$$format$timeStamp

cat > $tempFile

nawk ' BEGIN { fieldMax = 0 } ; { if( NF > fieldMax ) { fieldMax = NF } for( i = 1; i <= NF; ++i ) { width = length( $i ); if( width > widest[ i ] ) { widest[ i ] = width; } } } ; END { if( fieldMax > 0 ) { printf( "{ printf( \"%%-%ds", widest[ 1 ] ); if( fieldMax > 1 ) { for( i = 2; i <= fieldMax; ++i ) { printf( " %%-%ds", widest[ i ] ); } } printf( "\\n\"" ); for( i = 1; i <= fieldMax; ++i ) { printf( ", $%d", i ); } printf( " ); }\n" ); } } ' <$tempFile >$formatString

#
# Presence of args means Please Show Format String,
# so generate a complete nawk commandline from it...
#
if [ ! -z "$1" ]
then
    sed -e 's/%/\\%/g' -e "s/^/nawk '/" -e "s/$/ '/" <$formatString
fi

nawk -f $formatString <$tempFile | sed -e 's/[	 ][	 ]*$//'

rm   -f $formatString  $tempFile

############## SCRIPT ./lineupgrep
sed -e 's/:/: /' | lineup1

############## SCRIPT ./fancyBASHscript

###############################################################################
# Given the specified hierarchy(s) where RPM files are to be found,
# we populate a dataBase with records for each file, obtained using
# rpm queries.  We then ask rpm to describe its current notion of all
# packages that are actually installed on the machine where
# we're executing, independent of those specified RPM files.  Finally we
# attempt to correlate each package RPM believes is installed with one
# of the entries in our dataBase and report the corresponding RPM file.
###############################################################################
###############################################################################
# Layout of the dataBase[] triples:
# basicPkgName elaboratedPkgName RPMfileName

declare -a dataBase=("")             # In case anybody doubts this is an array.

###############################################################################
function dbTripleForKey()  {
    if [ $# -ne 2 ]
    then
        failed "Internal error in $FUNCNAME() - need fieldIndex and key"
    fi

    index=0
    while [ $index -lt ${#dataBase[*]} ]          # Until indexLimit reached...
    do
        triple=( ${dataBase[$index]} )       # Index the database for a triple.
        case "$1" in
        1|2|3)
            if [ ${triple[$[$1 - 1]]} = $2 ]        # Index triple for a field.
            then
#               echo "$triple"
                echo ${dataBase[$index]}
                return 0                         # First hit terminates search.
            fi
            ;;
        *)
            failed "$FUNCNAME() - bogus key value specified"
            ;;
        esac

        let index++
    done
    return 1
}

###############################################################################
function tripleForBasicPkgName()  {
    if [ $# -ne 1 ]
    then
        failed "Internal error in $FUNCNAME() - must specify basicPkgName"
    fi

    dbTripleForKey 1 $1                               # Field 1 is basicPkgName
}

###############################################################################
function tripleForElaboratedPkgName()  {
    if [ $# -ne 1 ]
    then
        failed "Internal error in $FUNCNAME() - must specify elaboratedPkgName"
    fi

    dbTripleForKey 2 $1                          # Field 2 is elaboratedPkgName
}

###############################################################################
function tripleForRPMfileName()  {
    if [ $# -ne 1 ]
    then
        failed "Internal error in $FUNCNAME() - must specify RPMfileName"
    fi

    dbTripleForKey 3 $1                                # Field 3 is RPMfileName
}

###############################################################################
function dbCountOfField()  {
    local instances

    if [ $# -ne 2 ]
    then
        failed "Internal error in $FUNCNAME() - need fieldIndex and key"
    fi

    index=0
    instances=0
    while [ $index -lt ${#dataBase[*]} ]
    do
        triple=( ${dataBase[$index]} )       # Index the database for a triple.
        case "$1" in
        1|2|3)
            if [ ${triple[$[$1 - 1]]} = $2 ]        # Index triple for a field.
            then
                let instances++
            fi
            ;;
        *)
            failed "BOGUS key value specified"
            ;;
        esac

        let index++
    done

    echo $instances
    return 0
}

###############################################################################
function dbCountOfBasicPkgName()  {
    dbCountOfField 1 $1                               # Field 1 is basicPkgName
}

###############################################################################
function dbCountOfElaboratedPkgName()  {
    dbCountOfField 2 $1                          # Field 2 is elaboratedPkgName
}

###############################################################################
function dbCountOfRPMfileName()  {
    dbCountOfField 3 $1                                # Field 3 is RPMfileName
}

###############################################################################
function allBasicPkgNames()  {
    index=0
    while [ $index -lt ${#dataBase[*]} ]
    do
        triple=( ${dataBase[$index]} )
        echo ${triple[0]}
        let index++
    done
}

###############################################################################
function allElaboratedPkgNames()  {
    index=0
    while [ $index -lt ${#dataBase[*]} ]
    do
        triple=( ${dataBase[$index]} )
        echo ${triple[1]}
        let index++
    done
}

###############################################################################
function allRPMfileNames()  {
    index=0
    while [ $index -lt ${#dataBase[*]} ]
    do
        triple=( ${dataBase[$index]} )
        echo ${triple[2]}
        let index++
    done
}

###############################################################################
function allDataBaseEntries()  {
    index=0
    while [ $index -lt ${#dataBase[*]} ]
    do
        echo ${dataBase[$index]}
        let index++
    done
}

###############################################################################
function addDBentry()  {
    if [ $# -ne 3 ]
    then
        failed "Internal error - $FUNCNAME() needs basicPkgName elaboratedPkgName RPMfileName "
    fi

    dataBase[${#dataBase[*]}]="$1 $2 $3"
}

###############################################################################
function addDBentryUnique()  {
    local count

    if [ $# -ne 3 ]
    then
        echo "Internal error - $FUNCNAME() needs basicPkgName elaboratedPkgName RPMfileName "
        exit 1
    fi

    count=`dbCountOfBasicPkgName $1`
    if [ $count -ne 0 ]
    then
        echo "MULTIPLE($[$count+1]) instances of basicPkgName $1 in DB"      1>&2
#       return 1
    fi

    count=`dbCountOfElaboratedPkgName $2`
    if [ $count -ne 0 ]
    then
        echo "MULTIPLE($[$count+1]) instances of elaboratedPkgName $2 in DB" 1>&2
#       return 1
    fi

    count=`dbCountOfRPMfileName $3`
    if [ $count -ne 0 ]
    then
        echo "MULTIPLE($[$count+1]) instances of RPMfileName $3 in DB"       1>&2
#       return 1
    fi

    addDBentry "$1" "$2" "$3"
}

###############################################################################
function gatherRPMinfoRootedAt()  {
    local basicPkgName
    local elaboratedPkgName
    local RPMfileName

    if [ $# -ne 1 ]
    then
        echo "Internal error in $FUNCNAME() - need startingDirectory"
        exit 1
    fi

    cd $1 || failed "Can't cd $1"
    for RPMfileName in `find . -type f -name '*.rpm' | sed -e s/..// `
    do
             basicPkgName="`rpm -q --queryformat '%{NAME}'                                         -p $RPMfileName 2>/dev/null`"
        elaboratedPkgName="`rpm -q --queryformat '%{NAME}-%{VERSION}-%{RELEASE}-%{SERIAL}-%{ARCH}' -p $RPMfileName 2>/dev/null`"
        addDBentryUnique $basicPkgName $elaboratedPkgName $RPMfileName

        if [ -n "$showDots" ]                                      # Debugging.
        then
            echo -n .
        fi
        if [ -n "$announcePkgs" ]                                  # Debugging.
        then
            echo $basicPkgName
        fi
    done
}

###############################################################################
# True execution actually begins here...
#

startingDirs=""
dumpDataBase=""
announcePkgs=""
    showDots=""

currentOptArg=""
while :
do
    getopts "d:b3a." currentOptArg

    case "$currentOptArg" in
    '?')                                                # End of supplied args.
        break
        ;;
    b)                                                       # debugging output
        set -x
        ;;
    '.')                                                # Show progress dots...
        showDots="setFromCommandLine"
        ;;
    3)                                                       # Show all triples
        dumpDataBase="setFromCommandLine"
        ;;
    a)                     # Announce simple package names as they're processed
        announcePkgs="setFromCommandLine"
        ;;
    d)
        startingDirs="$startingDirs $OPTARG"
        ;;
    *)
        failed "Unexpected commandline parameter: $currentOptArg"
        ;;
    esac
done

if [ -z "$startingDirs" ]
then
    failed No startingDirs specified
fi

for dir in $startingDirs
do
    gatherRPMinfoRootedAt $dir
done

if [ -n "$dumpDataBase" ]
then
    echo "###################### allDataBaseEntries #####################################"
    allDataBaseEntries
    echo "###############################################################################"
fi

for elaboratedPkgName in `rpm -q -a --queryformat '%{NAME}-%{VERSION}-%{RELEASE}-%{SERIAL}-%{ARCH} ' 2>/dev/null`
do
    if [ -n "$announcePkgs" ]
    then
        echo -n "$elaboratedPkgName     "
    fi

    triple=( `tripleForElaboratedPkgName $elaboratedPkgName` )
    if [ $? -eq 0 ]                      # Found elaboratedPkgName in question?
    then
        echo ${triple[2]}                   # utter corresponding RPM filename.
    else
        echo "Couldn't find RPM file for package $elaboratedPkgName" 1>&2
    fi
done

exit 0

############## SCRIPT ./lineupHASH
rq ' ' | eat | sed -e 's/ $//' -e 's/^ #/#/' -e 's/^ /@/' | lineup | sed -e 's/@/ /'

############## SCRIPT ./Note
function fail()  {
	echo FAIL: "$@"
	exit 1
}

timeStamp=`timeDateString` || fail timeDateString
cd ~
echo "########NOTE########" Recording comments for Note $timeStamp...
echo "########NOTE########" $timeStamp >>~/.NoteDir/$timeStamp
cat >>.NoteDir/$timeStamp
echo "########NOTE########" Completed comments for Note $timeStamp
uuencode .NoteDir/$timeStamp < .NoteDir/$timeStamp
#echo "" ; echo 'pushd ~ ; uudecode --output-file=/dev/stdout | tar xvzf - ; popd'
 echo "" ; echo 'pushd ~ ; uudecode ; popd'

############## SCRIPT ./loversoSBlinks
#!/bin/sh

# In sb/loverso/ad2/b7:
#	O -> ../../O/ad2/b7
#	export -> O/export
#	link -> /afs/ri/project/kernel/build/ad2b7
#	obj -> O/obj
#	rc_files
#	src
#	tools
#
# In sb/obj/loverso/ad2/b7:
#	S -> ../../S/ad2/b7
#	export
#	link -> S/link
#	obj
#	rc_files -> S/rc_files
#	src -> S/src
#	tools -> S/tools
#
# Assumes these symlinks:
# sb/loverso/O -> ../obj/loverso
# sb/obj/loverso/S -> ../../loverso

if [ ${WORKON-0} = 0 ]
then
	# not really true, but it assures us that everything is correct
	echo "Must be in a workon"
	exit 1
fi

SB=`sbinfo sandbox_base`

if [ ! -d $SB ]
then
	echo "Can't find sandbox base, $SB"
	exit 1
fi

cd $SB
sb=`basename $SB`

rmdir export/at386 export obj/at386 obj || exit

mkdir ../../O/ad2/$sb
ln -s ../../O/ad2/$sb O
ln -s O/obj O/export .

cd O

ln -s ../../S/ad2/$sb S
ln -s S/link S/rc_files S/src S/tools .
mkdir -p export/at386 obj/at386

exit 0

############## SCRIPT ./mailqWatch
while :
do
    mv /tmp/mailqLog1 /tmp/mailqLog0
    mailq | eat | fmt -1 | fgrep @ | sort -fdu >/tmp/mailqLog1
    diff /tmp/mailqLog*
    echo "########################"`date`
done

############## SCRIPT ./pattie
 fromHack | sed -e 's/^[Tt][Oo]:[	 ].*$/To: Pattie <PLanier17@aol.com>/'

############## SCRIPT ./makeFolderList
#!/bin/csh -f
set verbose
cd $HOME/.mail
if ( -f context ) then
    rm context
endif
set MAILDIR=$cwd
touch .dummyFile$$
rm `find . -type f | fgrep /.`
find . -type d | sed 's/^\.\///'     >>$MAILDIR/.folders
cd ccur/OSPREY
touch .dummyFile$$
rm `find . -type f | fgrep /.`
find . -type d | sed 's/^\./ccur\/OSPREY/' >>$MAILDIR/.folders
cd $MAILDIR
sort -u <$MAILDIR/.folders | fgrep -vx . >$MAILDIR/.folders$$
mv $MAILDIR/.folders$$ $MAILDIR/.folders

############## SCRIPT ./make-rmt
#!/bin/sh
#
# Our (old) pmake uses
#	MAKERMTHOSTS MAKERMTBASE MAKERMTUSER MAKERMTPROG MAKERMTENV
# And sets up this for each invocation
#	AUTHCOVER_HOST
#	(AUTHCOVER_{TESTDIR,USER} are MAKERMT{BASE,USER})
# and calls us with these args:
#	-t1 2 exec <cwd> <filename of env>
# when it wants shell meta chars expanded, it appends this to the above:
#	sh -ec
#
# If AUTHCOVER_TESTDIR is NULL, it is assumed that all pathnames are global
# and the remote side cd's to the cwd of this process.
# O/W, for each build, the remote side will cd to
#	$AUTHCOVER_TESTDIR/<cwd arg>
#
# I.e., if your objects are in AFS (AND in an obj.<user> volume), use:
#	setenv MAKERMTBASE ""
# If your objects are on a local disk on machine <foo>, you end up using
# this after you workon:
#	setenv MAEKRMTBASE /net/`hostname`/`sbinfo object_base`
#
# Alternately, this script understands MAKERMTPREFIX, which is more useful,
# since it isn't build/sandbox specific:
#	setenv MAEKRMTBASE /net/`hostname`
#

env=$5 rel=$4
shift 5

case $1$2$# in
sh-ec3)		shift 2; eval file=\${$###"* "};;
sh-c3)		shift 2; eval file=\${$###"* "};;
*)		eval file=\${$#};;
esac

echo $@

case $@ in
if\ *)
	eval $@
	exit $?;;
true|false|cat\ *|echo\ *|mv\ *|rm\ *|cp\ *|makepath\ *|mkdir\ *|sed\ *|m4\ *)
	eval exec $@;;
esac

from=`hostname`
case $MAKERMTPREFIX in
'')	case $AUTHCOVER_TESTDIR in
	'')	wd=`pwd` afs=true;;
	*)	wd=$AUTHCOVER_TESTDIR/$rel;;
	esac;;
*)	wd=$MAKERMTPREFIX/`pwd`
esac

(
	echo _src=\"$AUTHCOVER_USER@$from/$$\" _wd=$wd
	cat <<- 'EOF'
		echo @@@ on `hostname`/$$ 1>&2
		( umask 0 ; touch /tmp/remotebuildlog >/dev/null 2>/dev/null) &
		cd $_wd
		cat > /tmp/makeenv.$$ << "..EOF"
	EOF
	sed -e  's/^\([^=]*\)=\(.*\)$/\1='\''\2'\''; export \1/' $env
	cat <<- 'EOF'
		..EOF
		. /tmp/makeenv.$$
		rm /tmp/makeenv.$$
	EOF
	echo set \'"$@"\'
	cat <<- 'EOF'
		echo "$_src start $$ `date` in $_wd $@" >> /tmp/remotebuildlog
		eval "$@" 2>&1
		echo EXITSTAT=$?
		echo "$_src end   $$ `date`" >> /tmp/remotebuildlog
	EOF
	#echo "$@" '2>&1'
) | (
	echo @@@ from $from/$$ to $AUTHCOVER_HOST $AUTHCOVER_USER of $file
	rsh $AUTHCOVER_HOST -l $AUTHCOVER_USER /bin/nice -4 sh -e >/tmp/makermt.$$ 2>&1
)
ret=`tail -1 /tmp/makermt.$$`
case $ret in
EXITSTAT=*)
	eval $ret
	sed '$d' /tmp/makermt.$$
	;;
*)
	EXITSTAT=1
	cat /tmp/makermt.$$
	;;
esac
rm /tmp/makermt.$$

# suck object into local AFS cache for faster linking
${afs-false} && case $file in
*.o)	if [ -f $file ]; then
		cat $file > /dev/null &
	fi;;
esac

exit $EXITSTAT

############## SCRIPT ./make-rmt-logs
#!/bin/sh
#

G='NF == 3 { user[$2] += $1 ; sys[$3] += $1}
END {
	for (s in sys) {
		printf "%5d %s\n", sys[s], s
	}
	printf "\n"
	for (u in user) {
		printf "%5d %s\n", user[u], u
	}
}'
POST='gawk "$G"'

op=sum

for a
do
	case $a in
	-rm)	op=rm POST='cat -u';;
	-ls)	op=ls POST='cat -u';;
	-start)	op=start POST='cat -u';;
	*)	break 2;;
	esac
	shift
done

(
c=0
for m in ${@-`hostname`}
do
	echo $m 1>&2
	case $op in
	start)	rsh $m -n sed -n -e \''1s/ in .*//p'\' -e 2q \
			/tmp/remotebuildlog
		;;
	ls)	rsh $m -n ls -l /tmp/remotebuildlog
		;;
	rm)	rsh $m -n sudo rm -f /tmp/remotebuildlog
		;;
	sum)	rsh $m sh -e <<- 'EOF'
			< /tmp/remotebuildlog gawk 'BEGIN {FS=" |/[0-9]"}
				$3 == "start" { print $1, "'`hostname`'" }' |
			sort | uniq -c
			EOF
		;;
	esac &

	c=`expr $c + 1`
	case $c in
	10)     sleep 1; c=0;;
	esac
done
wait
) | eval $POST

############## SCRIPT ./make-rmt-setup
#!/bin/sh

#
# Normally, execute John's stuff directly.  Otherwise,
# fall back to the stuff below.
#

~loverso/local/bin/make-rmt-setup

# PATH=$PATH:/afs/ri/user/loverso/local/bin
#
# # Build machine hosts
# build=`randomize sheilds rhodes soling allegro build1 libra1`
#
# # Unused workstations
# unused=`randomize doctor enchilada wayback lance`
# # bflo  (sometimes runs OS/2??)
#
# # Under used workstations
# underused=`randomize it gamma ferris`
#
# # workstations in offices
# office=`randomize '
# 	cassis scorpio tesla leppard griffin camaro hobie giotto
# 	firebird genesis mannex ziti wasabi ouch rebootme
# 	meenie pugsley toody sirius ibupuma
# 	york brunel ghoti condor quadrivium
# '`
#
# hostname=`hostname`
# makehosts=`echo $build $unused $underused | sed -e "s/ *$hostname */ /"`
#
# cat 1>&2 << EOF
# hosts:
# $makehosts
#
# Use "klog-all -f hosts..." to get tokens
# Use "tokens-all hosts..." to check tokens
#
# EOF
#
# case $SHELL in
# *csh)	cat << EOF
# set makehosts=($makehosts)
#
# setenv MAKERMTHOSTS \`echo \$makehosts | tr ' ' :\`
# setenv MAKERMTPROG ~loverso/local/bin/make-rmt
# setenv MAKERMTUSER \$USER
# setenv MAKERMTBASE ""
#
# # If your objects are in AFS, do nothing more.
# # If your objects are on your local disk, uncomment this
# #setenv MAKERMTPREFIX /net/$hostname
# EOF
# 	;;
# *)	cat << EOF
# makehosts="$makehosts"
#
# MAKERMTHOSTS=\`echo \$makehosts | tr ' ' :\`
# MAKERMTPROG=/afs/ri/user/loverso/local/bin/make-rmt
# MAKERMTUSER=\$USER
# MAKERMTBASE=""
# export MAKERMTHOSTS MAKERMTPROG MAKERMTUSER MAKERMTBASE
#
# # If your objects are in AFS, do nothing more.
# # If your objects are on your local disk, uncomment this
# #MAKERMTPREFIX=/net/$hostname; export MAKERMTPREFIX
# EOF
# 	;;
# esac
#
# cat << EOF
#
# echo "Use these options to build/make:		-j7 -L2"
# echo "Be sure your ~/.rhosts has this line in it:	$hostname"
#
# # You only need to do this once, but it will let you know that all the
# # hosts are up.
# echo ""
# echo "^C if you've already klog'd today"
# echo "^C if you've already klog'd today"
# klog-all -f \$makehosts
# EOF

############## SCRIPT ./makeSBcscopeList
#!/bin/csh -f
#
#
#

set here=`basename $cwd`
if ( $here != "src" ) then
    echo "This only works in the src directory of your sandbox"
    exit 1
endif

if ( ! -f sbFileList ) then
    echo "Can't find sbFileList - try makeSBfileList"
    exit 1
endif

#
# Preserve any existing cscope.files-file if found in the current directory.
#
if ( -f cscope.files ) then
    set count=0
    set save="cscope.files0"
    while ( -f $save )
        @ count ++
        set save="cscope.files"$count
    end
    echo "Preserving existing cscope.files file as $save..."
    mv cscope.files $save || exit 1
endif

grep '\.h$' sbFileList | findSBfile | sed -e 's/\/\.\//\//'  >cscope.files
grep '\.c$' sbFileList | findSBfile | sed -e 's/\/\.\//\//' >>cscope.files

echo "###### Result in cscope.files"

exit 0

############## SCRIPT ./makeSBdirList
#!/bin/csh -f
#
# Build a list of files which is the inclusive-OR of all the files
# in all the trees associated with this sandbox, including all
# files in all backing trees.  All generated filenames are
# relative to the "src" directory in a "normal" sandbox hierarchy.
#

onintr cleanUp

set allDirs=/tmp/allDirs$$

set here=`basename $cwd`
if ( $here != "src" ) then
    echo "This only works in the src directory of your sandbox"
    exit 1
endif

set startDir=$cwd

#
# Preserve an existing sbDirList-file if found in the current directory.
#
if ( -f sbDirList ) then
    set count=0
    set save="sbDirList0"
    while ( -f $save )
        @ count ++
        set save="sbDirList"$count
    end
    echo "Preserving existing sbDirList file as $save..."
    mv sbDirList $save || exit 1
endif

while ( 1 )
    echo    "####### Collecting files in $cwd"
    echo -n "####### " ; pwd
    find . -type d $argv -print >>$allDirs
    if ( ! -d ../link/src ) then
        break
    endif
    cd ../link/src
end

#
# Now sort the sbDirList file, placing results into the final sbDirList
#
cd $startDir
sort -u <$allDirs >sbDirList

echo "###### Result in sbDirList"

#
# One way or another, we're done.
#
cleanUp:
rm -f          \
    $allDirs    \

############## SCRIPT ./makeSBfileList
#!/bin/csh -f
#
# Build a list of files which is the inclusive-OR of all the files we can
# find in this sandbox including all the backing trees we can find in via
# the "link" entries.  All generated filenames are relative to the "src"
# directory in a "normal" sandbox hierarchy.
#

onintr cleanUp

set here=`basename $cwd`
if ( $here != "src" ) then
    echo "This only works in the src directory of your sandbox"
    exit 1
endif

set startDir=$cwd

set testFile=testFile$$
touch $testFile  || \
    ( echo "########## Can't write file $testFile" ; \
    set resultFile=sbFileList )
rm -f $testFile

set tempFile=/tmp/tempFile$$
if ( "_$argv" == "_" ) then
    set resultFile=sbFileList
else
    set resultFile=$argv
endif

#
# Preserve an existing sbFileList-file if found in the current directory.
#

if ( -f sbFileList ) then
    set count=0
    set save="sbFileList0"
    while ( -f $save )
        @ count ++
        set save="sbFileList"$count
    end
    echo "Preserving existing sbFileList file as $save..."
    mv sbFileList $save || exit 1
endif

while ( 1 )
    echo    "####### Collecting files in $cwd"
    echo -n "####### " ; pwd
    find . -type f -print >>$tempFile
    if ( ! -d ../link/src ) then
        break
    endif
    cd ../link/src
end

#cd $startDir
#cd $OBJECTDIR
#echo    "####### Collecting files in $cwd"
#find $cwd -type f -print >>$tempFile
#cd $EXPORTBASE
#echo    "####### Collecting files in $cwd"
#find $cwd -type f -print >>$tempFile

#
# Now sort the sbFileList file, placing results into the final sbFileList
#
cd $startDir
sort -u <$tempFile >$resultFile

echo "###### Result in $resultFile"

#
# One way or another, we're done.
#
cleanUp:
rm -f          \
    $tempFile   \

############## SCRIPT ./makeSBtags
#!/bin/csh -f
onintr cleanUp

set allTags=/tmp/allTags$$
set ctagsOutput=/tmp/ctagsOut$$

#
# Preserve an existing tags-file if found in the current directory.
#
if ( -f tags ) then
    set count=0
    set save="SAVEDtags0"
    while ( -f $save )
        @ count ++
        set save="SAVEDtags"$count
    end
    echo "Preserving existing tags file as $save..."
    mv tags $save || exit 1
endif

while ( 1 )
    set file=($<)
    if ( $file == "" ) then
        break
    endif
    echo "############ Collecting tags for $file"
    ctags -f $ctagsOutput $file
    if ( -f $ctagsOutput ) then
        cat $ctagsOutput >>$allTags
        rm $ctagsOutput
    endif
end

#
# Now sort the tags file, placing the results into the final tags-file.
#
sort -u <$allTags >tags

#
# One way or another, we're done.
#
cleanUp:
rm -f          \
    $allTags    \
    $ctagsOutput \

############## SCRIPT ./man2ascii
#!/bin/csh -f
nroff -man $argv | sed -e 's/_//g' -e 's/.//g'

############## SCRIPT ./148siestaDrive
cat <<EOF
From:             148siestaDrive@comcast.net
Mail-Followup-To: 148siestaDrive@comcast.net
Mail-Reply-To:    148siestaDrive@comcast.net
Reply-To:         148siestaDrive@comcast.net
cc:               148siestaDrive@comcast.net
To:
Subject:

Greetings,

Thanks for you interest in the property - which
additional items of information would you like?

  --Michael O'Donnell

 http://148siestaDrive.home.comcast.net/

EOF

############## SCRIPT ./math
while read input
do
    echo "$input" = ` echo "$input" | bc -l `
done

############## SCRIPT ./freecycle
   timeStamp=`date '+%Y%m%d%H%M%S'`
    tempFile=/tmp/$$tempFile$timeStamp
formatString=/tmp/$$format$timeStamp

cat > $tempFile

grep -i	-e '^from:'	\
	-e '^to:'	\
	-e '^subject:'	\
	-e '^Mail-Followup-To:'	\
	-e '^Mail-Reply-To:'	\
	-e '^Reply-To:'	\
	-e '^cc:' <$tempFile
cat <<EOF
From:             KittensAndFlowers@comcast.net
Mail-Followup-To: KittensAndFlowers@comcast.net
Mail-Reply-To:    KittensAndFlowers@comcast.net
Reply-To:         KittensAndFlowers@comcast.net
X-maybe-cc:       KittensAndFlowers@comcast.net
To: freecycleLowellMA@yahoogroups.com

EOF

if [ -n "$1" ]
then
cat <<EOF

Your response was the first of those I've received so
I'll offer the item to you first.  I have left it in a
bag hanging from the lamp by the lower door at 67 Prescott
Drive, North Chelmsford.  Here's a map:

  http://kittensandflowers.home.comcast.net/kittensandflowers.jpg

Unless you contact me to make special arrangements, please
understand that I will offer the item to the others who responded
if it's allowed to remain there for long.  Here's hoping you are
able to make good use of it, and I'll see you on Freecycle!

  --KittensAndFlowers@comcast.net

In North Chelmsford near Drum Hill/Laughton's.

Here's a map:

  http://kittensandflowers.home.comcast.net/kittensandflowers.jpg

...and here's a phone number:

   978-251-7576

I have left it by our lower door where nobody will bother it.

When would you like to pick it up?

  --Michael O'Donnell

##############################################################
NOTICE: You are welcome to the item(s) being offered as long
	as you understand that you are expected to respond to
	emails promptly and to *SHOW UP* at the agreed-upon time
	and place to collect the item(s).  If you are one of
	those people who mistakenly believe that inconsiderate
	behavior is OK during FreeCycle transactions then
	please don't bother responding to this posting...
##############################################################

EOF
fi

rm   -f $tempFile

############## SCRIPT ./mhDelete
echo "#### $@"                                >>/tmp/mhDeleteLOG
echo $PWD                                     >>/tmp/mhDeleteLOG
folder                                        >>/tmp/mhDeleteLOG
refile +deleted -nolink -normmproc -unlink $@ >>/tmp/mhDeleteLOG

############## SCRIPT ./MHencapsulate
echo ""
cat
echo ""

############## SCRIPT ./albert
cat <<EOF
                   haim@emc.co.il,
               adams_marc@emc.com,
                  asarkar@emc.com,
                   barrow@emc.com,
                   bniver@emc.com,
            borges_carlos@emc.com,
       brommelhoff_jurgen@emc.com,
                   daphna@emc.com,
                      dar@emc.com,
            fisher_michel@emc.com,
                  frymsha@emc.com,
              gupta_reema@emc.com,
            johnson_gemma@emc.com,
              lacey_peter@emc.com,
                   leshem@emc.com,
                 lkrigovs@emc.com, == UNIX    email == RIGHT
          krigovski_louis@emc.com, == Windows email == WRONG
              merrill_len@emc.com,
             mills_milton@emc.com,
            moore_richard@emc.com,
              Murphy_John@emc.com,
             nagiel_yoram@emc.com,
              porat_betti@emc.com,
                    qsong@emc.com,
               quinn_john@emc.com,
                 reckerso@emc.com,
          richardson_judy@emc.com,
          schwarm_stephen@emc.com,
             shriki_moshe@emc.com,
            shulman_roman@emc.com,
                 smcclure@emc.com,
                      sne@emc.com,
                  sne_gal@emc.com,
              tung_victor@emc.com,
                     uday@emc.com,
                wang_yiqi@emc.com,
          wheeler_richard@emc.com,
            whiffin_kevin@emc.com,
                    wwong@emc.com,
                     zzhu@emc.com,
              eitan@galileo.co.il,
               gidi@galileo.co.il,
                gil@galileo.co.il,
             rabeeh@galileo.co.il,
            rshmuel@galileo.co.il,
                 ann@galileoT.com,
             goldish@galileoT.com,
                mana@galileoT.com,
               noaml@galileoT.com,
               scott@galileoT.com,
                sdas@galileoT.com,
             support@galileoT.com,
               terri@galileoT.com,
               viren@galileoT.com,
  albert@MissionCriticalLinux.com,
 baboval@MissionCriticalLinux.com,
  barrow@MissionCriticalLinux.com,
   burke@MissionCriticalLinux.com,
    carr@MissionCriticalLinux.com,
   chung@MissionCriticalLinux.com,
 clemens@MissionCriticalLinux.com,
coughlan@MissionCriticalLinux.com,
  denham@MissionCriticalLinux.com,
flanagan@MissionCriticalLinux.com,
 griffis@MissionCriticalLinux.com,
   huber@MissionCriticalLinux.com,
     mod@MissionCriticalLinux.com,
 ofsthun@MissionCriticalLinux.com,
thompson@MissionCriticalLinux.com,
               bj.nima@qlogic.com,
EOF

############## SCRIPT ./bonding-devel
cat <<EOF
From:             "Michael ODonnell" <lucid+bonding-devel@skeptics.org>
Mail-Followup-To: bonding-devel@lists.sourceforge.net
Mail-Reply-To:    "Michael ODonnell" <lucid+bonding-devel@skeptics.org>
Reply-To:         bonding-devel@lists.sourceforge.net
To: bonding-devel@lists.sourceforge.net
Subject:
EOF

############## SCRIPT ./validate
#
#
#!/usr/local/bin/bash-2.0

test -z "$BASH_VERSINFO" && exec /usr/local/bin/bash-2.0 < "$0"

domain=(	\
	"biz"	\
	"com"	\
	"co.uk"	\
	"edu"	\
	"info"	\
	"mil"	\
	"name"	\
	"net"	\
	"org"	\
	"tv"	\
    )

alpha=(		\
	"A"	\
	"B"	\
	"C"	\
	"D"	\
	"E"	\
	"F"	\
	"G"	\
	"H"	\
	"I"	\
	"J"	\
	"K"	\
	"L"	\
	"M"	\
	"N"	\
	"O"	\
	"P"	\
	"Q"	\
	"R"	\
	"S"	\
	"T"	\
	"U"	\
	"V"	\
	"W"	\
	"X"	\
	"Y"	\
	"Z"	\
	"a"	\
	"b"	\
	"c"	\
	"d"	\
	"e"	\
	"f"	\
	"g"	\
	"h"	\
	"i"	\
	"j"	\
	"k"	\
	"l"	\
	"m"	\
	"n"	\
	"o"	\
	"p"	\
	"q"	\
	"r"	\
	"s"	\
	"t"	\
	"u"	\
	"v"	\
	"w"	\
	"x"	\
	"y"	\
	"z"	\
	" "	\
	" "	\
	" "	\
	" "	\
	" "	\
	" "	\
	" "	\
	" "	\
	" "	\
	" "	\
	" "	\
	" "	\
    )

###############################################################################
function randomNumberRange()  {                                      # Min, Max
    local size

    if [ $1 -gt $2 ]
    then
        return 0
    fi

    size=$[$2 - $1]
    size=$[$size + 1]
    size=$[$RANDOM % $size]
    echo $[$1 + $size]
    return 0
}

###############################################################################
function randomDigit()  {
    randomNumberRange 0 9
    return 0
}

###############################################################################
function randomAlpha()  {
    echo "${alpha[$RANDOM % (${#alpha[*]} - 12)]}"
    return 0
}

###############################################################################
function randomHexAlpha()  {
    echo "${alpha[$RANDOM % 6]}"
    return 0
}

###############################################################################
function randomAlphaWhite()  {
    echo "${alpha[$RANDOM % ${#alpha[*]}]}"
    return 0
}

###############################################################################
# Recursive, which is cute but EXTREMELY slow with
# large strings - S/B rewritten as a loop...
#
function randomAlphaNumStringSized()  {                                # Length
    local i

    if [ $# -ne 1 ]
    then
        echo "Error in $FUNCNAME() - need length"
        exit 1
    fi

    if [ $1 -lt 1 ]
    then
        return 0
    fi
    if [ $1 -gt 1 ]
    then
        if [ $[$RANDOM % 2] -eq 0 ]
        then
            echo "`randomAlphaNumStringSized $[$1 - 1]``randomAlpha`"
        else
            echo "`randomAlphaNumStringSized $[$1 - 1]``randomDigit`"
        fi

        return 0
    fi

    randomAlpha
    return 0
}

###############################################################################
function randomAlphaNumStringSizeRange()  {                          # Min, Max
    randomAlphaNumStringSized `randomNumberRange $1 $2`
    return 0
}

###############################################################################
# Recursive, which is cute but EXTREMELY slow with
# large strings - S/B rewritten as a loop...
#
function randomHexStringSized()  {                                     # Length
    local i

    if [ $# -ne 1 ]
    then
        echo "Error in $FUNCNAME() - need length"
        exit 1
    fi

    if [ $1 -lt 1 ]
    then
        return 0
    fi

    if [ $[$RANDOM % 2] -eq 0 ]
    then
        echo "`randomHexStringSized $[$1 - 1]``randomHexAlpha`"
    else
        echo "`randomHexStringSized $[$1 - 1]``randomDigit`"
    fi

    return 0
}

###############################################################################
function randomHexStringSizeRange()  {                               # Min, Max
    randomHexStringSized `randomNumberRange $1 $2`
    return 0
}

###############################################################################
# Recursive, which is cute but EXTREMELY slow with
# large strings - S/B rewritten as a loop...
#
function randomTokenStringSized()  {                                   # Length
    local i

    if [ $# -ne 1 ]
    then
        echo "Error in $FUNCNAME() - need length"
        exit 1
    fi

    if [ $1 -lt 1 ]
    then
        return 0
    fi
    if [ $1 -gt 1 ]
    then
        if [ $[$RANDOM % 2] -eq 0 ]
        then
            echo "`randomTokenStringSized $[$1 - 1]``randomAlphaWhite`"
        else
            echo "`randomTokenStringSized $[$1 - 1]``randomDigit`"
        fi

        return 0
    fi

    randomAlpha
    return 0
}

###############################################################################
function randomTokenStringSizeRange()  {                             # Min, Max
    randomTokenStringSized `randomNumberRange $1 $2`
    return 0
}

###############################################################################
# Recursive, which is cute but EXTREMELY slow with
# large strings - S/B rewritten as a loop...
#
function randomAlphaStringSized()  {                                   # Length
    local i

    if [ $# -ne 1 ]
    then
        echo "Error in $FUNCNAME() - need length"
        exit 1
    fi

    if [ $1 -lt 1 ]
    then
        return 0
    fi
    if [ $1 -gt 1 ]
    then
        echo "`randomAlphaStringSized $[$1 - 1]``randomAlpha`"
        return 0
    fi

    randomAlpha
    return 0
}

###############################################################################
function randomAlphaStringSizeRange()  {                             # Min, Max
    randomAlphaStringSized `randomNumberRange $1 $2`
    return 0
}

###############################################################################
# Recursive, which is cute but EXTREMELY slow with
# large strings - S/B rewritten as a loop...
#
function randomDigitStringSized()  {                                   # Length
    local i

    if [ $# -ne 1 ]
    then
        echo "Error in $FUNCNAME() - need length"
        exit 1
    fi

    if [ $1 -lt 1 ]
    then
        return 0
    fi
    if [ $1 -gt 1 ]
    then
        echo "`randomDigitStringSized $[$1 - 1]``randomDigit`"
        return 0
    fi

    randomDigit
    return 0
}

 #    #  #####  #####  #####
 #    #    #      #    #    #
 ######    #      #    #    #
 #    #    #      #    #####
 #    #    #      #    #
 #    #    #      #    #

###############################################################################
function randomDigitStringSizeRange()  {                             # Min, Max
    randomDigitStringSized `randomNumberRange $1 $2`
    return 0
}

###############################################################################
function randomDomainString()  {
    echo "${domain[$RANDOM % ${#domain[*]}]}"
    return 0
}

###############################################################################
function randomAmpersandURLdomain()  {
    echo "${ampersandURLdomain[$RANDOM % ${#ampersandURLdomain[*]}]}"
    return 0
}

###############################################################################
function glucoURL()  {
    printf 'http://glucocontrol.undersociety.com/cuentamail.php?i=EN&m=%s@%s.%s.%s&id=SP%d_%d_03' `randomAlphaNumStringSizeRange 3 10` `randomAlphaNumStringSizeRange 3 10` `randomAlphaNumStringSizeRange 3 10` `randomDomainString` `randomNumberRange 1 28` `randomNumberRange 1 12`
    return 0
}

###############################################################################
function gamingURL()  {
    printf "http://62.58.187.45:81/CT%08d%s@%s.%s.%s.HTML" $RANDOM `randomAlphaNumStringSizeRange 3 10` `randomAlphaNumStringSizeRange 3 10` `randomAlphaNumStringSizeRange 3 10` `randomDomainString`
    return 0
}

###############################################################################
function aacURL()  {
    echo 'http://f2m.aac.com.tw/f2m.php?F='$RANDOM
    return 0
}

###############################################################################
function globalcallbackURL()  {
    echo 'http://www.globalcallback.info/index.php?g'$RANDOM
    return 0
}

###############################################################################
function referralwareURL()  {
    echo http://www.referralware.com/home.jsp/$RANDOM
    return 0
}

###############################################################################
# http://www.filtercable.net/cgi-bin/aefrefer.cgi?MID=aef105&page=/aef105.htm
function filtercableURL()  {
    local t=`randomAlphaStringSized 3`
    local x="$t`randomDigitStringSized 3`"
    printf 'http://www.filtercable.net/cgi-bin/%srefer.cgi?MID=%s&page=/%s.htm' $t $x $x
    return 0
}

###############################################################################
#  http://size.yourplace.com.br/index.php?id=2JM1
function yourplaceURL()  {
    printf 'http://size.yourplace.com.br/index.php?id=%s' `randomAlphaNumStringSized 4`
    return 0
}

###############################################################################
# http://www.fci-int.net/brave/index.php?id=2JM1
function fci-intURL()  {
    printf 'http://www.fci-int.net/brave/index.php?id=%s' `randomAlphaNumStringSized 4`
    return 0
}

###############################################################################
# http://www.geocities.com/jsutia5/takeoff?mod@attbi.com
function jsutia5URL()  {
    printf 'http://www.geocities.com/jsutia5/takeoff?%s@%s.%s' `randomAlphaNumStringSizeRange 3 10` `randomAlphaNumStringSizeRange 3 10` `randomDomainString`
    return 0
}

###############################################################################
# http://mailshipping.com/host/magdrop/20030331
function mailshippingURL()  {
    printf 'http://mailshipping.com/host/magdrop/%s%02d%02d' `randomNumberRange 2003 2003` `randomNumberRange 1 12` `randomNumberRange 1 30`
    return 0
}

###############################################################################
# http://mailshipping.com/unsub/?client=magdrop1909276
function magdropURL()  {
    printf 'http://mailshipping.com/unsub/?client=magdrop%s' `randomDigitStringSized 7`
    return 0
}

###############################################################################
# http://www.eclipseway.com/20026/
function eclipsewayURL()  {
    printf 'http://www.eclipseway.com/%s/' `randomDigitStringSized 5`
    return 0
}

###############################################################################
# http://www.pachetes.com/?ctrac=alhome
function pachetesURL()  {
    printf 'http://www.pachetes.com/?ctrac=%s' `randomAlphaNumStringSized 6`
    return 0
}

###############################################################################
# http://ccwallet.com/unreg/?cusid=CMRights1909276
function ccwalletURL()  {
    printf 'http://ccwallet.com/unreg/?cusid=CMRights%s' `randomDigitStringSized 7`
    return 0
}

###############################################################################
# http://ucumseeme.com/unsubscribe.php?id=13440&email=mod@attbi.com
function ucumseemeURL1()  {
    printf 'http://ucumseeme.com/unsubscribe.php?id=%s&email=%s@%s.%s' `randomDigitStringSized 5` `randomAlphaStringSizeRange 3 8` `randomAlphaStringSizeRange 3 8` `randomDomainString`
    return 0
}

###############################################################################
# http://www.spywiper.info/?revshare023b65"><IMG src="cid:000501c2ff9e$f70f35c0$8413010a@spi.home.net"
function spywiper1URL()  {
    printf 'http://www.spywiper.info/?revshare%s' `randomHexStringSized 6`

    return 0
}

###############################################################################
# http://www.spywiper.info/?revshare023b65"><IMG src="cid:000501c2ff9e$f70f35c0$8413010a@spi.home.net"
function spywiper2URL()  {
    printf 'http://cid:%s$%s$%s@spi.home.net' `randomHexStringSized 12` `randomHexStringSized 8` `randomHexStringSized 8`
    return 0
}

###############################################################################
# http://eoiruieo@www.hostingtrow.com/ij/rm.html
function hostingtrowURL()  {
    printf 'http://%s@www.hostingtrow.com/ij/rm.html' `randomAlphaNumStringSized 8`
    return 0
}

###############################################################################
# http://topsites-us.com/renew-tab.htm?id=666813&d=mclinux.com
function topsitesURL()  {
    printf 'http://topsites-us.com/renew-tab.htm?id=%s&d=%s.%s' `randomDigitStringSized 6` `randomAlphaNumStringSizeRange 3 10` `randomDomainString`

    return 0
}

###############################################################################
# http://8497@www.a6sd54fe3m.net/ed.htm
function a6sd54fe3mURL()  {
    printf 'http://%s@www.a6sd54fe3m.net/ed.htm' `randomDigitStringSizeRange 3 6`
    return 0
}

# http://ricap spa@www.a6sd54fe3m.net/z.gif
function GIFa6sd54fe3mURL()  {
    printf 'http://%s %s@www.a6sd54fe3m.net/z.gif' `randomAlphaNumStringSizeRange 3 10` `randomAlphaNumStringSizeRange 3 10`
    return 0
}

###############################################################################
# http://ccwallet.com/unreg/?cusid=cmrights1909276
function ccwalletURL()  {
    printf 'http://ccwallet.com/unreg/?cusid=cmrights%s' `randomDigitStringSized 7`
    return 0
}

###############################################################################
# http://www.pointsmoney.com/signin.php?RID=287066
function pointsmoneyURL()  {
    printf 'http://www.pointsmoney.com/signin.php?RID=%s' `randomDigitStringSized 6`
    return 0
}

###############################################################################
# http://%s.paystat.org/adtype.html
function paystatURL()  {
    printf 'http://%s.paystat.org/adtype.html' `randomDigitStringSized 5`
    return 0
}

###############################################################################
# http://www.porevo.net/farmsexy/index.html?25g5O8
function porevoURL1()  {
    printf 'http://www.porevo.net/farmsexy/index.html?%s' `randomAlphaNumStringSized 6`
    return 0
}

# http://www.porevo.net/index.html?s5mn
function porevoURL2()  {
    printf 'http://www.porevo.net/index.html?%s' `randomAlphaNumStringSized 4`
    return 0
}

###############################################################################
# http://193.231.248.72/index.php?bor
function paystatURL()  { # NEVER REALLY ACTED ON THIS ONE...
    printf 'http://%s.paystat.org/adtype.html' `randomDigitStringSized 5`
    return 0
}

###############################################################################
# http://www.hoop24-7.com/viagra/default.asp?id=3D014
function hoop24URL()  {
    printf 'www.hoop24-7.com/viagra/default.asp?id=%s' `randomHexStringSized 5`
    return 0
}

###############################################################################
#http://freesexrealm.com:cherry@www.geocities.com/kenichiro55532ke   /?q=gLMjYxMi1hYWJjNzk1NjMy
#http://freesexrealm.com:cherryhost@www.geocities.com/randle31045ra  /?q=ILMjY2Ny1hYWJjNzk1NjMy
#http://freesexrealm.com:littlecherry@www.geocities.com/reicks08137re/?q=iPMjc5Mi1hYWJjNzk1NjMy

#http://bestseximages.com:sexycherry@www.geocities.com%25%30%30easyfreesex.com/kayser82972kat/?q=yDMjk4Ny1hYWJjNzk1NjMy
#       http://freesexrealm.com:cherryhost@www.geocities.com%00easyfreesex.com/kayser82972kat/?q=yDMjk4Ny1hYWJjNzk1NjMy
#           http://freesexrealm.com:cherry@www.geocities.com%00easyfreesex.com/kayser82972kat/?q=yDMjk4Ny1hYWJjNzk1NjMy&e=mod@attbi.com
# http://freesexrealm.com:sexycherry@www.geocities.com%25%30%30easyfreesex.com/kayser82972kat/?q=yDMjk4Ny1hYWJjNzk1NjMy&e=mod@attbi.com
#http://freedesireworld.com:cherry@www.geocities.com/horst8635hot/?q=adMzA2Mi1hYWJjNzk1NjMy
#http://freesexrealm.com:littlecherry@www.geocities.com/horst8635hot/?q=adMzA2Mi1hYWJjNzk1NjMy&e=mod@attbi.com

# http://dreamsonrealms.org:cherryhost@www.geocities.com/mcgorry00333mct/?q=GxNDUzNS1hYWJjNzk1NjMy
#      http://bestseximages.com:cherry@www.geocities.com/mcgorry00333mct/?q=GxNDUzNS1hYWJjNzk1NjMy
# http://freesexrealm.com:littlecherry@www.geocities.com/mcgorry00333mct/?q=GxNDUzNS1hYWJjNzk1NjMy

function freesexrealmURL2()  {
    printf 'http://freesexrealm.com:littlecherry@www.geocities.com/reicks%sre/?q=%s1hYWJjNzk1NjMy' `randomDigitStringSized 5` `randomAlphaNumStringSized 8`
    return 0
}

###############################################################################
# http://193.231.248.72/index.php?bor
# http://193.231.248.72/index.php?cystumbiz
function paystatURL()  { # NEVER REALLY ACTED ON THIS ONE...
    printf 'http://%s.paystat.org/adtype.html' `randomAlphaNumStringSizeRange 5 10`
    return 0
}

###############################################################################
# http://www.iamsuccessful.net/cgi-bin/varpro/r.cgi?id=nutrition4&a=mod@world.std.com
function iamsuccessfulURL()  {
    printf 'http://www.iamsuccessful.net/cgi-bin/varpro/r.cgi?id=nutrition&a=%s@%s.%s' `randomAlphaNumStringSizeRange 4 8` `randomAlphaNumStringSizeRange 4 8` `randomDomainString`
    return 0
}

###############################################################################
# http://www.ihealth.bz/human/index.php?id=413
function ihealthURL1()  {
    printf 'http://www.ihealth.bz/human/index.php?id=%s' $RANDOM
    return 0
}

###############################################################################
# http://www.ihealth.bz/human/index.php?id=413 index.php?id=703&show=remove
function ihealthRemoveURL2()  {
    printf 'http://www.ihealth.bz/human/index.php?id=%s&show=remove' $RANDOM
    return 0
}

###############################################################################
# http://Mcgjxsgi@www.ihealth.bz/humang/index.php?id=413
# http://Vbwudbwj@www.ihealth.bz/smev/v/e.php?e=mod@world.std.com
function ihealth3()  {
    printf 'http://%s@www.ihealth.bz/humang/index.php?id=%s' `randomAlphaNumStringSized 8` $RANDOM
    return 0
}

###############################################################################
# http://Mcgjxsgi@www.ihealth.bz/humang/index.php?id=413
# http://Vbwudbwj@www.ihealth.bz/smev/v/e.php?e=mod@world.std.com
function ihealth4()  {
    printf 'http://%s@www.ihealth.bz/smev/v/e.php?e=mod@world.std.com'
`randomAlphaNumStringSized`
    return 0
}

###############################################################################
# http://www.201-sy.com/free/627212/index.htm
function 201-syURL()  {
    printf 'http://www.201-sy.com/free/%s/index.htm' `randomDigitStringSized 6`
    return 0
}

###############################################################################
# http://le23lee5:-ae6yh&@letleNderscompeTE.cOM
function letlenderscompeteURL()  {
    printf 'http://le23lee5:-ae6yh&@letleNderscompeTE.cOM'
    return 0
}

###############################################################################
# http://www.cool-hoop.com/host/index.asp?ID=027
function coolhoopURL()  {
    printf 'http://www.cool-hoop.com/host/index.asp?ID=0%s' `randomDigitStringSized 4`
    return 0
}

###############################################################################
# http://thebestyoucanfind@www.a5zing29.com/xcart/customer/product.php?productid=16153&partner=affil91
function a5zing29URL()  {
    printf 'http://%s@www.a5zing29.com/xcart/customer/product.php?productid=%s&partner=%s' `randomAlphaNumStringSizeRange 5 20` `randomNumberRange 10000 20000` `randomAlphaNumStringSizeRange 4 9`
    return 0
}

# http://mailshipping.com/unsub/?client=skipmiddle1909276
# http://stats.adultrevenueservice.com/wmrefer.php?1008591
# http://stats.ucumseeme.com/images/129881arsp_120X60_01.gif
# http://ucumseeme.com/unsubscribe.php?id=13440&email=mod@attbi.com
# http://www.platinumbucks.com/?revid=4878
# http://www.scorescash.com/ap/click?bishop
# http://stats.primecash.com/scripts/signup.php?referer=bishop
# http://www.xeemo.com/20025/

# http://2%316.2%343.24%30.%3117/inde%78.%70h%70?%73t%72%61%74"><img src="http://%57ww.w%4f%52%4cds%45%78ser%56e%72.c%4F%6D/%58%69cX%6fkf%6f%6b%72%46%6d%41j%41%71AwA%75GA%45%46/i%6D%61ge%73/%74b%62.%67%69%66
# http://216.243.240.117/index.php?strat"><img src="http://Www.wORLdsExserVer.cOm/XicXokfokrFmAjAqAwAuGAEF/images/tbb.gif
# http://freecherryworld.com:littlecherry@www.geocities.com%00easyfreesex.com/gill60642git/?q=mpMzI1NC1hYWJjNzk1NjMy

###############################################################################
# http://u.tclk.net/survey/?a84HVM.bdQ4KW.bW9kQGF0.u
function tclkURL()  {
    printf 'http://u.tclk.net/survey/?%s.%s.%s' `randomAlphaNumStringSizeRange 6 10` `randomAlphaNumStringSizeRange 6 10` `randomAlphaNumStringSizeRange 6 10`
    return 0
}

###############################################################################
# http://www.geocities.com/addfic/later?mod@attbi.com
function addficURL()  {
    printf 'http://www.geocities.com/addfic/later?%s@%s.%s' `randomAlphaNumStringSizeRange 3 9` `randomAlphaNumStringSizeRange 3 9` `randomDomainString`
    return 0
}

###############################################################################
# http://www.edomainoffers.com/link.cfm?l=256&u=fuckYou&c=fuckYou&t=fuckYou
function edomainoffersURL()  {
    printf 'http://www.edomainoffers.com/link.cfm?l=%s&u=%s&c=%s&t=%s' `randomDigitStringSized 3` `randomAlphaNumStringSizeRange 3 9` `randomAlphaNumStringSizeRange 3 9` `randomAlphaNumStringSizeRange 3 9`
    return 0
}

###############################################################################
# http://www.edomainoffers.com/unsubscribe.cfm?c=241&u=441684444
function unsubEdomainoffersURL()  {
    printf 'http://www.edomainoffers.com/unsubscribe.cfm?c=241&u=441684444' `randomDigitStringSized 3` `randomDigitStringSized 9`
    return 0
}

###############################################################################
# http://g@216.194.67.61/?e=mod@std.com
function visualchatURL()  {
    printf 'http://g@216.194.67.61/?e=%s@%s.%s' `randomAlphaNumStringSizeRange 3 9` `randomAlphaNumStringSizeRange 3 9` `randomDomainString`
    return 0
}

###############################################################################
# http://www.nevvpovveroffers.com/j10de0803/then
function nevvpovveroffersURL()  {
    printf 'http://www.nevvpovveroffers.com/j10de0%s/then' `randomDigitStringSized 3`
    return 0
}

###############################################################################
# http://ucumseeme.com/unsubscribe.php?id=13440&email=mod@attbi.com
function ucumseemeURL2()  {
    printf 'http://ucumseeme.com/unsubscribe.php?id=%s&email=%s@%s.%s' `randomDigitStringSized 5` `randomAlphaNumStringSizeRange 3 9` `randomAlphaNumStringSizeRange 3 9` `randomDomainString`
    return 0
}

###############################################################################
# http://planetgazer.com/intimate-ladies-graphic/intimate.html?aa=intimate-ladies-graphic&ab=mod&ac=world.std.com
# http://planetgazer.com/intimate-ladies-graphic/images/il.jpg?ba=intimate-ladies-graphic&bb=mod&bc=world.std.com
# http://www.planetgazer.com/off-list/index.html?ca=intimate-ladies-graphic&cb=mod&cc=world.std.com
# http://planetgazer.com/intimate-ladies-graphic/images/nothanks.gif?da=intimate-ladies-graphic&db=mod&dc=world.std.com
# http://www.intimate-ladies.com/?refID=ye586

function planetgazerURL1()  {
    printf 'http://planetgazer.com/intimate-ladies-graphic/intimate.html?aa=intimate-ladies-graphic&ab=%s&ac=%s.%s' `randomAlphaNumStringSizeRange 3 9` `randomAlphaNumStringSizeRange 3 9` `randomDomainString`
    return 0
}

function planetgazerURL2()  {
    printf 'http://planetgazer.com/intimate-ladies-graphic/images/il.jpg?ba=intimate-ladies-graphic&bb=%s&bc=%s.%s' `randomAlphaNumStringSizeRange 3 9` `randomAlphaNumStringSizeRange 3 9` `randomDomainString`
    return 0
}

function planetgazerURL3()  {
    printf 'http://www.planetgazer.com/off-list/index.html?ca=intimate-ladies-graphic&cb=%s&cc=%s.%s' `randomAlphaNumStringSizeRange 3 9` `randomAlphaNumStringSizeRange 3 9` `randomDomainString`
    return 0
}

function planetgazerURL4()  {
    printf 'http://planetgazer.com/intimate-ladies-graphic/images/nothanks.gif?da=intimate-ladies-graphic&db=%s&dc=%s.%s' `randomAlphaNumStringSizeRange 3 9` `randomAlphaNumStringSizeRange 3 9` `randomDomainString`
    return 0
}

function planetgazerURL5()  {
    printf 'http://www.intimate-ladies.com/?refID=%s' `randomAlphaNumStringSized 5`
    return 0
}

###############################################################################
# http://mstr-001.magicemail.info/trk/click?ref=zo053kac1-bx27x25508753&
function gotomypcURL()  {
    printf 'http://mstr-001.magicemail.info/trk/click?ref=%s-%sx%sx%s&' `randomAlphaNumStringSized 9` `randomAlpha` `randomDigitStringSized 2` `randomDigitStringSized 8`
    return 0
}

###############################################################################
# http://www.gainprosite.tc/gp/index.php?ajkro
function gainprositeURL()  {
    printf 'http://www.gainprosite.tc/gp/index2.php?%s' `randomAlphaNumStringSizeRange 3 1026`
    return 0
}

###############################################################################
# http://www.winningteamusa.com/mka/m2c.php?man=kk439
function winningteamsusaURL()  {
    printf 'http://www.winningteamusa.com/mka/m2c.php?man=%s%s' `echo kk` `randomDigitStringSized 3`
    return 0
}

###############################################################################
# http://ofrsvr.com/v.asp?ad_key=VKFONNCVXRUS&vt=TAM,152574491"
function ofrsrvrURL1()  {
    printf 'http://ofrsvr.com/v.asp?ad_key=%s&vt=%s,%s' `randomAlphaStringSized 12` `randomAlphaStringSized 3` `randomDigitStringSized 9`
    return 0
}

###############################################################################
# http://ofrsvr.com/subscription.asp?em=lod@ATTBI.COM&l=TAM
function ofrsrvrURL2()  {
    printf 'http://ofrsvr.com/subscription.asp?em=%s@%s.%s&l=%s' `randomAlphaNumStringSizeRange 3 9` `randomAlphaNumStringSizeRange 3 9` `randomDomainString` `randomAlphaStringSized 3`
    return 0
}

###############################################################################
# http://www.eb-helper.com/eb19
function eb-helperURL()  {
    printf 'http://www.eb-helper.com/%s' `randomAlphaNumStringSized 4`
    return 0
}

###############################################################################
# http://www.largerlover.com/main2.php?rx=15513
function largerloverURL()  {
    printf 'http://www.largerlover.com/main2.php?rx=%s' `randomDigitStringSized 5`
    return 0
}

###############################################################################
# http://sub-mails.net/no.php?u=57796512
function fistyfuckURL()  {
    printf 'http://sub-mails.net/no.php?u=%s' `randomDigitStringSized 8`
    return 0
}

###############################################################################
# https://womc.net/pass.php?a=search&b=5&c=FuckYouAsswipeSPAMMERS@womc.net
function womcURL()  {
    printf 'http://womc.net/pass.php?a=search&b=5&c=FuckYouAsswipeSPAMMERS@womc.net'
    return 0
}

###############################################################################
# http://pillsavings5.com/877.php
function pillsavings5URL()  {
    printf 'http://pillsavings5.com/%s.php' `randomDigitStringSized 3`
    return 0
}

###############################################################################
# http://www.gootle.us/index.php?afil=1025
function gootleURL()  {
    printf 'http://www.gootle.us/index.php?afil=%s' `randomDigitStringSized 4`
    return 0
}

###############################################################################
# http://srv.ezinedirector.net/?fa=r&id=17911725&c=964644622
function ezinedirectorURL()  {
    printf 'http://srv.ezinedirector.net/?fa=r&id=%s&c=%s' `randomDigitStringSized 8` `randomDigitStringSized 9`
    return 0
}

###############################################################################
# http://mddelivers.com/unsub/?client=readerscom1909276
function readerscomURL()  {
    printf 'http://mddelivers.com/unsub/?client=readerscom%s' `randomDigitStringSized 7`
    return 0
}

###############################################################################
# http://participate@www.cooltoyz.biz/image.php?id=93869
function cooltoyzURL()  {
    printf 'http://participate@www.cooltoyz.biz/image.php?id=%s' `randomDigitStringSized 5`
    return 0
}

###############################################################################
# http://www.3xV2xzmK@www.tolast55.com/h.html
function tolast55unsubURL()  {
    printf 'http://www.%s%s@www.tolast55.com/h.html' `randomDigit` `randomAlphaNumStringSized 7`
    return 0
}

###############################################################################
# http://www.2WuYmLpu@www.tolast55.com/ca
function tolast55productURL()  {
    printf 'http://www.%s%s@www.tolast55.com/ca' `randomDigit` `randomAlphaNumStringSized 7`
    return 0
}

###############################################################################
# http://phone4s.com/host/default.asp?ID=3D014
function phone4sURL()  {
    printf 'http://phone4s.com/host/default.asp?ID=%s%s%s' `randomDigit` `randomHexAlpha` `randomDigitStringSized 3`
    return 0
}

###############################################################################
# http://iddnews.com/unreg/?cusid=servagent1909276
function iddnewsURL()  {
    printf 'http://iddnews.com/unreg/?cusid=servagent%s' `randomDigitStringSized 7`
    return 0
}

###############################################################################
# http://www.muranowholesale.info/s2/?AFF_ID=vd95lx
function muranowholesaleURL()  {
    printf 'http://www.muranowholesale.info/s2/?AFF_ID=%s' `randomAlphaNumStringSized 6`
    return 0
}

###############################################################################
# http://3394RFJITY.6007OFASWTXT.markis.info/remove/
function markis.infoURL()  {
    printf 'http://%s%s.%s%s.markis.info/remove/' `randomDigitStringSized 4` `randomAlphaStringSized 6` `randomDigitStringSized 5` `randomAlphaStringSized 7`
    return 0
}

###############################################################################
# http://1mV1YPnu7mP.esellni.com/u/MRCt
function esellni.comURL()  {
    printf 'http://%s.esellni.com/u/%s/' `randomAlphaNumStringSized 11` `randomAlphaStringSized 4`
    return 0
}

###############################################################################
# http://GJHH.SHTUV572508.smeakis.info/fbuddies8/
function smeakis.infoURL()  {
    printf 'http://%s.%s%s.smeakis.info/fbuddies8/' `randomAlphaStringSized 4` `randomAlphaStringSized 5` `randomDigitStringSized 6`
    return 0
}

###############################################################################
# http://soincbuo0147.freakes.info/fbuddies8/
function freakes.infoURL()  {
    printf 'http://%s%s.freakes.info/fbuddies8/' `randomAlphaStringSized 8` `randomDigitStringSized 4`
    return 0
}

###############################################################################
# http://xy.cheappharm5.com/_29906dc178db32f2e152b715b74c2492/
function cheappharm5.comURL()  {
    printf 'http://xy.cheappharm5.com/_%sdc%sdb%s%s/' `randomDigitStringSized 5` `randomDigitStringSized 3` `randomHexStringSized 16` `randomDigitStringSized 4`
    return 0
}

###############################################################################
# http://www.zbqow.net.rtmoilv.cchelp.info/alexr/cnjjcli/rdnev.html
function cchelp.infoURL()  {
    printf 'http://www.%s.net.%s.cchelp.info/%s/%s/%s.html' `randomAlphaStringSized 5` `randomAlphaStringSized 7` `randomAlphaStringSized 5` `randomAlphaStringSized 7` `randomAlphaStringSized 5`
    return 0
}

###############################################################################
# http://january2004.com:8080/track?m=9396041&l=5&.e=7tMy+MpeM8eIYeyobMt
function january2004URL()  {
    printf 'http://january2004.com:8080/track?m=%s&l=%s&.e=%s%s+%s%s%s'   `randomDigitStringSized 7` `randomDigit` `randomDigit` `randomAlphaStringSized 3` `randomAlphaStringSized 4` `randomDigit` `randomAlphaStringSized 9`
    return 0
}

###############################################################################
# http://AUmCtY9D.ifbccch.info/?dsLiLuJYehQCvJd8jDNmLyC
function ifbccch.infoURL()  {
    printf 'http://%s.ifbccch.info/?%s' `randomAlphaNumStringSized 8` `randomAlphaNumStringSized 23`
    return 0
}

###############################################################################
# http://456355175EEHKZVIM.leakis.info/fbuddies8/
function leakis.infoURL()  {
    printf 'http://%s%s.leakis.info/fbuddies8/' `randomDigitStringSized 9` `randomAlphaStringSized 8`
    return 0
}

###############################################################################
# http://dbyisnzj.makingthemost.net/sddg/blueno.gif
function makingthemost.netURL()  {
    printf 'http://%s.makingthemost.net/sddg/mortgage_files/j0.gif' `randomAlphaStringSized 8`
    return 0
}

###############################################################################
# http://ck.net.mypills4us.com?d=T11k26
function mypills4us.comURL()  {
    printf 'http://ck.net.mypills4us.com?d=%s%s%s%s' `randomAlpha` `randomDigitStringSized 2` `randomAlpha` `randomAlphaStringSized 2`
    return 0
}

###############################################################################
# http://www.fchxtpvyqxwxf.kredis.info/fbuddies4/
function kredis.infoURL()  {
    printf 'http://www.%s.kredis.info/fbuddies4/' `randomAlphaStringSized 13`
    return 0
}

###############################################################################
# http://67.165.24.16/ViewItemnumber1952056599category91376.html
function URL67.165.24.16()  {
    printf 'http://67.165.24.16/ViewItemnumber'%s'category'%s'.html' `randomDigitStringSized 10` `randomDigitStringSized 5`
    return 0
}

###############################################################################
# http://xtrdilljxpjkyitefekm.koqnophr.com/s5/ke.php?v2l=77
function koqnophr.comURL()  {
    printf 'http://%s.koqnophr.com/s5/ke.php?v2l=%s' `randomAlphaStringSized 20` `randomAlphaStringSized 2`
    return 0
}

###############################################################################
# http://whmingsihco.pogmsa.com/_f985341682a0f3cd62baa654773c6a8e/
function pogmsa.comURL()  {
    printf 'http://%s.pogmsa.com/_%s%s%s/' `randomAlphaStringSized 11` `randomHexStringSized 10` `randomHexStringSized 10` `randomHexStringSized 12`
    return 0
}

###############################################################################
# http://jyeexckg.holdtiff.com/prime/windemrmere/
function holdtiff.comURL()  {
    printf 'http://%s.holdtiff.com/main.html' `randomAlphaStringSized 8`
    return 0
}

###############################################################################
# http://wisely.hdhdljc.info/?INe_KdILsgj0oIcensure
function hdhdljc.infoURL()  {
    printf 'http://%s.hdhdljc.info/?%s_%scensure' `randomAlphaStringSized 6` `randomAlphaStringSized 3` `randomAlphaStringSized 10`
    return 0
}

###############################################################################
# http://sterlinglenders.com/?partid=moffob
function sterlinglendersURL()  {
    printf 'http://sterlinglenders.com/?partid=%s' `randomAlphaStringSized 6`
    return 0
}

###############################################################################
# http://www.mobilestorm.com/crackthewhip/manage/unsub.php?u=bW9kQGF0dGJpLmNvbXxjcmFja3RoZXdoaXA
function mobilestorm.comURL()  {
#   printf 'http://www.mobilestorm.com/crackthewhip/manage/unsub.php?u=%s' `randomAlphaStringSized 35`
    printf 'http://www.mobilestorm.com/crackthewhip/manage/edit.php?u=WW91IG1vdGhlcmZ1Y2tpbmcgU1BBTU1FUlMgYXJlIGxvd2xpZmUgQVNTV0lQRVMhISEK'
    return 0
}

###############################################################################
# http://entice.basicrxmeds.com/?wid=3D100106
function basicrxmeds.comURL()  {
    printf 'http://basicrxmeds.com/?wid=3D%s' `randomDigitStringSized 6`
    return 0
}

###############################################################################
# http://xmftvcaffdrjdh.ivhjhp.com/p3/jwex.php?n5n=77
#    http://wzcleqcfiro.ivhjhp.com/p3/jwex.php?n5n=77
function ivhjhp.comURL()  {
    printf 'http://%s.ivhjhp.com/p3/jwex.php?n5n=77' `randomAlphaStringSizeRange 11 14`
    return 0
}

###############################################################################
# http://pattonbrigadedisgustfulcelandineabject.ppmemittingelectrajubilatepfennig.recktome.info/moss/datelonley/datelonelywives/
function recktome.infoURL()  {
    printf 'http://%s.%s.recktome.info/moss/datelonley/datelonelywives/' `randomAlphaStringSized 38` `randomAlphaStringSized 33`
    return 0
}

###############################################################################
# http://dicesteinerbichromatearkansas.goggledepressanttrichrome.hortafer.info/goodbye/
function hortafer.infoURL()  {
    printf 'http://%s.%s.hortafer.info/goodbye/' `randomAlphaStringSized 29` `randomAlphaStringSized 25`
    return 0
}

###############################################################################
# http://cervantes.operdmc.com/p/
function operdmc.comURL()  {
    printf 'http://%s.operdmc.com/p/' `randomAlphaStringSized 9`
    return 0
}

###############################################################################
# http://ojoxeydaqw.money-bright.info/e4/jj.php?cyb=77
function money-bright.infoURL()  {
    printf 'http://%s.money-bright.info/e4/' `randomAlphaStringSized 10`
    return 0
}

###############################################################################
# http://gasmesvx.sun1statuss.info/?4hRf0zPAJZajjCYITx
# http://lsietwm.sun1statuss.info/?4Djf0EZLBWczzp

function sun1statuss.infoURL()  {
    printf 'http://%s.sun1statuss.info/?4%s' `randomAlphaStringSizeRange 6 10` `randomAlphaStringSizeRange 12 20`
    return 0
}

###############################################################################
# http://ozoocu.my7sundew.info/?l2dA1GvZajjf0Gkzx

function my7sundew.infoURL()  {
    printf 'http://%s.my7sundew.info/?l%s' `randomAlphaStringSizeRange 6 10` `randomAlphaStringSizeRange 12 20`
    return 0
}

###############################################################################
# http://qrfxyumed.ckadfgef.info/?abIUIMbMMeNPFGGbilqitoxg

function ckadfgef.info()  {
    printf 'http://%s.ckadfgef.info/?%s' `randomAlphaStringSized 9` `randomAlphaStringSized 24`
    return 0
}

###############################################################################
# http://dkyfieosi.advisor1deviation.info/?Zq1Tf02OYjaUCwWFFc

function advisor1deviation.info()  {
    printf 'http://%s.advisor1deviation.info/?%s' `randomAlphaStringSized 9` `randomAlphaNumStringSized 18`
    return 0
}

###############################################################################
# http://198.178.10.193/contactweb/scripts/msg_tracker.jsp?Instance=351&Target=michael.odonnell@comcast.net&guid=Thu%20Mar%2024%2015%3A08%3A01%202005

function contactweb198.178.10.193()  {
    printf 'http://198.178.10.193/contactweb/scripts/msg_tracker.jsp?Instance=%s&Target=%s.%s@%s.%s&guid=Thu%%20Mar%%2024%%20%s%%3A%s%%3A%s%%202005' `randomDigitStringSized 3` `randomAlphaNumStringSizeRange 3 10` `randomAlphaNumStringSizeRange 3 10` `randomAlphaNumStringSizeRange 3 10` `randomDomainString` `randomDigitStringSized 2` `randomDigitStringSized 2` `randomDigitStringSized 2`
    return 0
}

###############################################################################
# http://wmuk&zhiwx%2efr%2esoftpop%2einfo/in.php?aid=11&fwcbhcxdm

function sofnpn.info()  {
    printf 'http://sofnpn.info:80/in.php?aid=%s&%s' `randomDigitStringSized 2` `randomAlphaStringSized 9`
    return 0
}

###############################################################################
# http://www.ueftcg.pwlv.southusd.com

function southusd.com()  {
    printf 'http://www.%s.%s.southusd.com' `randomAlphaStringSized 6` `randomAlphaStringSized 4`
    return 0
}

###############################################################################
# http://Q6Pj.dynamictelco.us

function dynamictelco.us()  {
    printf 'http://%s.dynamictelco.us' `randomAlphaNumStringSized 4`
    return 0
}

###############################################################################
# http://yyyvb&bllpvotrw%2efr%2esoftpyp%2einfo/in.php?aid=11&bxpaetx

function softpyp.info()  {
    printf 'http://%s&%s.%s.softpyp.info/in.php?aid=%s&%s' `randomAlphaStringSized 5` `randomAlphaStringSized 9` `randomDigitStringSized 2` `randomDigitStringSized 2` `randomAlphaStringSized 7`
    return 0
}

###############################################################################
# http://godhwneqyoj.org&iyxfixlbmj0gnt0zwsl%2Esjdkfnkyb%2Ecom/

function sjdkfnkyb.com()  {
    printf 'http://%s.org&iy%s.sjdkfnkyb.com/' `randomAlphaNumStringSized 11` `randomAlphaNumStringSized 17`
    return 0
}

#################################### HTTP #####################################
# http://adultfriendfinder.com/go/p108136c

function adultfriendfinder.com()  {
    printf 'http://adultfriendfinder.com/go/p%sc' `randomDigitStringSized 6`
    return 0
}

#################################### HTTP #####################################
# http://ejwitdabj.tablrl.info/?c6743af963e1F3f9Fa044aee376c5bb9

function ejwitdabj.tablrl.info()  {
    printf 'http://%s.tablrl.info/?%s' `randomAlphaStringSized 9` `randomHexStringSized 32`
    return 0
}

#################################### HTTP #####################################
# http://jfmivsct.tablrl.info/?69c0334aFe7f9916F56fa5d44143927d
# http://vmjwnhzg.tablrl.info/?c6743af963e1F3f9Fa044aee376c5bb9

function jfmivsct.tablrl.info()  {
    printf 'http://%s.tablrl.info/?%s' `randomAlphaStringSized 8` `randomHexStringSized 32`
    return 0
}

#################################### HTTP #####################################
# http://qtgcj.tablrl.info/?69c0334aFe7f9916F56fa5d44143927d

function qtgcj.tablrl.info()  {
    printf 'http://%s.tablrl.info/?%s' `randomAlphaStringSized 5` `randomHexStringSized 32`
    return 0
}

#################################### HTTP #####################################
# http://mckbjziyg.orgz3m0ov6j862rs2wpgtj41.entitycdfjd.com/1ü075/?affiliate_id=288802&campaign_id=81239

function orgz3m0ov6j862rs2wpgtj41.entitycdfjd.com()  {
    printf 'http://%s.%s.entitycdfjd.com/1ü075/?affiliate_id=%s&campaign_id=%s' `randomAlphaStringSizeRange 5 15` `randomAlphaNumStringSizeRange 15 25` `randomDigitStringSized 6` `randomDigitStringSized 5`

    return 0
}

#################################### HTTP #####################################
# http://ajzhygwfvd.comox1oo36fkc67g2hn2vw53.cohunehcnhk.com/181/?affiliate_id=317368&campaign_id=93139

function comox1oo36fkc67g2hn2vw53.cohunehcnhk.com()  {
    printf 'http://%s.%s.cohunehcnhk.com/181/?affiliate_id=%s&campaign_id=%s' `randomAlphaStringSizeRange 5 15` `randomAlphaNumStringSizeRange 15 25` `randomDigitStringSized 6` `randomDigitStringSized 5`

    return 0
}

#################################### HTTP #####################################
# http://housingonthecheap.net/optout.aspx?cid=280&ec=eckkkyZMZZfZ19hBSpO

function housingonthecheap.net()  {
    printf 'http://housingonthecheap.net/optout.aspx?cid=%s&ec=%s%s%s%s' `randomDigitStringSized 3` `randomAlphaStringSized 6 | tolower` `randomAlphaStringSized 6 | toupper` `randomDigitStringSized 2` `randomAlphaNumStringSized 5`

    return 0
}

#################################### HTTP #####################################
#    http://pdvyl.sofmym.info/?f6727F78fbf662b8bFa807e45e7a50ae
#  http://ehdemfb.sofmym.info/?f6727F78fbf662b8bFa807e45e7a50ae
# http://mfekxdpl.sofmym.info/?44c92d1bFd0e78d73F5e9c0519540041
#http://nmlivuuhh.sofmym.info/?1109972c37e0F1abade6b3eF7cde927c
#    http://pdvyl.sofmym.info/?f6727F78fbf662b8bFa807e45e7a50ae
#
# http://wdaiuwcd.sofmwm.info/?679317db6706Fe6aF91fc68de714a333
#   http://bxqaov.sofmwm.info/?Fd42627e054f29312e73ea33f7c7Fe66
# http://gmedtllk.sofmwm.info/?Fd42627e054f29312e73ea33f7c7Fe66
# http://tlmjwpyz.sofmwm.info/?25aa7c3b94d9f4Fbec0406Ff01e1bd79
#http://ymourapqp.sofmwm.info/?25aa7c3b94d9f4Fbec0406Ff01e1bd79
#http://bknlyjyaf.sofmwm.info/?d6e8ad7be52F2cc38280fe5F1d663386
#  http://eaecbpf.sofmwm.info/?d6e8ad7be52F2cc38280fe5F1d663386
#
# http://azkxuxvo.sofmqm.info/?10Fd0b37daf762b4bf7ebe65ff6F3a20
#  http://rtxiyby.sofmqm.info/?10Fd0b37daf762b4bf7ebe65ff6F3a20
#http://emxmyiube.sofmqm.info/?50e3636419c4F4e4efF0cb639510edf5
#    http://mvwjp.sofmqm.info/?50e3636419c4F4e4efF0cb639510edf5
#    http://erbfr.sofmqm.info/?b3Ff8ba99aadfac786F0d8a16a93abf3
#    http://rpiqu.sofmqm.info/?b3Ff8ba99aadfac786F0d8a16a93abf3

function pdvyl.sofmym.info()  {
    printf 'http://%s.sofmym.info/?%s' `randomAlphaStringSized 5` `randomHexStringSized 32`
    return 0
}

# randomNumberRange
# randomDigit
# randomAlpha
# randomHexAlpha
# randomAlphaWhite
#
# randomDigitStringSized
# randomDigitStringSizeRange
# randomHexStringSized
# randomHexStringSizeRange
# randomAlphaStringSized
# randomAlphaStringSizeRange
# randomAlphaNumStringSized
# randomAlphaNumStringSizeRange
#
# randomDomainString
# randomAmpersandURLdomain
# randomTokenStringSized
# randomTokenStringSizeRange

 #####   #    #   ####
 #    #  ##   #  #
 #    #  # #  #   ####
 #    #  #  # #       #
 #    #  #   ##  #    #
 #####   #    #   ####

#################################### DNS ######################################
# http://fljhasymkp.org&rktqpr6ckds97w2r851c%2Esadjhsdb%2Ecom/
# http://aiqmygs.net&eahtzjo7ms0bq7nui763zs%2Emultumliakf%2Ecom/
# http://behetacrd.com&nnnkm4jpf8nmkrxmliep%2Edirknijkf%2Ecom/
# http://dsavmgj.net&hpczrheks30hx4shyv9k%2Eareaneebek%2Ecom/
# http://dxiypkutr.org&mxwgotq5bjc986dj8p4it%2Efelsjkdbm%2Ecom/
# http://dxyhvaamnq.org&ngaxykicrx5gvush5cbqmx%2Eseggaramblk%2Ecom/
# http://ehinsacm.org&jtjr1y4unk1z6cjixtm%2Ememutagebgf%2Ecom/
# http://fimapglosad.net&svpayr6ckvs97wkrqnju%2Eiliacgnkln%2Ecom/
# http://gjvzfcxxmk.org&mdmjnkqy9653syn4jfq%2Eguacofknhb%2Ecom/
# http://gyzuwtagt.com&ujyhqm3i6e743jqwl2hvo%2Eskilbmchg%2Ecom/
# http://icxvccxshxcl.com&qtzzbwc7ms0bq7nui763zs%2Egealldikk%2Ecom/
# http://javmoxy.net&lzlikh5do32i7vk1ycn%2Esmearefcfe%2Ecom/
# http://jrlxqfvskh.com&yyumrn63rha7ombz652g9%2Ecohunehcnhk%2Ecom/
# http://ltkcjcoyijd.net&bdbd306e7m31qw32zdo%2Ewjncnbfj%2Ecom/
# http://mxjjelqgdwml.org&xxzjnk8g9o5lsgnm1f8%2Eacananmdaf%2Ecom/
# http://mxvfiyp.net&cdusemj7x8n42rfm3ie7%2Ekickdedeh%2Ecom/
# http://nikzopgvrl.com&mfmlwubvsgohedb0odu9ng%2Eachoriadbl%2Ecom/
# http://nikzopgvrl.com&mfmlwubvsgohedb0odu9ng.achoriadbl.com/
# http://phjwkznvlkv.net&gqphloss7v3ebaqxlsro2d%2Edutchibabd%2Ecom/
# http://pwlyjpgpabvf.com&aizms7d3wts8flsro2d%2Euntowncjaad%2Ecom/
# http://pznfuzzp.org&zwykutqe4fubrymbap3e%2Eremoraeiiin%2Ecom/
# http://qerrsgneiwzx.net&fayycrf5gdcsz5cbq4x%2Ecasefydcngd%2Ecom/
# http://rialmacap.net&dlmdaiwb8e4xct9g4bs73w%2Efpmqnzfbvf%2Ecom/
# http://satwylrgp.org&zkus63rha7ombz652g9%2Esolveaiamd%2Ecom/
# http://scpcqea.net&ptbnjmheks30hx4shyv9k%2Eblsoreenlg%2Ecom/
# http://thcywvf.com&nlgzem1px854k9xmliw7%2Eboweldjaej%2Ecom/
# http://ukzivjpuwkxq.net&jrtxbd7ms0bq7nui763zs%2Ewhuzgdaid%2Ecom/
# http://vgzljgzci.org&yyrrsmmj7x8n42rfm3ie7%2Eentitycdfjd%2Ecom
# http://viffdodls.org&ddqcayhs7d3wts8flsro2d%2Eurnafomast%2Ecom/
# http://wjfdkubxx.com&xznoyb8e4fub9y4ba7le%2Eurnafomast%2Ecom/
# http://wtggdskdyl&wjsswmvo.org%2Emortpharm2005.com/b/aTJJMDkxMThDfTv
# http://xtucaeyutrl.net&ajfyakh5do32i7vk1ycn%2Ecomerfbdll%2Ecom/
# http://xzucswnp.net&vmibeiwtz7ixeu17wvsoh%2Etaumldhfj%2Ecom/
# http://yrsbxrqp.org&pxfh96ckds97w2r8n1u%2Eeditehkce%2Ecom/
# http://yswvduv.org&lkryl0oepml18w32zd6%2Ehectorbdejc%2Ecom/
# http://zfmkrmq.com&wkmuheks30hx4shyv9k%2Eiliacgnkln%2Ecom/

function ampersandURL()  {
    printf '%s.%s&%s.%s.com' `randomAlphaStringSizeRange 8 12` `randomDomainString` `randomAlphaNumStringSizeRange 18 22`  `randomAmpersandURLdomain`
    return 0
}

# randomNumberRange
# randomDigit
# randomAlpha
# randomHexAlpha
# randomAlphaWhite
#
# randomDigitStringSized
# randomDigitStringSizeRange
# randomHexStringSized
# randomHexStringSizeRange
# randomAlphaStringSized
# randomAlphaStringSizeRange
# randomAlphaNumStringSized
# randomAlphaNumStringSizeRange
#
# randomDomainString
# randomAmpersandURLdomain
# randomTokenStringSized
# randomTokenStringSizeRange

###############################################################################
# "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; Smart Explorer v6.0 ( Evaluation Period ); (R1 1.1))"

VALIDATED_HTTP="				\
    201-syURL					\
    a6sd54fe3mURL				\
    aacURL					\
    ccwalletURL					\
    eclipsewayURL				\
    fci-intURL					\
    filtercableURL				\
    freesexrealmURL1				\
    freesexrealmURL2				\
    gamingURL					\
    GIFa6sd54fe3mURL				\
    globalcallbackURL				\
    glucoURL					\
    hoop24URL					\
    hostingtrowURL				\
    iamsuccessfulURL				\
    ihealthRemoveURL2				\
    ihealthURL1					\
    jsutia5URL					\
    magdropURL					\
    mailshippingURL				\
    pachetesURL					\
    paystatURL					\
    pointsmoneyURL				\
    porevoURL1					\
    porevoURL2					\
    referralwareURL				\
    spywiper1URL				\
    spywiper2URL				\
    topsitesURL					\
    ucumseemeURL1				\
    yourplaceURL				\
    coolhoopURL					\
    a5zing29URL					\
    tclkURL					\
    addficURL					\
    edomainoffersURL				\
    unsubEdomainoffersURL			\
    visualchatURL				\
    nevvpovveroffersURL				\
    ucumseemeURL2				\
    planetgazerURL3				\
    planetgazerURL1				\
    planetgazerURL2				\
    planetgazerURL4				\
    planetgazerURL5				\
    gotomypcURL					\
    gainprositeURL				\
    winningteamsusaURL				\
    ofrsrvrURL1					\
    ofrsrvrURL2					\
    eb-helperURL				\
    largerloverURL				\
    fistyfuckURL				\
    womcURL					\
    pillsavings5URL				\
    gootleURL					\
    ezinedirectorURL				\
    readerscomURL				\
    cooltoyzURL					\
    tolast55unsubURL				\
    tolast55productURL				\
    phone4sURL					\
    iddnewsURL					\
    muranowholesaleURL				\
    markis.infoURL				\
    smeakis.infoURL				\
    esellni.comURL				\
    freakes.infoURL				\
    cheappharm5.comURL				\
    cchelp.infoURL				\
    january2004URL				\
    ifbccch.infoURL				\
    leakis.infoURL				\
    makingthemost.netURL			\
    mypills4us.comURL				\
    kredis.infoURL				\
    URL67.165.24.16				\
    koqnophr.comURL				\
    pogmsa.comURL				\
    holdtiff.comURL				\
    hdhdljc.infoURL				\
    sterlinglendersURL				\
    basicrxmeds.comURL				\
    mobilestorm.comURL				\
    ivhjhp.comURL				\
    hortafer.infoURL				\
    recktome.infoURL				\
    operdmc.comURL				\
    money-bright.infoURL			\
    sun1statuss.infoURL				\
    my7sundew.infoURL				\
    ckadfgef.info				\
    advisor1deviation.info			\
    contactweb198.178.10.193			\
    sofnpn.info					\
    southusd.com				\
    dynamictelco.us				\
    softpyp.info				\
    adultfriendfinder.com			\
    sjdkfnkyb.com				\
    ejwitdabj.tablrl.info			\
    jfmivsct.tablrl.info			\
    qtgcj.tablrl.info				\
    orgz3m0ov6j862rs2wpgtj41.entitycdfjd.com	\
    comox1oo36fkc67g2hn2vw53.cohunehcnhk.com	\
    pdvyl.sofmym.info				\
    "

VALIDATED_DNS="							\
    wjsswmvo.org.mortpharm2005.com		\
    svpayr6ckvs97wkrqnju.iliacgnkln.com		\
    ajfyakh5do32i7vk1ycn.comerfbdll.com		\
    jtjr1y4unk1z6cjixtm.memutagebgf.com		\
    lzlikh5do32i7vk1ycn.smearefcfe.com		\
    mdmjnkqy9653syn4jfq.guacofknhb.com		\
    ngaxykicrx5gvush5cbqmx.seggaramblk.com	\
    ptbnjmheks30hx4shyv9k.blsoreenlg.com	\
    wkmuheks30hx4shyv9k.iliacgnkln.com		\
    yyrrsmmj7x8n42rfm3ie7.entitycdfjd.com	\
    yyumrn63rha7ombz652g9.cohunehcnhk.com	\
    gqphloss7v3ebaqxlsro2d.dutchibabd.com	\
    pxfh96ckds97w2r8n1u.editehkce.com		\
    vmibeiwtz7ixeu17wvsoh.taumldhfj.com		\
    cdusemj7x8n42rfm3ie7.kickdedeh.com		\
    qtzzbwc7ms0bq7nui763zs.gealldikk.com	\
    rktqpr6ckds97w2r851c.sadjhsdb.com		\
    zkus63rha7ombz652g9.solveaiamd.com		\
    mfmlwubvsgohedb0odu9ng.achoriadbl.com	\
    "

HTTP_VALIDATE="					\
    housingonthecheap.net			\
    "

DNS_VALIDATE="					\
    ampersandURL				\
    "

VALIDATEDampersandURLdomain=(			\
	"acananmdaf"				\
	"achoriadbl"				\
	"areaneebek"				\
	"boweldjaej"				\
	"casefydcngd"				\
	"comerfbdll"				\
	"dirknijkf"				\
	"dutchibabd"				\
	"editehkce"				\
	"felsjkdbm"				\
	"feralacjhk"				\
	"gainstgledh"				\
	"gealldikk"				\
	"guacofknhb"				\
	"hectorbdejc"				\
	"iliacgnkln"				\
	"mortpharm2005"				\
	"multumliakf"				\
	"paishnkmd"				\
	"remoraeiiin"				\
	"seggaramblk"				\
	"skilbmchg"				\
	"untowncjaad"				\
	"urnafomast"				\

    )

ampersandURLdomain=(				\
	"adipsygcjdh"				\
	"amotusfemmf"				\
	"blsoreenlg"				\
	"cavebjnkf"				\
	"cohunehcnhk"				\
	"entitycdfjd"				\
	"fpmqnzfbvf"				\
	"kickdedeh"				\
	"memutagebgf"				\
	"patacaglibn"				\
	"satangkeemk"				\
	"smearefcfe"				\
	"solveaiamd"				\
	"taumldhfj"				\
	"whuzgdaid"				\
	"wjncnbfj"				\
	"elleeielle0"				\
	"stetmlstet6"				\
	"tomentkfhlf"				\

    )

while :
do
    for url in $HTTP_VALIDATE
    do
        echo "###############################################" VALIDATING $url 1>&2
        wget --user-agent="Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)" -O /dev/null "`$url`"
        echo "################################################" VALIDATED $url 1>&2
    done

    for host in $DNS_VALIDATE
    do
        echo "###############################################" VALIDATING $host 1>&2
        rzq="`$host`"
        dig +noall +answer "$rzq"
        echo DONE "$rzq"
        echo "################################################" VALIDATED $host 1>&2
    done
done

exit 0

for f in semolina:/tmp world.std.com:local/script/ spineless.org:local/script/
do
    echo scp ~/local/script/validate $f
         scp ~/local/script/validate $f
done

# Not yet validated:

 http://11v5211se.onlinemedsw.com/banner/add2.jpg
 http://11v5211se.onlinemedsw.com/?user=209633
 http://12ub336fvcv.medsandmore.info/banner/add2.jpg
 http://12ub336fvcv.medsandmore.info?user=209633
 http://16pa2569.onlinemedsw.com/banner/add1.jpg
 http://16pa2569.onlinemedsw.com/?user=20
 http://16pa2569.onlinemedsw.com/?user=209633
 http://1drybsg.tabsinfofor.info/banner/add1.jpg
 http://1ehwngpkug.infomaillus.info?user=209633
 http://1wqnlaedl.infomaillus.info?user=209633
 http://1ylkld112.onlinemedsw.com/?user=209633
 http://1ylkld112.tabsinfofor.info/banner/add1.jpg
 http://3a54zvea12.medmedmed.info/banner/add1.jpg
 http://3a54zvea12.medmedmed.info/?user=209633
 http://3j112021.tabsinfofor.info/banner/add2.jpg
 http://3j112021.tabsinfofor.info/?user=2096
 http://3j112021.tabsinfofor.info/?user=209633
 http://3k696eve1.tabsinfofor.info/banner/add2.jpg
 http://3k696eve1.tabsinfofor.info/?user=209633
 http://54ic336fvcv.medsandmore.info/banner/add2.jpg
 http://54ic336fvcv.medsandmore.info/?user=209633
 http://54ic54fsea12.medsandmore.info/banner/add2.jpg
 http://54ic54fsea12.medsandmore.info/?user=209633
 http://aazewm.bobzpz.info/?5b13F47c800c0625139e9fc22Fd12ae1
 http://afgazxec.discoverandchoose.com/rx/halbaker/pnkggwre.htm
 http://aftummb.zazxqx.info/?a963850292b49F8ea95f10b845Fa6489
 http://akzhcnewf.bubxsx.info/?46cfFae9fdb4d46c83db66ab8F9fa5e6
 http://amidstj.baba-song-tamil.com/ads/mm4.jpg
 http://antbfi.tatzwz.info/?47c3a5b4F516b54ef7Fa7e7e06fb3bdb
 http://antispam.yahoo.com/domainkeys
 http://aoqghy&hnw%2Ecitipilcent.info/?YxufuZY22wzFcgsxblje
 http://aoqybyx&tok%2Ehootercdz.com/?4FCTC5AaaEHhkU4sulow
 http://autumnR.tooldropfat.com/fdeggoe.jpg
 http://avgkpo.healthpronews.com/?4F1aa1d253e7750Fe8b4270eb57def70
 http://avpkya.medsandmore.info/banner/add2.jpg
 http://ayfbrdbzt.org&xdxdn2qy9o53sgnmjfq.feralacjhk.com/
 http://bbuxrraed.andchoosethebest.com/rx/halba
 http://bcrkh.tablal.info/?a844bec99Fadc639a20efaF35bbf6c84
 http://bedraggleL.solutiondropfat.com=
 http://bedraggleL.solutiondropfat.com/ofdnsjpf.jpg
 http://beebreadK.click4system.info/r/
 http://bibft.andchoosethebest.com/rx/halbaker/vovzgc.php
 http://bjgfqssrrkj.org&qidzhw2a3ihx4ahyd92.paishnkmd.com/
 http://blhb%2Ecom%2Esolesbikje.%43om/?wB2P21w6CA7dgk0vthttp:www.hmfpvm%2Eco%4D
 http://bsohxxin.bubxyx.info/?395e00e141cbF81fd93Fd093f039e835
 http://btbq&feqb%2Everizemont.info/?16zQz2x7DBEKNRxsugnn
 http://bycbfqp&mkdxq%2Elesalive.info/?iTQBkjOUomV_y6Ojbei
 http://bymrzg.tatzyz.info/?89c0d7Fb2e59eee13817eFf085ed3511
 http://cavlpdo.bubxyx.info/?3b952415c7F0b81898aFb4325bd41d7e
 http://cgwyonv.bubxsx.info/?ad7e619bF93106466810487f44Fc8154
 http://childrenq.baba-song.com/gone.php
 http://ciexbgobgf.net&qjlnrwbh7ixwc17wvaoz%2Esogagmsoga1%2Ecom/
 http://civetL.solutiondropfat.com
 http://clnnkcb.bigrome.info/?Faaf5b279e8b7168a64ca22baa5F2d69
 http://commaL.tooldropfat.com
 http://constitutiveC.tooldropfat.com
 http://cpqbsa.bubxyx.info/?e9b755F065a4119a7cF282eb5bf597d2
 http://crbcz.lessg.com/?77cb698d5Fc4c83c1f1e62Fafb174ca0
 http://crlujeuu.com&emqw6lrza7omtho52y9.gainstgledh.com/
 http://d81402.u23.idthost.com
 http://decorateX.solutiondropfat.com/r/
 http://de.geocities.com/m_mourez?s=xxx&m=XVg.RQg,hVX
 http://dehydrateU.tooldropfat.com
 http://depositB.click4system.info
 http://docs.yahoo.com/info/terms/
 http://duocgtlz.andchoosethebest.com/rx/halbaker/wibezteu.php
 http://dwzboemc.arknoesa.com/rx/halbaker/zkhfy.html
 http://easyhouses1-2-3.net/eckkkyZMZZfZ19hBSpO/364/24/click.cgi?c=772
 http://easyhouses1-2-3.net/optout.aspx?cid=364&ec=eckkkyZMZZfZ19hBSpO
 http://ebdfgvizb.tatzqz.info/?ba75f5F2ae1223bbc253d951Fb6e186c
 http://ecqgd.arknoesa.com/rx/halbaker/apucjv.php
 http://edusjs.discoverandchoose.com/rx/halbaker/yjyhmbrmj.dcd
 http://ekpllrkia.andchoosethebest.com/rx/halbaker/lxafpez.html
 http://ekvzt.andchoosethebest.com/rx/halba
 http://erodjixdx.discoverandchoose.com/rx/halbaker/cjisspw.czc
 http://ewonfpdbko.net&kyhj2hnd6lkipd21gu5%2Eomarfjomar9%2Ecom/
 http://eyzbihsw.bubxsx.info/?77f35986Fe5898c47Fd7f6ad09886e09
 http://fcshv.foreverherestuff.com/rx/halbaker/hinnr.html
 http://fecwtf.tatzwz.info/?47c3a5b4F516b54ef7Fa7e7e06fb3bdb
 http://fmimq.arknoesa.com/rx/halbaker/mgfmrf.html
 http://fnjmqikk.bettergitit.com/h.php
 http://foldoutY.click4system.info/tgfe.jpg
 http://gkjvz%2Enet%2Ewjncnbfj.%63%4Fm/?rwZeZsXxxvyEHLrnrhttp:www.lgjbn%2Eco%6D
 http://gpbmyto.tatzyz.info/?F1f3322489e862af1cb5d81e349Fb405
 http://groups.yahoo.com/group/freecycleLowellMA/
 http://gwafnnx.tatzrz.info/?a200fa43a9F07761e9a82076F977272b
 http://hgndyuqhw.bubxyx.info/?395e00e141cbF81fd93Fd093f039e835
 http://housingonthecheap.net/eckkkyZMZZfZ19hBSpO/280/24/click.cgi?c=779
 http://housingonthecheap.net/optout.aspx?cid=280&ec=eckkkyZMZZfZ19hBSpO
 http://hpchbkxv.bobzpz.info/?52d1F0b7b4358ad406afeF4391a5a79b
 http://hqmxzu.simpleusa2000.com/b/VGRkMlcwTUk5bDA3ZmJqMEFvMDBERWw=
 http://hrcftnq.bubxsx.info/?46cfFae9fdb4d46c83db66ab8F9fa5e6
 http://iaazwjqujknr.org&mznotbqw4xcbrgmbs73w%2Etomentkfhlf%2Ecom/
 http://iabwvlhg.bubxyx.info/?e9b755F065a4119a7cF282eb5bf597d2
 http://iezjxondp.healthpronews.com/?4F1aa1d253e7750Fe8b4270eb57def70
 http://iifvvodh.tablwl.info/?0ef5f0F6ca023ed509cc59ae670aFdc9
 http://ijpafppnkye%2Ecom%2E%20.pkpinkgd192zywlryxuqj%2Edairyingmf.info#uhpjmgvifb%2Eorg
 http://ijvgzxhv.freedrivingg.info/?f272a517775cF6e7616ceF1e18871550
 http://indistinguishableN.tooldropfat.com/r/
 http://iuiqubjxwi.org&vfwk7msib8pnu0p6lzs.feralacjhk.com/
 http://ixlypamukh.org&ukzop0x3bm1ig5t0zeal.amotusfemmf.com/
 http://jeqypz.lessg.com/?71e060854fa86Ff01a4c7239129F2b4b
 http://jiqbr.bubxyx.info/?3b952415c7F0b81898aFb4325bd41d7e
 http://jiqfxa.bettergitit.com/k.php
 http://jkjunqtur.bigdeath.info/?19fe02dFf240e5133F0e605102eeca70
 http://jrbsa.bigdeath.info/?19fe02dFf240e5133F0e605102eeca70
 http://jwnwwss.discoverandchoose.com/rx/halbaker/cnphmm.htm
 http://jyeqpzvgb.arknoesa.com/rx/halbaker/wtcibc.php
 http://kcjlb.tablel.info/?c6F4d7198fc844d0d37890730F7ba568
 http://kcqkwmjy%2Eorg.%20.srnjyspdlebs8f3a962v%2Esemestraldj.info#ytiwywytsn%2Ecom
 http://kinhwx&ioq%2Edefunctionej.com/?mrUFUnmssqZ3CaSreopl
 http://kjxzers.whoareyouwow.com/rx/halbaker/bgvnxcnpn.zcc
 http://koqmnblt.andchoosethebest.com/rx/halbaker/cmcpx.htm
 http://kqslajwlp.zazxqx.info/?b6Fa574fcad5e1b59182F29016848e5a
 http://lboqx.bigfen.info/?36fcf79F9b0ce9bc8bc5F414fcfd7420
 http://ldvgqcr.com&nohmbus96ckds97w2r8n1u.patacaglibn.com/
 http://lifeboatt.baba-song-tamil.com/?affid=1025
 http://likenL.solutiondropfat.com
 http://ljrfm.andgoforbettervalue.com/rx/halbaker/ksdmg.dcd
 http://lujyt&wgo%2Evilapirosen.info/?KPMxgLKQQilXu2eufajj
 http://lxqb.tablel.info/?c6F4d7198fc844d0d37890730F7ba568
 http://lxubsai.bubxwx.info/?c9624445dae4Fd2639993255f5Fc8eef
 http://maqokcast.fructistree.info/?1831cF0ff1efebed0ddf16a4ddeF38a5
 http://mcwerbrzrnh.net&cjcqlxbqw4xcbrgmbs73w%2Eashyamashy9%2Ecom/
 http://mdrgolbqge%2Ecom
 http://mfmqidjwv.bubxsx.info/?77f35986Fe5898c47Fd7f6ad09886e09
 http://mndzbdieg.bobzez.info/?4Fe7c202cdcebd16F2c8bbc67d0dbc5f
 http://mtam&boeu%2Ealadfala9.com/?JOf0LKdjPhkqt1djlmf
 http://mvmmq.tablwl.info/?0ef5f0F6ca023ed509cc59ae670aFdc9
 http://niireabzi.tatzrz.info/?266Fdb503b04d77b209e1d1b9b6a8Fdb
 http://nyfulragk.bigrome.info/?b8653064Fa5895d296Fe150855820aff
 http://oaiglm.bubxtx.info/?6f84e91d5F532f68b38085573F93e57e
 http://ohfikmu.simpleusa2000.com/b/Mm5wMGg5cDBQN2VlSTAwRlIwTA==
 http://oiylf.lessg.com/?71e060854fa86Ff01a4c7239129F2b4b
 http://oodphwrkx.bubxyx.info/?3d9Fea20d360a92b7430F1ef3bdf3829
 http://oprfm.bubxwx.info/?329F18bb4f10d9f76F50bacb3edbf7be
 http://oqlww.andgoforbettervalue.com/rx/halbaker/wxubvm.dcd
 http://ouqcf.bigdeath.info/?b81e2Fc816c52134a61076c27Ffd5897
 http://oyoyntwz.bobzez.info/?4Fe7c202cdcebd16F2c8bbc67d0dbc5f
 http://oyykelde%2Enet.%20.otnoaa7dlets8f3s9okv%2Evilapirosen.info#ygrxwqz%2Enet
 http://pbcimvdi.andchoosethebest.com/rx/halbaker/vnbvugfw.php
 http://pbdkvzr.bigrome.info/?b8653064Fa5895d296Fe150855820aff
 http://pbkprer.tatzuz.info/?522cd981ebd69Ff101c58eF5e0ad7bb8
 http://pgdzosg.bettergitit.com/f.php
 http://pkbgudq.bettergitit.com/x.php
 http://pmfcut.bettergitit.com/a.php
 http://pqalpqoj.andchoosethebest.com/rx/halbaker/nxuogq.htm
 http://pqyg.tatzrz.info/?a200fa43a9F07761e9a82076F977272b
 http://pvdvmpu.net&wsoslbetzp0feuj7wva6h.untowncjaad.com/
 http://pytbhhnfm.tatzuz.info/?522cd981ebd69Ff101c58eF5e0ad7bb8
 http://qbcd&snj%2Edocmer.info/?r0teZsrx1_y8Hfrgguguw
 http://qiqmhg.goggogorx.com/banner/add1.jpg
 http://qmhjmurylln%2Enet%2E%20%2Eldytpbqemfcbrymtsp3e%2Emetronomicma.info#ttwtaiuwzxe%2Enet
 http://qmieeowzi.bettergitit.com/e.php
 http://quzcopgoo.bigrome.info/?Faaf5b279e8b7168a64ca22baa5F2d69
 http://qvazxen&vetw%2Erepertoirega.com/?3E5SBAzF9DGMPT3lsqqv
 http://qvkokhho.tatzyz.info/?F1f3322489e862af1cb5d81e349Fb405
 http://qwxjqzsgv.org&krogjmq5b1u9q6djqpm0b%2Estetmlstet6%2Ecom/
 http://qxeloimo.bigrome.info/?1Faaa952ed1cf5fd958938F461d17f48
 http://radsdlhc.net&vgefpsourfnyvuahnub8mx%2Eelleeielle0%2Ecom/
 http://rafcm.bigrome.info/?1Faaa952ed1cf5fd958938F461d17f48
 http://rbahqbfpw.bubxsx.info/?ad7e619bF93106466810487f44Fc8154
 http://rbcnboh&qbth.perfmper4.com/?ePgxMLKkQOlr.2ehmowjgx
 http://redactT.tooldropfat.com/vyow.jpg
 http://ribonucleicX.click4system.info
 http://rinyiw&lmw%2Etnhoklsq.com/?inkBQjOoUmV_26Oeksaz
 http://rmezyb.hosthealth.info/?9fF5accc2b39dcbb266Fe3747e0ea5e1
 http://rshij.whoareyouwow.com/rx/halbaker/ktnmzw.zcc
 http://rsvcsodgwwth%2Ecom%2E
 http://rwkthdnew.bettergitit.com/f.php
 http://ryrhjf.bubxyx.info/?3d9Fea20d360a92b7430F1ef3bdf3829
 http://skywaveS.tooldropfat.com
 http://sojncbuo.arknoesa.com/rx/halbaker/srlmtf.html
 http://stgtintl.com/1/email_builder/unsubscribed.php?message=oxymiddleast&cp_user_id_own=stgtintl&var=mod|world.std.com|oxymidest2
 http://stgtintl.com/1/email_builder/unsubscribed.php?message=oxyuae1&cp_user_id_own=stgtintl&var=mod|world.std.com|oxymidest2
 http://stgtintl.com/1/email_builder/unsub/wnxt_1120505526/stgtintl/mod|world.std.com/oxymidest2.html
 http://stgtintl.com/1/h/100/66936/832.html
 http://stgtintl.com/1/l/?34,66936,697
 http://stgtintl.com/1/l/?34,66936,698
 http://stgtintl.com/1/l/?54,66936,736
 http://stgtintl.com/1/w/100/66936.gif
 http://stgtintl.com/1/w/?34,66936
 http://stgtintl.com/1/w/?54,66936
 http://svmnlt.bubxwx.info/?329F18bb4f10d9f76F50bacb3edbf7be
 http://svwdvd.nnwatch.com/www/
 https://web.da-us.citibank.com/cgi-bin/citifi/portal/l/l.do?BV_UseBVCookie=yes
 http://tbnkplv&aghe%2Epilsimoner.info/?NmPAPOhTnRou15hjkkswne
 http://tgcji.tatzrz.info/?1927a71Fb1176b29ece62Fec5f25fd30
 http://tlpdpkwxx.com&votsfwetzp0feuj7wva6h%2Emacockmaco4.com/
 http://tlqrcqvcatcz.com&fzgkpl9oukvsr7w2rqn1c.cavebjnkf.com/
 http://tracbovd.tatzrz.info/?266Fdb503b04d77b209e1d1b9b6a8Fdb
 http://tssqa&njn%2Ewafddiwafd8.%43om/?kpm7SlkWqUr14Ekkafez
 http://ttfhbupglmbh.com&cpfhup4a0tq75ui76lha.adipsygcjdh.com/
 http://tudfpenvwngu.org&vuxcmqjl0owpmlj8w3khdo%2Esdlkfkb4islo%2Ecom/
 http://txybob.tatzyz.info/?89c0d7Fb2e59eee13817eFf085ed3511
 http://udxrpby.zazxqx.info/?a963850292b49F8ea95f10b845Fa6489
 http://udzgkv.hosthealth.info/?9fF5accc2b39dcbb266Fe3747e0ea5e1
 http://ujlrmo.fructistree.info/?1831cF0ff1efebed0ddf16a4ddeF38a5
 http://ultuec.charctermaytime.com/rx/halbaker/cbgygkqh.html
 http://uqnypvkix.bubxtx.info/?6f84e91d5F532f68b38085573F93e57e
 http://utgstwqlr.andchoosethebest.com/rx/halbaker/xdbdtu.html
 http://uxhlosvii.arknoesa.com/rx/halbaker/opuvwsphi.html
 http://uxpd&ffvg%2Ecismontaneef.com/?difwfeJPjNkWt1Jicvuj
 http://uzvfegree.andchoosethebest.com/z.php
 http://vaejxs.tablal.info/?a844bec99Fadc639a20efaF35bbf6c84
 http://vdpbxeq.tatzyz.info/?36735d7f5eaF21878aFc86d8d9207ed4
 http://vhgeiw.bubxwx.info/?c9624445dae4Fd2639993255f5Fc8eef
 http://vpnmsfzbe.simpleusa2000.net/b/cTIwUzkwZTcwc10wcDBb
 http://vqildcutl.zazxqx.info/?b6Fa574fcad5e1b59182F29016848e5a
 http://vqjwhy.tatzqz.info/?ba75f5F2ae1223bbc253d951Fb6e186c
 http://vrwwblza%2Ecom%2E%20%2Ehdrftinixlbmj0gnt0zwsl%2Enetgearx.info#yfkfots%2Ecom
 http://whiffL.tooldropfat.com/r/
 http://whofn.tatzrz.info/?1927a71Fb1176b29ece62Fec5f25fd30
 http://whtpr.charctermaytime.com/rx/halbaker/nuwoekc.html
 http://wjdmnjxhzpm.net&dhorpjcrf5gvcsh5utqmf%2Elettielett4%2Ecom/
 http://wnipi.bobzpz.info/?5b13F47c800c0625139e9fc22Fd12ae1
 http://wvkpimzec%2Enet%2E
 http://www.aic2000.org
 http://www.aic2000.org/experts/assignments/searches.asp
 http://www.aic2000.org/experts/cv/CV_center.asp
 http://www.aic2000.org/experts/membership/membership_center.asp
 http://www.citi.com/domain/images/citi44a.gif
 http://www.dkn.environmeorrela.com
 http://www.hosthealth.info/fgh.php
 http://www.mivzakim.com/orlyshay/company.htm
 http://www.mivzakim.com/orlyshay/images/main_bg.=
 http://www.mivzakim.com/orlyshay/lectures.htm
 http://www.mivzakim.com/orlyshay/orly.htm
 http://www.mivzakim.com/orlyshay/privet.htm
 http://www.mivzakim.com/orlyshay/styling.htm
 http://www.odessa-real-estate-investments.com/unsubscribe/26/53edbeb7ad8008cf144f15c92676e3d4/
 http://www.rvywvq.bzfcnmlxaytbdvc.crazy-biz.net/sev.asp?cxx=60368
 http://www.stgtintl.com/a/araboxy.jpg
 http://www.stgtintl.com/a/oxyarbc_02.jpg
 http://www.stgtintl.com/a/stgt1.jpg
 http://www.stopper.co.il/index.asp?shataf=fp
 http://www.w3.org/TR/REC-html40
 http://www.wgtydj.courtromaratho.com
 http://wxwr.infomaillus.info/banner/add1.jpg
 http://xalippluu.bettergitit.com/s.php
 http://xasrxmjj.lessg.com/?77cb698d5Fc4c83c1f1e62Fafb174ca0
 http://xkrpijgp.bobzpz.info/?52d1F0b7b4358ad406afeF4391a5a79b
 http://xmzws.bettergitit.com/u.php
 http://xstwaoou.andchoosethebest.com/rx/halbaker/jgdhvvpux.htm
 http://xvej&jbis%2Emolinaryjl.com/?lqnEnSlXXVY2B9loqmtc
 http://xxdwvblsderq%2Eorg%2E%20.kstkvjy4c5k1hoc10xb4%2Efilletingee.info#dlxkuthfmqc%2Enet
 http://yphekao.bigfen.info/?36fcf79F9b0ce9bc8bc5F414fcfd7420
 http://yshqczvu.andchoosethebest.com/rx/halbaker/gfzuktvs.php
 http://ytihe.simpleusa2000.net/b/cTIwUzkwZTcwc10wcDBb
 http://yujpgner.andchoosethebest.com/rx/halbaker/zyqdkrrpb.php
 http://yzwfwnj&kih%2Eundarkenedic.com/?ink5QjOUoSVv2Cijfvx
 http://zewya.foreverherestuff.com/rx/halbaker/lgtngdf.html
 http://zhebxuyf%2Ecom%2E
 http://zicus.tatzyz.info/?36735d7f5eaF21878aFc86d8d9207ed4
 http://zidmhft&eno%2Echancegl.com/?zEBSB43997GMjTzcamykf
 http://zsmhs.bigdeath.info/?b81e2Fc816c52134a61076c27Ffd5897
 http://zspwqrgemahs.com&nsnt3i6w7ml18w32hd6%2Esatangkeemk%2Ecom/
 http://zspwqrgemahs.com&nsnt3i6w7ml18w32hd6.satangkeemk.com/
 http://zufoy.freedrivingg.info/?f272a517775cF6e7616ceF1e18871550
 http://zymjjx.bettergitit.com/y.php
 http://nuuacdsv.bigsash.info/?0bFcbaa44ef81afb9Ff1dcbc910834f4
 http://vbhlasao.bigsash.info/?0bFcbaa44ef81afb9Ff1dcbc910834f4
 http://uskdlnmsq%2Eorg.%20.nxsmdeh1gmu5k1zoc10xb4%2Erouserdgcij.info#vmgnujotjv%2Eorg
 http://fpmkmtyu.andchoosethebest.com/rx/halbaker/yyhvxxwjx.php
 http://jykeiy.bettergitit.com/y.php
 http://xwbaoh.andchoosethebest.com/rx/halbaker/iskmwecno.php
 http://sxnyfvjuor%2Enet.%20.hwfyijgmun21h6u1iftm%2Ebarwaldgakg.info#eafuzosq%2Ecom
 http://wxrdzfznlmy%2Enet%2E
 http://klusihlnkbph%2Enet%2E%20%2Ezhdyspvlwts8flsr62v%2Ebarwaldgakg.info
 http://sceyaxvm%2Enet%2E
 http://wvuteqqvumle%2Ecom%2E%20%2Elyqnrb8e4xctrymts7lw%2Emorcellatedc.info#mwfaxal%2Enet
 http://telnhfmvztps%2Eorg.%20.tybkeylday6zwvtiodc9ng%2Emandrukamd.info#akgeqwtm%2Eorg
 http://uxgmckctn.bigsash.info/?F831c585b031591bee8f0d8fe6aFc2bb
 http://xaawk.bigsash.info/?F831c585b031591bee8f0d8fe6aFc2bb
 http://drghk.andgoforbettervalue.com/rx/halbaker/xdqdzdzxu.czc
 http://oyustb.andgoforbettervalue.com/rx/halbaker/nuftjx.czc
 http://vibxfhn.bettergitit.com/q.php
 http://gfajiptjj.andgoforbettervalue.com/rx/halbaker/qijjgbfs.zcc
 http://htsptiyr.bettergitit.com/j.php
 http://nyfitf.andgoforbettervalue.com/rx/halbaker/tpdyoaz.zcc
 http:\/sycgawoqpaaz%2Enet.%20.ndawgbqw4xcbrgmbs73w%2Ealwaysinstock.info
 http:/\gooqgzlqmzc%2Ecom%2E
 http:\/qfvutrsy%2Enet%2E
 http://gzqzojjz%2Ecom.%20.sdiylhen2qg9onlay541f8%2Egranchdlcdm.info#yiakbbnj%2Eorg
 http://jbsvhqyyr.enjoydays.info/?bdfd03f782F85c3d6bd056014fF5a3d3
 http://kfbnos.enjoydays.info/?bdfd03f782F85c3d6bd056014fF5a3d3
 http://uaurgau%2Enet%2E
 http://nblzjkw%2Eorg%2E
 http://jiegq.andchoosethebest.com/y.php
 http://kpmynpszd.andchoosethebest.com/rx/halbaker/mrzoemlf.htm
 http://viyakrmc.andchoosethebest.com/rx/halbaker/awdshcbuo.htm
 http://ouwkedaaj%2Ethebestwatchez.org#snjkzkggegvt.org/

############## SCRIPT ./mqueuePasa
#!/bin/csh -f
mailq >/tmp/mailq

while 1
	mv /tmp/mailq /tmp/mailqLast
	mailq >/tmp/mailq
	diff /tmp/mailqLast /tmp/mailq | grep '^>' | sed \
		-e '/no control file/d'
	echo "########################################################"
	sleep $argv
end

############## SCRIPT ./mungeSBlinks
#!/bin/csh -f
#set verbose

if ( ! -e ../O ) then
	echo "This script must be run in the"
	echo "root of the sandbox in question"
	echo "and the links O and S must exist"
	echo "in the appropriate places."
	exit 1
endif
set sb=`basename $cwd`
echo "Munging export/obj links in sandbox $sb"

set exportDirs=`find export -type d -print`
set objDirs=`find obj -type d -print`

mkdir -p ../O/$sb/export ../O/$sb/obj

rm -rf         export
ln -sf ../O/$sb/export export
pushd  ../O/$sb
foreach dir ( $exportDirs )
	mkdir -p $dir
end
popd

rm -rf         obj
ln -sf ../O/$sb/obj obj
pushd  ../O/$sb
foreach dir ( $objDirs )
	mkdir -p $dir
end
popd

pushd ../O/$sb
foreach dir ( link rc_files src tools )
	ln -s ../S/$sb/$dir $dir
end
popd

############## SCRIPT ./karen
 fromHack | sed -e 's/^[Tt][Oo]:[	 ].*$/To: KarenK@RackerCenters.org/'

############## SCRIPT ./noCR
tr -d "\015"

############## SCRIPT ./spam
# Assume stdin is a SPAM msg and forward it to ComCast
# as a uuencoded attachment.
#

tds=`tds`
tempFile1=/tmp/gzMailTemp$$`tds`
tempFile2=/tmp/gz2mailTemp$$`tds`

sed '1,/^[	 ]*$/{/^Return-Path: mod/d
/^(Message /d
}' >$tempFile1

cat <<EOF >$tempFile2
From:             "Michael ODonnell" <michael.odonnell@comcast.net>
Mail-Followup-To: "Michael ODonnell" <michael.odonnell@comcast.net>
Mail-Reply-To:    "Michael ODonnell" <michael.odonnell@comcast.net>
Reply-To:         "Michael ODonnell" <michael.odonnell@comcast.net>
To: missed-spam@comcast.net
Subject: missedSPAM-$tds (ComCast SPAM filters missed the attached message)
MIME-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_modMessageBoundary"

This is a multipart MIME message.

--==_modMessageBoundary
Content-Type: message/rfc822
Content-ID: <missedSPAM-$tds>
Content-Description: missedSPAM-$tds
Content-Transfer-Encoding: x-uuencode

`uuencode missedSPAM-$tds <$tempFile1`

EOF

/usr/lib/mh/post -watch -verbose $tempFile2

rm -f $tempFile1 $tempFile2

############## SCRIPT ./noCtrlZ
tr -d "\032"

############## SCRIPT ./sourceToolInit
#!/bin/bash
#!/usr/bin/bash
#!/opt/local/bin/bash
#!/n/viewserver/home/merlin/home2/bin/sun4/sos4/bash

############################################################################
# Given a list of source files in cscope.files
# this script will build tne necessary databases
# used by Glimpse, ctags and cscope
#

####
# The timeStamp is handy for generating any
# unique-per-script-invocation temp files and such...
#
 timeStamp=`date '+%Y%m%d%H%M%S'`
  tempFile=tempFile$timeStamp
      cTmp=cflowTemp$timeStamp

function gatherCflow()  {
    local f
    local x

    rm -f cflowResults cflowErrors
    for f in `cat cscope.files `
    do
        echo "###############################" BEGIN $f  >$cTmp
        echo "###############################" BEGIN $f          >>cflowErrors
        cflow -X -x -v -g -d 30 $f                      >>$cTmp 2>>cflowErrors
        echo "###############################"   END $f >>$cTmp
        echo "###############################"   END $f          >>cflowErrors
        x=`wc -l <$cTmp`
        if [ $x -gt 2 ]
        then
            cat $cTmp >>cflowResults
        fi
    done
}

function gatherCtags()  {
    local file

    #
    # Generate the ctags stuff piece-by-piece and then merge...
    #
    cat cscope.files | while read file
    do
        ctags --append                                                            $file
    #   ctags --append --defines --globals --members --no-warn --typedefs-and-c++ $file
    #   ctags --append                                         --c-types=cdefgmnstuvx $file
        cat tags >>$tempFile
        rm tags
    done
}

if [ ! -z "$1" ]                      # If any args supplied on command line...
then

####
# Preserve existing instance of cscope.files, if any...
#
 if [ -f cscope.files ]
 then
     mv                   cscope.files              cscope.files$timeStamp
     echo "####" Existing cscope.files preserved as cscope.files$timeStamp
 fi
fi                                                           # if [ ! -z "$1" ]

####
# Preserve existing instance of tags file, if any...
#
 if [ -f tags ]
 then
     mv                   tags              tags$timeStamp
     echo "####" Existing tags preserved as tags$timeStamp
 fi

#
# Generate the Glimpse and cscope databases in the background...
#
 glimpseindex -F -H . -E -B -n -o <cscope.files >.glimpseLog 2>&1 &
 cscope -b -u >cscopeDBgen.log 2>&1 &
#gatherCflow &                         # NOTE: accumulates results in  cflowLog
 gatherCtags &                         # NOTE: accumulates results in $tempFile

 wait

 gl '_GLOBAL'                           \
    | fgrep -v '#define'                \
    | fgrep -e '_GLOBAL('               \
    | sed -e 's/[:(]/ /g' -e 's/).*$//' \
    | while read file global tag ;      \
    do                                  \
        printf "%s	%s	/_GLOBAL(%s)/\n" $tag $file $tag >>$tempFile; \
    done

 sort -fd <$tempFile >tags

 rm -f $cTmp $tempFile

############## SCRIPT ./noHoaxMail
cat <<EndOfAntiHoaxMessage

Please do not propagate unverified email warnings about scams,
viruses and such.  To date, it has turned out that the warning
messages themselves are the harm, rather than the problems they
purport to describe.  Unless you have personally been victimized
by the scam or virus in question, you should assume (based on
the history of several dozens of such false warnings now) that
the warning messages are *themselves* the mechanism intended to
victimize us all, by wasting our time, diskspace and bandwidth.

EndOfAntiHoaxMessage

############## SCRIPT ./noHTML
cat <<EOF
X-Notice1: ===================================================================
X-Notice2: NOTICE: email sent to the address mentioned in the Sender: line in
X-Notice3:   this header (mod@semolina...) will NEVER arrive.    See Reply-To:
X-Notice4: ===================================================================
From: mod@std.com (Michael O'Donnell)
Reply-To: mod@std.com
cc: mod@std.com
Subject: No overly complex email encodings, please
To:
--------

Howdy,

Please allow me to beg you to please, PLEASE not transmit
your email messages using anything other than plain old ASCII
text, OK?  Please do NOT use any of the pointlessly tricky
formats like HTML, RichText, TNEF, quoted-printable, etc, etc.
Remember, even if you happen to use something like a WWW
browser to read your email that doesn't mean that everybody
else does.  Plain old ASCII text is the only thing that's
guaranteed to be readable by all email softwares.  Thanks...

Regards,
 ---------------------------------
 Michael O'Donnell     mod@std.com
 ---------------------------------

EOF

############## SCRIPT ./nonsense
function rzq()  {
	fmt -"$[($RANDOM % 200) + 45]"
}

sed -e 's/^/ /' -e 's/[]`^<=>,;:!?."('"'"')[{@|~}$@\\&\/#%+-]/ /g' -e 's/[	 ][	 ]*/ /g' | fmt -1 | sort -fd | uniq | rzq | sort -rfd | rzq | sort -fd | rzq | sort -rfd | rzq | sort -fd | fmt -500 | sed -e 's/$/\
/' | fmt -65

############## SCRIPT ./nospam
#!/bin/csh -f
onintr cleanUp

set tempFile=/tmp/tempFile$$

cat >$tempFile

echo "To: "
eat <$tempFile | fmt -1 | fgrep @ | sort -fdu
echo "abuse@"
echo "postmaster@"
echo "Subject: Abusive/annoying posts/messages from/through your site"
echo
echo
echo "I was spammed as shown below.  Why do you allow your customers/"
echo "clients to waste everybody's time, money, disk space and bandwidth"
echo "by broadcasting annoying, unsolicited email messages?  Please arrange"
echo "for this crap to cease IMMEDIATELY.  Thank you."
echo

echo "Regards,"
echo " ---------------------------------"
echo " Michael O'Donnell     mod@std.com"
echo " ---------------------------------"
echo
echo
echo
echo
echo

rq ' ' <$tempFile
echo

#
# One way or another, we're done.
#
cleanUp:
rm -f          \
    $tempFile    \

############## SCRIPT ./eatwhite
sed -e 's/[	 ][	 ]*/ /g'

############## SCRIPT ./osf_alums
cat <<EOF
Mail-Reply-To: "Michael ODonnell" <lucid+osfalums@skeptics.org>
From: "Michael ODonnell" <lucid+osfalums@skeptics.org>
Mail-Followup-To: "OSF alums" <osf_alums@egroups.com>
Reply-To: "OSF alums" <osf_alums@egroups.com>
To: "OSF alums" <osf_alums@egroups.com>
Subject:
EOF

############## SCRIPT ./packMHfolder
#!/bin/csh -f
if ( $argv == "" ) then
	echo $0 needs folder arg
	exit 1
endif
if ( ! -d $HOME/.mail/$argv ) then
	echo $0 Folder arg must be a directory - $argv
	exit 1
endif
cd $HOME/.mail/$argv

set tempMHfile=/tmp/tempMHfile$$

onintr cleanUp

cp /dev/null $tempMHfile
packf +$argv -file $tempMHfile \
	&& rm $HOME/.mail/$argv/* \
	&& inc +$argv -nosilent -file $tempMHfile \
	&& rm $tempMHfile

#
# One way or another, we're done.
#
cleanUp:
rm -f          \
    $tempMHfile

############## SCRIPT ./para
fmt -1 | fmt $@

############## SCRIPT ./paraCrunch
rq ' ' | eat | para $@

############## SCRIPT ./popcheck
#!/bin/sh
# \
exec sudo tclsh7.5 $0 ${@+"$@"}
#
# $Id: popcheck.MASTER,v 2.8 1996/04/24 13:10:38 loverso Exp loverso $
#
#
# Author: John Robert LoVerso <john@loverso.southborough.ma.us>
#
#       Copyright 1994, John Robert LoVerso
#
#       Permission to use, copy, modify, and distribute this software and its
#       documentation for any purpose and without fee is hereby granted,
#       provided that the above copyright notice appear in all copies.
#       The author makes no representations about the suitability of this
#       software for any purpose. It is provided "as is" without express

if [string match tkNewMail [file tail [pwd]]] {
	# fallback for testing
	set appDir .
	set auto_path [concat . lib $auto_path]
} else {
	# Default application path
	if [catch {set appDir $env(tkNewMailPATH)}] {
		set appDir /afs/ri/user/loverso/local/lib/tcl/tkNewMail
	}
	if ![catch {glob $appDir} path] {
		set auto_path [concat $path $auto_path]
	}
}

if [llength $argv] {
	switch -glob -- [lindex $argv 0] {
	-query	- -q* {set op 1}
	-count	- -c* {set op 2}
	-scan	- -s* {set op 3}
	}
	if [info exists op] {
		set argv [lrange $argv 1 end]
	}
}
if ![info exists op] {
	set op 2
}

proc msgchk {{u _}} {
	global op rpop env

	if [string match _ $u] {
		set u "You have"
		set d "You don't"
	} else {
		set env(USER) $u
		set d "$u doesn't"
		set u "$u has"
	}

	set s [rpop:size]
	if !$s {
		puts [format {%s have any mail waiting on %s} $d $rpop(host)]
		return $s
	}
	if {$op == 1} {
		puts [format {%s %d byte%s on %s} \
			$u $s [expr $s==1?"":"s"] $rpop(host)]
		return $s
	}
	set c [rpop:count]
	puts [format {%s %d message%s (%d byte%s) on %s} \
		$u $c [expr $c==1?"":"s"] $s [expr $s==1?"":"s"] $rpop(host)]

	if {$op == 3 && $c > 0} {
		puts [rpop:scan]
	}
	return $s
}

set exit 0
if [llength $argv] {
	foreach u $argv {
		if ![msgchk $u] {incr exit}
	}
} else {
	if ![msgchk] {incr exit}
}

exit $exit

############## SCRIPT ./pretty
#indent -bap -br -bs -ce -d1 -nei -eei -nfc1 -i4 -lp -npcs -psl -st
#indent -bap -br -bs -ce -d1      -eei -nfc1 -i4 -lp -npcs -psl -st

indent  --blank-lines-after-declarations                   \
        --blank-lines-after-procedures                     \
        --braces-on-if-line                                \
        --brace-indent2                                    \
        --braces-on-struct-decl-line                       \
        --break-before-boolean-operator                    \
        --case-indentation0                                \
        --cuddle-else                                      \
        --case-brace-indentation0                          \
        --dont-format-comments                             \
        --dont-line-up-parentheses                         \
        --dont-space-special-semicolon                     \
        --k-and-r-style                                    \
        --original                                         \
        --no-comment-delimiters-on-blank-lines             \
        --no-parameter-indentation                         \
        --no-space-after-casts                             \
        --no-space-after-function-call-names               \
        --procnames-start-lines                            \
        --standard-output                                  \
        --space-after-parentheses                          \
 | detab                                                   \
 | sed -e 's/ if *(/ if(/g'                                \
       -e 's/ while *(/ while(/g'                          \
       -e 's/ for *(/ for(/g'                              \
       -e 's/ switch *(/ switch(/g'                        \
       -e 's/ return *(/ return(/g'                        \
       -e 's/[	 ]*$//'                                    \
       -e '/[^	 ][	 ]{$/s/{$/ {/'                     \
       -e 's/([	 ]*)$/()/'                                 \
       -e 's/([	 ]*);$/();/'                               \
       -e 's/( *\(char *\**\) *)/(\1)/g'                   \
       -e 's/( *\(float *\**\) *)/(\1)/g'                  \
       -e 's/( *\(int *\**\) *)/(\1)/g'                    \
       -e 's/( *\(long  *int *\**\) *)/(\1)/g'             \
       -e 's/( *\(long *\**\) *)/(\1)/g'                   \
       -e 's/( *\(signed  *char *\**\) *)/(\1)/g'          \
       -e 's/( *\(signed  *int *\**\) *)/(\1)/g'           \
       -e 's/( *\(unsigned  *char *\**\) *)/(\1)/g'        \
       -e 's/( *\(unsigned  *int *\**\) *)/(\1)/g'         \
       -e 's/( *\(unsigned *\**\) *)/(\1)/g'               \
       -e 's/( *\(unsigned  *long  *int *\**\) *)/(\1)/g'  \
       -e 's/( *\(unsigned  *long\) *)/(\1)/g'             \
       -e 's/( *\(unsigned  *long *\*\) *)/(\1)/g'         \
       -e 's/( *\(signed  *long  *int *\**\) *)/(\1)/g'    \
       -e 's/( *\(void *\**\) *)/(\1)/g'                   \
       -e 's/( *void *)/(void)/g'                          \
       -e 's/( *\(short  *int *\**\) *)/(\1)/g'            \
       -e 's/( *\(short *\**\) *)/(\1)/g'                  \
       -e 's/( *\(unsigned  *short  *int *\**\) *)/(\1)/g' \
       -e 's/( *\(unsigned  *short\) *)/(\1)/g'            \
       -e 's/( *\(unsigned  *short *\*\) *)/(\1)/g'        \
       -e 's/( *\(signed  *short  *int *\**\) *)/(\1)/g'   \

exit 0

#       -bad, --blank-lines-after-declarations
#           Force blank lines after the declarations.
#
#       -bap, --blank-lines-after-procedures
#           Force blank lines after procedure bodies.
#
#       -bbb, --blank-lines-after-block-comments
#           Force blank lines after block comments.
#
#       -bbo, --break-before-boolean-operator
#           Prefer to break long lines before boolean operators.
#
#       -bc, --blank-lines-after-commas
#           Force newline after comma in declaration.
#
#       -bl, --braces-after-if-line
#           Put braces on line after if, etc.
#
#       -blin, --brace-indentn
#           Indent braces n spaces.
#
#       -bls, --braces-after-struct-decl-line
#           Put braces on the line after struct declaration lines.
#
#       -br, --braces-on-if-line
#           Put braces on line with if, etc.
#
#       -brs, --braces-on-struct-decl-line
#           Put braces on struct declaration line.
#
#       -bs, --Bill-Shannon, --blank-before-sizeof
#           Put a space between sizeof and its argument.
#
#       -cn, --comment-indentationn
#           Put comments to the right of code in column n.
#
#       -cbin, --case-brace-indentationn
#           Indent braces after a case label N spaces.
#
#       -cdn, --declaration-comment-columnn
#           Put comments to the right of the declarations in column n.
#
#       -cdb, --comment-delimiters-on-blank-lines
#           Put comment delimiters on blank lines.
#
#       -ce, --cuddle-else
#           Cuddle else and preceeding `}´.
#
#       -cin, --continuation-indentationn
#           Continuation indent of n spaces.
#
#       -clin, --case-indentationn
#           Case label indent of n spaces.
#
#       -cpn, --else-endif-columnn
#           Put comments to the right of #else and #endif statements in column n.
#
#       -cs, --space-after-cast
#           Put a space after a cast operator.
#
#       -dn, --line-comments-indentationn
#           Set indentation of comments not to the right of code to n spaces.
#
#       -din, --declaration-indentationn
#           Put variables in column n.
#
#       -fc1, --format-first-column-comments
#           Format comments in the first column.
#
#       -fca, --format-all-comments
#           Do not disable all formatting of comments.
#
#       -gnu, --gnu-style
#           Use GNU coding style.  This is the default.
#
#       -hnl, --honour-newlines
#           Prefer to break long lines at the position of newlines in the input.
#
#       -in, --indent-leveln
#           Set indentation level to n spaces.
#
#       -ipn, --parameter-indentationn
#           Indent parameter types in old-style function definitions by n spaces.
#
#       -kr, --k-and-r-style
#           Use Kernighan & Ritchie coding style.
#
#       -ln, --line-lengthn
#           Set maximum line length for non-comment lines to n.
#
#       -lcn, --comment-line-lengthn
#           Set maximum line length for comment formatting to n.
#
#       -lp, --continue-at-parentheses
#           Line up continued lines at parentheses.
#
#       -lps, --leave-preprocessor-space
#           Leave space between `#´ and preprocessor directive.
#
#       -nbad, --no-blank-lines-after-declarations
#           Do not force blank lines after declarations.
#
#       -nbap, --no-blank-lines-after-procedures
#           Do not force blank lines after procedure bodies.
#
#       -nbbo, --break-after-boolean-operator
#           Do not prefer to break long lines before boolean operators.
#
#       -nbc, --no-blank-lines-after-commas
#           Do not force newlines after commas in declarations.
#
#       -ncdb, --no-comment-delimiters-on-blank-lines
#           Do not put comment delimiters on blank lines.
#
#       -nce, --dont-cuddle-else
#           Do not cuddle } and else.
#
#       -ncs, --no-space-after-casts
#           Do not put a space after cast operators.
#
#       -nfc1, --dont-format-first-column-comments
#           Do not format comments in the first column as normal.
#
#       -nfca, --dont-format-comments
#           Do not format any comments.
#
#       -nhnl, --ignore-newlines
#           Do not prefer to break long lines at the position of newlines in the input.
#
#       -nip, --no-parameter-indentation
#           Zero width indentation for parameters.
#
#       -nlp, --dont-line-up-parentheses
#           Do not line up parentheses.
#
#       -npcs, --no-space-after-function-call-names
#           Do not put space after the function in function calls.
#
#       -nprs, --no-space-after-parentheses
#           Do not put a space after every ´(´ and before every ´)´.
#
#       -npsl, --dont-break-procedure-type
#           Put the type of a procedure on the same line as its name.
#
#       -nsc, --dont-star-comments
#           Do not put the `*´ character at the left of comments.
#
#       -nsob, --leave-optional-blank-lines
#           Do not swallow optional blank lines.
#
#       -nss, --dont-space-special-semicolon
#           Do not force a space before the semicolon after certain statements.  Disables `-ss´.
#
#       -nv, --no-verbosity
#           Disable verbose mode.
#
#       -orig, --original
#           Use the original Berkeley coding style.
#
#       -npro, --ignore-profile
#           Do not read `.indent.pro´ files.
#
#       -pcs, --space-after-procedure-calls
#           Insert a space between the name of the procedure being called and the `(´.
#
#       -pin, --paren-indentationn
#           Specify the extra indentation per open parentheses ´(´ when a statement is broken.See  STATEMENTS.
#
#       -pmt, --preserve-mtime
#           Preserve access and modification times on output files.See  MISCELLANEOUS OPTIONS.
#
#       -prs, --space-after-parentheses
#           Put a space after every ´(´ and before every ´)´.
#
#       -psl, --procnames-start-lines
#           Put the type of a procedure on the line before its name.
#
#       -sbin, --struct-brace-indentationn
#           Indent braces of a struct, union or enum N spaces.
#
#       -sc, --start-left-side-of-comments
#           Put the `*´ character at the left of comments.
#
#       -sob, --swallow-optional-blank-lines
#           Swallow optional blank lines.
#
#       -ss, --space-special-semicolon
#           On one-line for and while statments, force a blank before the semicolon.
#
#       -st, --standard-output
#           Write to standard output.
#
#       -T  Tell indent the name of typenames.
#
#       -tsn, --tab-sizen
#           Set tab size to n spaces.
#
#       -v, --verbose
#           Enable verbose mode.
#
#       -version
#           Output the version number of indent.

############## SCRIPT ./prettyMCLX
#indent -bap -br -bs -ce -d1 -nei -eei -nfc1 -i4 -lp -npcs -psl -st
#indent -bap -br -bs -ce -d1      -eei -nfc1 -i4 -lp -npcs -psl -st

indent  --blank-lines-after-declarations       \
        --blank-lines-after-procedures         \
        --braces-on-if-line                    \
        --brace-indent2                        \
        --braces-on-struct-decl-line           \
        --break-before-boolean-operator        \
        --case-indentation0                    \
        --cuddle-else                          \
        --case-brace-indentation0              \
        --dont-format-comments                 \
        --dont-line-up-parentheses             \
        --dont-space-special-semicolon         \
        --k-and-r-style                        \
        --original                             \
        --no-comment-delimiters-on-blank-lines \
        --no-parameter-indentation             \
        --no-space-after-casts                 \
        --no-space-after-function-call-names   \
        --procnames-start-lines                \
        --standard-output                      \
        --space-after-parentheses              \
 | detab                                       \
 | sed -e 's/ if  *(/ if(/g'                   \
       -e 's/ while  *(/ while(/g'             \
       -e 's/ for  *(/ for(/g'                 \
       -e 's/ switch  *(/ switch(/g'

#       -bad, --blank-lines-after-declarations
#           Force blank lines after the declarations.
#
#       -bap, --blank-lines-after-procedures
#           Force blank lines after procedure bodies.
#
#       -bbb, --blank-lines-after-block-comments
#           Force blank lines after block comments.
#
#       -bbo, --break-before-boolean-operator
#           Prefer to break long lines before boolean operators.
#
#       -bc, --blank-lines-after-commas
#           Force newline after comma in declaration.
#
#       -bl, --braces-after-if-line
#           Put braces on line after if, etc.
#
#       -blin, --brace-indentn
#           Indent braces n spaces.
#
#       -bls, --braces-after-struct-decl-line
#           Put braces on the line after struct declaration lines.
#
#       -br, --braces-on-if-line
#           Put braces on line with if, etc.
#
#       -brs, --braces-on-struct-decl-line
#           Put braces on struct declaration line.
#
#       -bs, --Bill-Shannon, --blank-before-sizeof
#           Put a space between sizeof and its argument.
#
#       -cn, --comment-indentationn
#           Put comments to the right of code in column n.
#
#       -cbin, --case-brace-indentationn
#           Indent braces after a case label N spaces.
#
#       -cdn, --declaration-comment-columnn
#           Put comments to the right of the declarations in column n.
#
#       -cdb, --comment-delimiters-on-blank-lines
#           Put comment delimiters on blank lines.
#
#       -ce, --cuddle-else
#           Cuddle else and preceeding `}´.
#
#       -cin, --continuation-indentationn
#           Continuation indent of n spaces.
#
#       -clin, --case-indentationn
#           Case label indent of n spaces.
#
#       -cpn, --else-endif-columnn
#           Put comments to the right of #else and #endif statements in column n.
#
#       -cs, --space-after-cast
#           Put a space after a cast operator.
#
#       -dn, --line-comments-indentationn
#           Set indentation of comments not to the right of code to n spaces.
#
#       -din, --declaration-indentationn
#           Put variables in column n.
#
#       -fc1, --format-first-column-comments
#           Format comments in the first column.
#
#       -fca, --format-all-comments
#           Do not disable all formatting of comments.
#
#       -gnu, --gnu-style
#           Use GNU coding style.  This is the default.
#
#       -hnl, --honour-newlines
#           Prefer to break long lines at the position of newlines in the input.
#
#       -in, --indent-leveln
#           Set indentation level to n spaces.
#
#       -ipn, --parameter-indentationn
#           Indent parameter types in old-style function definitions by n spaces.
#
#       -kr, --k-and-r-style
#           Use Kernighan & Ritchie coding style.
#
#       -ln, --line-lengthn
#           Set maximum line length for non-comment lines to n.
#
#       -lcn, --comment-line-lengthn
#           Set maximum line length for comment formatting to n.
#
#       -lp, --continue-at-parentheses
#           Line up continued lines at parentheses.
#
#       -lps, --leave-preprocessor-space
#           Leave space between `#´ and preprocessor directive.
#
#       -nbad, --no-blank-lines-after-declarations
#           Do not force blank lines after declarations.
#
#       -nbap, --no-blank-lines-after-procedures
#           Do not force blank lines after procedure bodies.
#
#       -nbbo, --break-after-boolean-operator
#           Do not prefer to break long lines before boolean operators.
#
#       -nbc, --no-blank-lines-after-commas
#           Do not force newlines after commas in declarations.
#
#       -ncdb, --no-comment-delimiters-on-blank-lines
#           Do not put comment delimiters on blank lines.
#
#       -nce, --dont-cuddle-else
#           Do not cuddle } and else.
#
#       -ncs, --no-space-after-casts
#           Do not put a space after cast operators.
#
#       -nfc1, --dont-format-first-column-comments
#           Do not format comments in the first column as normal.
#
#       -nfca, --dont-format-comments
#           Do not format any comments.
#
#       -nhnl, --ignore-newlines
#           Do not prefer to break long lines at the position of newlines in the input.
#
#       -nip, --no-parameter-indentation
#           Zero width indentation for parameters.
#
#       -nlp, --dont-line-up-parentheses
#           Do not line up parentheses.
#
#       -npcs, --no-space-after-function-call-names
#           Do not put space after the function in function calls.
#
#       -nprs, --no-space-after-parentheses
#           Do not put a space after every ´(´ and before every ´)´.
#
#       -npsl, --dont-break-procedure-type
#           Put the type of a procedure on the same line as its name.
#
#       -nsc, --dont-star-comments
#           Do not put the `*´ character at the left of comments.
#
#       -nsob, --leave-optional-blank-lines
#           Do not swallow optional blank lines.
#
#       -nss, --dont-space-special-semicolon
#           Do not force a space before the semicolon after certain statements.  Disables `-ss´.
#
#       -nv, --no-verbosity
#           Disable verbose mode.
#
#       -orig, --original
#           Use the original Berkeley coding style.
#
#       -npro, --ignore-profile
#           Do not read `.indent.pro´ files.
#
#       -pcs, --space-after-procedure-calls
#           Insert a space between the name of the procedure being called and the `(´.
#
#       -pin, --paren-indentationn
#           Specify the extra indentation per open parentheses ´(´ when a statement is broken.See  STATEMENTS.
#
#       -pmt, --preserve-mtime
#           Preserve access and modification times on output files.See  MISCELLANEOUS OPTIONS.
#
#       -prs, --space-after-parentheses
#           Put a space after every ´(´ and before every ´)´.
#
#       -psl, --procnames-start-lines
#           Put the type of a procedure on the line before its name.
#
#       -sbin, --struct-brace-indentationn
#           Indent braces of a struct, union or enum N spaces.
#
#       -sc, --start-left-side-of-comments
#           Put the `*´ character at the left of comments.
#
#       -sob, --swallow-optional-blank-lines
#           Swallow optional blank lines.
#
#       -ss, --space-special-semicolon
#           On one-line for and while statments, force a blank before the semicolon.
#
#       -st, --standard-output
#           Write to standard output.
#
#       -T  Tell indent the name of typenames.
#
#       -tsn, --tab-sizen
#           Set tab size to n spaces.
#
#       -v, --verbose
#           Enable verbose mode.
#
#       -version
#           Output the version number of indent.

############## SCRIPT ./prettyVarList
lineup | rq '    '

############## SCRIPT ./queuePasa
#ps -j -a -x -Oc >/tmp/psNow
    ps -eaf         >/tmp/psNow

while :
do
    mv /tmp/psNow /tmp/psLast
#   ps -j -a -x -Oc >/tmp/psNow
    ps -eaf         >/tmp/psNow
    diff /tmp/psLast /tmp/psNow
    echo "########################################################"
    sleep $1
done

############## SCRIPT ./literalBASHargs

declare -a argv=("")
argv[0]=$0
argc=1

function backslashedQuotes()  {
	echo "$@" | sed -e 's/"/\\"/g'
}

while [ $# -gt 0 ]
do
	argv[$argc]="`backslashedQuotes "$1"`"
	let argc++
	shift
done

function allMyArgs()  {
	x=1
	while [ $x -lt $argc ]
	do
		echo '"'${argv[$x]}'"'
		let x++
	done
}

# You can now invoke other progs with your own
# command line with each arg string quoted.
# In this example we just use ls...

eval ls -l `allMyArgs`

############## SCRIPT ./requote
unquote | para -70 | rq

############## SCRIPT ./reset-button
#!/bin/sh
# \
exec wish -f $0 ${@+"$@"}

#
# $Id: reset-button,v 1.1 1994/10/27 16:40:10 loverso Exp loverso $
#

set mule /afs/ri/project/norma-nd/farm/bin/mule		;# path to mule

lappend auto_path /afs/ri/user/loverso/local/lib/tcl	;# for tlog

set host [lindex $argv 0]
if {$host == ""} {
	puts stderr "Usage: reset-button <host>"
	exit 1
}

pack [frame .top] -fill x
button .top.resetButton -text "$host OFFthenON" \
	-command [list ButtonHold .top.resetButton do-reset $host]
pack .top.resetButton -side left

frame .log

proc ButtonHold {w args} {
	$w config -state disabled
	update idletasks
	set ret [catch {uplevel $args}]
	update				;# flush addition user button presses
	$w config -state normal
	return $ret
}

proc do-reset {host} {
	global mule

	pack .log
	tlog-create .log 0 0 1
	update
	tlog-add .log Resetting $host at [exec date]...

	if [catch {
		set f [open "|$mule -f -reset $host" r]
		while {[gets $f line] != -1} {
			tlog-add .log $line
			update
		}
		close $f
	} err] {
		tlog-add .log Error: $err
	} else {
		after 2000 {tlog-destroy .log}
	}
}

############## SCRIPT ./reset-buttonMOD
#!/bin/sh
# \
exec wish -f $0 ${@+"$@"}

#
# $Id: reset-button,v 1.1 1994/10/27 16:40:10 loverso Exp loverso $
#

set mule /afs/ri/project/norma-nd/farm/bin/mule		;# path to mule

lappend auto_path /afs/ri/user/loverso/local/lib/tcl	;# for tlog

set host [lindex $argv 0]
if {$host == ""} {
	puts stderr "Usage: reset-button <host>"
	exit 1
}

pack [frame .top] -fill x
button .top.resetButton -text "$host OFFthenON" \
	-command [list ButtonHold .top.resetButton do-reset $host]
pack .top.resetButton -side left

frame .log

proc ButtonHold {w args} {
	$w config -state disabled
	update idletasks
	set ret [catch {uplevel $args}]
	update				;# flush addition user button presses
	$w config -state normal
	return $ret
}

proc do-reset {host} {
	global mule

	pack .log
	tlog-create .log 0 0 1
	update
	tlog-add .log Resetting $host at [exec date]...

	if [catch {
		set f [open "|$mule -f -powercycle $host" r]
		while {[gets $f line] != -1} {
			tlog-add .log $line
			update
		}
		close $f
	} err] {
		tlog-add .log Error: $err
	} else {
		after 2000 {tlog-destroy .log}
	}
}

############## SCRIPT ./resetProduct
#!/bin/csh -f
yes y | /afs/ri/project/norma-nd/farm/bin/reset-farm product

############## SCRIPT ./resume
# Currently, no particular shell being explicitly invoked...
#!/u/bin/bash
#!/opt/local/bin/bash
#!/n/viewserver/home/merlin/home2/bin/sun4/sos4/bash
#!/bin/bash

cat <<EOF
                  Systems Software Developer: UNIX/C/Kernel

                              Michael O'Donnell
                              67 Prescott Drive
                          North Chelmsford, MA 01863
                          (978)251-7576  mod@std.com

                           ====---- Skills ----====

   Operating systems internals in SMP/realtime environments
   C/C++, Assembler (Motorola PPC/680x0, Intel x86/i860, MIPS R3000)
   ClearCASE, build/release engineering, scripting

                         ====---- Experience ----====

Mission Critical Linux, Lowell MA                               (8/00-present)
 Kernel Engineer

   Port Linux to various embedded/custom PPC systems; develop support
   code for Galileo GT64260 system controller, ethernet, MMU setup,
   interrupt handling and PCI initialization.  Advise client during
   design phase of SMP-capable interrupt-routing circuitry.

   Periodically serve 24x7 on-call duty to assist support-contract clients;
   analyze/repair internally and externally reported defects in Linux.

Mercury Computer Systems, Chelmsford MA                            (3/98-7/00)
 Senior Software Engineer

   Develop a scalable spinlock subsystem for Mercury multicomputers;
   deploy in heterogenous systems comprising more than 256 processors.

   Analyze/repair internally and externally reported defects in MC/OS.

   Improve sourcecode analysis tools; introduce Glimpse/ctags and
   create scripts enabling Cscope to operate in Mercury development
   environment.  Produce example programs illustrating use of
   software synchronization algorithms on Mercury multicomputers.

The Open Group (formerly OSF) Research Institute, Cambridge MA     (7/94-8/97)
 Senior Research Engineer

   Serve as technical liaison to corporate client for the duration of
   an ARPA-funded project; advise and participate in development of
   realtime execution environment for client's target system based on
   Paragon supercomputer technology and OSF1/Mach; perform wide range of
   development and support tasks; travel to client site intermittently
   to assist in configuration/deployment and for general handholding.

   Port OSF1/Mach kernel from uni- to multi-processor Paragon nodes;
   primarily responsible for low-level interrupt and memory management
   code; hit all milestones in an aggressive schedule.  (team of 3)

   Participate in development of Java runtime environment using C++;
   implement portions of the Java Virtual Machine supporting math
   primitives, switch statements, arrays, etc;  port entire project
   from Gnu G++ to a pre-release version of HP's aCC; maintain/enhance
   scripts and rules files in ClearCase-based development environment.

Concurrent Computer Corporation, Westford, MA                     (12/89-6/94)
 Senior Software Engineer, RTU(RealTime UNIX) development group

   Design and develop RTU kernel subsystem for managing specialized
   counter-timer hardware; develop syscall interface and user libraries
   implementing a Posix 1003.4-compliant interface to that subsystem.

   Port RTU from Concurrent's 68030 to SMP 68040 system.  (team of 3)

   Debug and enhance RTU kernel, libraries and utilities; includes
   VM, exception handling, filesystem, kernel debugger and SMP
   synchronization issues.

   Perform onsite debug/enhancement of customer applications and RTU;
   involves international travel.  (Salvage some critical accounts.)

   Port utilities/libraries from 680x0 systems to MIPS R3000 system.

   Develop standalone diagnostics monitor for Concurrent's 680x0 and
   MIPS R3000 platforms; port standalone utilities to run w/this monitor;
   rework monitor on short notice to serve as R3000 system boot ROM.

Wang Laboratories, Lowell, MA                                    (11/84-12/89)
 Software Engineer, Wang VS UNIX Group

   Participate in port of VS UNIX kernel from VM environment to Native
   VS.  Debug and enhance kernel, libraries and utilities.  (team of 3)

   Install, debug and support VS UNIX in both native and Virtual
   Machine environments on various departmental systems within Wang.

   Institute management of VS UNIX sources using Berkeley Revision
   Control System; arrange nightly and multi-version builds/releases.

 Software Engineer, Wang Xenix Group

   Develop 80286 Xenix device drivers for SCSI disks and tapes, QIC-02
   tapes, bitmapped CRT and for virtual disks via (proprietary) network
   link to WANG file server.

   Diagnose bugs in Xenix kernel, libraries and utilities without sources.

 Software Engineer, Wang Desktop Systems Group

   Enhance Wang 8086 PC's emulation of the IBM-PC; port emulation
   subsystem to Wang's 80286 APC; develop emulation BIOS code and
   rework existing routines in an "intellectual property clean room".

   Develop MS-DOS virtual disk device driver utilizing (proprietary)
   network link to WANG file server.

   Serve as liaison to hardware group developing an ASIC implementation
   of an instruction prefetch monitor for the 80286; write an assembler
   to aid in programming the state-machine PAL.

Analogic Corporation Peabody, MA                                  (7/82-11/84)
 Programmer

   Develop firmware to control/tune a high-power RF amplifier for an MRI
   system; invent simple multitasking executive, control stepper motors,
   coordinate sensor data, communicate with host.

   Debug 68000 assembler routines in the D6000 waveform analyzer.

   Design and develop a debugging tool using C and 68000 assembler.

 Technician (contracting)

   Breadboard and debug prototypes of hardware designs

Kollsman Instruments Nashua, NH                                   (12/81-4/82)
 Technician (contracting)

   Test/troubleshoot the Cobas-BIO blood spectroanalyzer in production.

Raytheon Flight Facility Bedford, MA                              (8/81-11/81)
 Technician (contracting)

   Construct chassis and cables for military avionics systems.

New England Business Service Peterborough, NH                     (11/78-7/81)
 Mechanic

   Maintain, repair and rebuild high volume bulk mail processing
   equipment and polychrome offset printing presses.

   Produce tight-register polychrome offset printing work including
   thermography and MICR document jobs.

   Maintain spare parts inventory; generate and expedite purchase orders;
   perform QC/QA, training and supervisory functions

                         ====---- Education ----====

Associate Degree in Arts                                                (1977)
Manatee Community College Bradenton, FL

Additional studies in:                                             (1982-1997)
   Calculus, C/C++, Assembler language, compiler construction,
   object oriented programming, economics, UNIX SVR4 ESMP internals

                         ====---- Security ----====

   U.S. citizen, Confidential clearance.

                         ====---- Interests ----====

   Reading, music, computers, cooking and juggling.

             ====---- References available upon request. ----====

EOF

############## SCRIPT ./retab
#!perl

# Usage: retab [-<tabwidth>] [files]

$sw = 8;
$sw = $1, shift if $ARGV[0] =~ /^-(\d+)/;

while (<>) {
        s#^(\t+)#' ' x (length($1) * 8)#e;
        s#^( *)#' ' x (length($1) * $sw / 8)#e;
        s#^(( {8})*)#"\t" x (length($1) / 8)#e;
        print;
}

############## SCRIPT ./reverseLines
rq 'RZQ' | cat -n | sort -rn | sed -e 's/^  *[0-9][0-9]*	RZQ//'

############## SCRIPT ./rightJustify
#
# After capturing stdin in a temp file, we note the widest token
# length and use that information to generate an AWK format string
# suitable for use during a second pass, in which we actually emit
# (as stdout) the right-justified text.
#

   timeStamp=`date '+%Y%m%d%H%M%S'`
    tempFile=/tmp/$$tempFile$timeStamp
nawkCommandScript=/tmp/$$format$timeStamp

fmt -1          > $tempFile
lineup dummyArg < $tempFile | head -1 \
  | sed -e 's/-//' -e 's;\\;;' >$nawkCommandScript
chmod +x               $nawkCommandScript
sed -e 1d <$tempFile | $nawkCommandScript
rm   -f $nawkCommandScript  $tempFile

############## SCRIPT ./rot-1
tr "[1-9][B-Z][b-z]Aa0" "[0-8][A-Y][a-y]Zz9"

############## SCRIPT ./rot1
tr "[0-8][A-Y][a-y]Zz9" "[1-9][B-Z][b-z]Aa0"

############## SCRIPT ./rot13
tr "[a-m][n-z][A-M][N-Z]" "[n-z][a-m][N-Z][A-M]"

############## SCRIPT ./isolateEmailHeaderLines
sed -r -e '/^[	 ]*$/,$d' -e '/^[^	 ]/ s/^/\
/' | fmt -3000

#sed -r -e '/^[	 ]*$/,$d' -e '/^[^	 ]/ s/^/\
#/' -e 's/^[	 ]+/RZQ /' | fmt -3000 | sort -fd | cat -s | sed -e 's/ RZQ /\
#	/g'

############## SCRIPT ./SED/c++2ccmnt.sed
/\/\// {
	s/\/\//\/*/
	s/$/ *\//
}

############## SCRIPT ./SED/killHeader.sed
s/\[/\\[/g
s;/;\\/;g
s/^/\//
s/$/\/h:k/

############## SCRIPT ./nightmoves
cat <<EOF
043816729  L
067294381  H
16729438   L
18349276   H
27618349   L
29438167   H
34927618   L
38167294   H
43816729   L
49276183   H
5043816729 L
5067294381 H
61834927   L
67294381   H
72943816   L
76183492   H
81672943   L
83492761   H
92761834   L
94381672   H
EOF

############## SCRIPT ./shdb
echo echo '"######## Checkpoint"' `timeDateString`
cat

############## SCRIPT ./shuffle2front
#!/bin/csh -f
set holdFile=/tmp/holdFile$$
foreach f ( $argv )
	echo ""          >>$holdFile && \
	cat $HOME/.mail/inbox/$f >>$holdFile && \
	echo ""          >>$holdFile && \
	rm $HOME/.mail/inbox/$f
end
inc -nosilent -file $holdFile && rm $holdFile

############## SCRIPT ./sig
cat <<EOF

Regards,
 ---------------------------------------------------
 michael.odonnell@comcast.net
 ---------------------------------------------------
                    (978)251-7576
                  67 Prescott Drive
              N. Chelmsford MA 01863 USA
                 Work: (978)461-7294

  ###########################################
  # This transmission has not been approved #
  #   by the Office of Homeland Security.   #
  ###########################################

  _____________________________________________
  «¤»¥«¤»§«¤»¥«¤»§«¤»¥«¤»«¤»¥«¤»§«¤»¥«¤»§«¤»¥«¤»
  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯

EOF

exit 0

cat <<EOF

Regards,
          Michael O'Donnell
        Mission Critical Linux
          978-446-9166 x361

 ---------------------------------------------------
 Michael O'Donnell     (978)251-7576     mod@std.com
 ---------------------------------------------------
                     67 Prescott Drive
                 N. Chelmsford MA 01863 USA

EOF

############## SCRIPT ./sigN
cat <<EOF

Regards,
 -------------------------------------------
 Michael O'Donnell     m o d @ s t d . K o m      Copyright (c) 1997
 -------------------------------------------

P.S.  If replying via email, note the  e x p a n d e d
      address supplied in my signature line, where K=c

From: abuse@localhost
From: postmaster@localhost
From: webmaster@localhost
From: postmaster%fbi.gov@std.com
From: ljfreeh%fbi.gov@std.com (FBI Director Louis J. Freeh)
From: comments.iptf%fbi.gov@std.com (Infrastructure Protection Task Force)
From: houston%fbi.gov@std.com (FBI - Houston office)
From: jquello%fcc.gov@std.com (FCC Commissioner James Quello)
From: rchong%fcc.gov@std.com  (FCC Commissioner Rachelle Chong)
From: rhundt%fcc.gov@std.com  (FCC Chairman     Reed Hundt)
From: sness%fcc.gov@std.com   (FCC Commissioner Susan Ness)

EOF

############## SCRIPT ./sme
eclean | sed \
        -e '/^Subject:.*\[MilCom]/s/ *\[MilCom] */ /'       \
        -e '/^Subject:.*\[NEST]/s/ *\[NEST] */ /'           \
        -e '/^Subject:.*\[NE-SWL]/s/ *\[NE-SWL] */ /'       \
        -e '/^Subject:.*\[osf_alums]/s/ *\[osf_alums] */ /' \
        -e '/^Subject:.*\[SCAN-NH]/s/ *\[SCAN-NH] */ /'     \
        -e '/^Subject:.*\[SME]/s/ *\[SME] */ /'             \
        -e '/^Subject:.*\[SMW]/s/ *\[SMW] */ /'             \
        -e '/^Subject:.*\[WUN]/s/ *\[WUN] */ /'             \

############## SCRIPT ./smile
cat <<EOF
                                  #######
                                 #       #
                               #  O     O  #
                              #             #
                              #     O       #
                              #  \     /    #
                              #   \   /     #
                               #   \_/     #
                                 #       #
                                  #######
EOF

############## SCRIPT ./snapDeleted
#!/bin/bash
#
# Snapshot & compress the current contents of the deleted folder
# in a newly-created-for-the-occasion subdirectory of deleted/SNAP
#
GNUTAR=tar
NOW=`timeDateString`

for f in $HOME/.mail/deleted/SNAP $HOME/DeletedMailSNAP
do
    if [ ! -d $f ]
    then
        echo You have no directory named $f
        exit 1
    fi
done

cd $HOME/.mail
folder -pack +deleted \
 && sortm -textfield subject -nolimit -verbose +deleted \
 && mv           deleted $NOW \
 && mkdir        deleted \
 && mv $NOW/SNAP deleted \
 && mv $NOW      deleted/SNAP \
 && cd           deleted/SNAP \
 && scan        +deleted/SNAP/$NOW >$NOW/scanList$NOW \
 && find $NOW -type f -print | sort -t / +1 -nfd >$NOW/ContenTable \
 && $GNUTAR -c -v -z -f $NOW.tgz -T $NOW/ContenTable \
 && rm -f $NOW/[0-9]* $NOW/.[em]* $NOW/ContenTable \
 && mv $NOW.tgz $NOW \
 && mv $NOW $HOME/DeletedMailSNAP/$NOW

############## SCRIPT ./snapshotChangedFiles
#
# This script finds all files newer than the last SNAPSHOT file
# and names them in the $snapShotList which is then mentioned in
# order that the user have an opportunity to edit it before it's
# used during creation of the curent snapshot.  O'Donnell 960817
#
lastSnapshot=`ls SNAPSHOT/snapshot9* | tail -1`
GNUTAR=/usr/local/gnu/bin/tar
snapShotList=/tmp/snapshot$$
find . -type f -newer $lastSnapshot -print >$snapShotList
echo "#################### snapShotList is $snapShotList :"
cat $snapShotList
echo "#################### hit Return when ready..."
read uselessData
thisSnapshot=SNAPSHOT/snapshot`tds`.tgz
echo "############################## Creating $thisSnapshot..."
$GNUTAR -c -v -z -f $thisSnapshot -T $snapShotList
rm -f $snapShotList

############## SCRIPT ./sortByLength

   timeStamp=`date '+%Y%m%d%H%M%S'`
    tempFile=/tmp/$$tempFile$timeStamp
formatString=/tmp/$$format$timeStamp

fmt -1 | rq ' ' | eat | fmt -1 >$tempFile

formatString=`lineup dummyArg <$tempFile | head -1 | sed -e 's/-//' -e 's;\\\;;' `

eval $formatString <$tempFile | sort -fdu | rq ' ' | eat

rm   -f $formatString  $tempFile

############## SCRIPT ./ssp
cat -r

############## SCRIPT ./stdin2ps
#!/bin/csh -f

set psFile=/tmp/catps$$

onintr cleanUp

cat >$psFile
ghostview -forceorientation -landscape -magstep 2 $psFile

#
# One way or another, we're done.
#
cleanUp:
rm -f          \
    $psFile

############## SCRIPT ./stdinc
#!/bin/csh -f
set holdFile=/tmp/holdFile$$
echo ""          >$holdFile && \
cat                     >>$holdFile && \
echo ""         >>$holdFile && \
inc -nosilent -file $holdFile && \
rm $holdFile

############## SCRIPT ./stockLossRecovery
#
#
#
#
# Original purchase:         (200 * 32.625) + 12  =  6537.000
#
# Recovery purchase:         (200 * 28.625) + 12  =  5737.000
# Recovery target:   ((6537.000 + 5737.000) + 12) = 12286.000
#                                 12286.000 / 400 =    30.715
#
#
# Recovery purchase:         (200 * 27.625) + 12  =  5537.000
# Recovery target:   ((6537.000 + 5537.000) + 12) = 12086.000
#                                 12086.000 / 400 =    30.215
#

function floatQuotient()
{
    echo "$1 / $2"           | bc -l
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

function floatProduct2()
{
    echo "$1 * $2"           | bc -l
}

function floatProduct3()
{
    echo "$1 * $2 * $3"      | bc -l
}

function floatProduct4()
{
    echo "$1 * $2 * $3 * $4" | bc -l
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

function floatSum2()
{
    echo "$1 + $2"           | bc -l
}

function floatSum3()
{
    echo "$1 + $2 + $3"      | bc -l
}

function floatSum4()
{
    echo "$1 + $2 + $3 + $4" | bc -l
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

commission=12.0

echo -n "priceOfOriginalShares:	"
read     priceOfOriginalShares

echo -n "numberOfOriginalShares:	"
read     numberOfOriginalShares

temp=`floatProduct2 $priceOfOriginalShares $numberOfOriginalShares`
originalExpenditure=`floatSum2 $temp $commission`

originalAverage=`floatQuotient $originalExpenditure $numberOfOriginalShares`

echo "originalExpenditure:	$originalExpenditure"
echo "originalAverage:	$originalAverage"

echo "####"
echo -n "priceOfRecoveryShares:	"
read     priceOfRecoveryShares

echo -n "numberOfRecoveryShares:	"
read     numberOfRecoveryShares

temp=`floatProduct2 $priceOfRecoveryShares $numberOfRecoveryShares`
recoveryExpenditure=`floatSum2 $temp $commission`

recoveryAverage=`floatQuotient $recoveryExpenditure $numberOfRecoveryShares`

echo "recoveryExpenditure:	$recoveryExpenditure"
echo "recoveryAverage:	$recoveryAverage"

overallExpenditure=`floatSum3 \
                      $originalExpenditure $recoveryExpenditure $commission`
echo "overallExpenditure:	$overallExpenditure"

temp=`floatSum2 $numberOfOriginalShares $numberOfRecoveryShares`
recoverySalePrice=`floatQuotient $overallExpenditure $temp`
echo "recoverySalePrice:	$recoverySalePrice"

############## SCRIPT ./tagAll
#!/bin/csh -f
#
# *****************************************************************************
# To use this script:
# - cd to the root of a source hierarchy.  For best results, the
#   hierarchy should be in straightforward, buildable condition -
#   temp files and other clutter can confuse things.
# - run this script.
#
# Normal results are a stream of warnings from the ctags program, a fair
# amount of disk activity and then a tags-file, sometimes quite large.
# Existing tags files are preserved automatically.  Improvements welcomed.
#
# *****************************************************************************
# set verbose						# Mostly for debugging

set allTags=/tmp/allTags$$
set ctagsOutput=/tmp/ctagsOut$$
set progBinary=/tmp/sTag$$
set progSource=/tmp/sTag$$.c
set scriptFile=/tmp/script$$

onintr cleanUp

#
# Preserve an existing tags-file if found in the current directory.
#
if ( -f tags ) then
    set count=0
    set save="SAVEDtags0"
    while ( -f $save )
        @ count ++
        set save="SAVEDtags"$count
    end
    echo "Preserving existing tags file as $save..."
    mv tags $save || exit 1
endif

#
# Build a shell script to be executed (with some exceptions) on every .c
# and .h file from here on down the current hierarchy.  Then concatenate each
# of the tags-files so generated onto what will become one huge tags-file.
#
touch $ctagsOutput
echo "ctags -f $ctagsOutput "'$1'            >$scriptFile
echo "cat $ctagsOutput >>$allTags"          >>$scriptFile

chmod +x $scriptFile
find . -name "*.[ch]" -print | fgrep -v SCCS | xargs -l1 $scriptFile

##
## Generate C source code for a trivial program which will
## generate a tags-file line for each assembler label we hand
## it.  Then generate the binary.  (I'm sure there's a way to
## do this with {grep,sed,awk,whatever}, but I haven't gotten
## around to it...)  Assembler tags not starting in the first
## column don't get handled quite right.
##
#echo 'main( argc, argv )'				 >$progSource
#echo 'int argc;'					>>$progSource
#echo 'char **argv;'					>>$progSource
#echo '{'						>>$progSource
#echo '    char buffer[ 1000 ];'			>>$progSource
#echo '    if( argc < 2 )  {'				>>$progSource
#echo '        printf( "Need a filename argument.\\n" );>>$progSource
#echo '        exit( 1 );'				>>$progSource
#echo '    }'						>>$progSource
#echo '    while( gets( buffer )  )  {'			>>$progSource
#echo '        printf( "%s\t%s\t/^%s:/\\n", buffer, argv[ 1 ], buffer );' \
#							>>$progSource
#echo '    }'						>>$progSource
#echo '    exit( 0 );'					>>$progSource
#echo '}'						>>$progSource
#( cd `dirname $progSource` ; make $progBinary )
#
##
## For each .s file in this directory tree, crunch it such that
## we extract its labels and construct a tags-file line for each.
## The output of each pass is concatenated onto the tags-file
## generated above for the .c/.h files.  (Only works if the number
## of .s files is small enough to fit into the "foreach" parameter
## list - have to take the approach used above if this fails.)
##
#foreach file ( `find . -name "*.s" -print | fgrep -v SCCS` )
#    grep '^[	 ]*[_a-zA-z][_0-9a-zA-z]*:' $file        | \
#    sed  -e 's/:.*$//'    -e '/^[	 ][	 ]*$/d'  | \
#    $progBinary $file       >>$allTags
#end

#
# Now sort the tags file, placing the results into the final tags-file.
#
sort -u <$allTags >/tmp/tags$$

echo "#####################################"
echo "### Resulting ctags file is /tmp/tags$$"
echo "#####################################"

#
# One way or another, we're done.
#
cleanUp:
rm -f          \
    $allTags    \
    $ctagsOutput \
    $progBinary \
    $progSource \
    $scriptFile \

############## SCRIPT ./talkToTheHand
cat <<EOF
We, the multitudes here gathered, beseech you:

 Instead of force-feeding your learned dissertations to us
 firehose-fashion (ie. spewing their full texts into each
 of our emailboxes) could y'all instead maybe just broadcast
 one-line summaries here and then invite interested parties to
 rendezvous for further discussion elsewhere via some URL, or
 email list, or newsgroup, or conference call, etc, etc, etc...

 That way, you make it possible for those of us who actually
 WANT to bathe in the compelling logic of your Only-Possible-
 Correct-Interpretation-Of-Reality to do so.  Meanwhile, the
 rest of us can safely be regarded as benighted individuals who
 are congentially incapable of perceiving your brilliance;
 we are therefore unworthy of your attentions and can simply be left to
 live out our bleak little lives unmolested.  Can you doubt
 that the resulting stampede rush to your rendezvous point
 will accurately reflect the high regard we all have for your
 uniquely valuable insights?

 And if you find yourself offended or threatened by the prospect
 of NOT inflicting your unsolicited wisdom on us in this forum,
 we invite you to reexamine your motives and perhaps to come
 to a deeper understanding of why you feel the need to engage
 in such behavior in front of a (semi-)captive audience.

So, consider yourselves beseeched, as in: please, Please, PLEASE!

EOF

############## SCRIPT ./tcldb
echo puts '"######## Checkpoint '`timeDateString`'"'

############## SCRIPT ./tclDebug
echo puts \"Checkpoint `tds`\"

############## SCRIPT ./tds
echo `ymd``hms`

############## SCRIPT ./tdsTouch
tds=$1
if echo $tds | grep -x '[0-9]\{14\}' >/dev/null
then
#   tds=`echo $tds | sed 's/\(..$\)/.\1/'`
    tds=`echo $tds | sed 's/^\(....\)\(..\)\(..\)\(..\)\(..\)\(..\)$/\1\2\3\4\5.\6/'`
#   tds=`echo $tds | sed 's/^\(....\)\(..\)\(..\)\(..\)\(..\)\(..\)$/\2\3\4\5\1.\6/'`
else
    echo ERROR: arg1 must be yyyymmddhhmmss
    exit 1
fi

touch -t $tds $2

############## SCRIPT ./timeDateString
echo `ymd``hms`

############## SCRIPT ./timeStamp
echo `ymd``hms`

############## SCRIPT ./timeString
date '+%H%M%S'

############## SCRIPT ./timeStringLarge
banner `timeString`

############## SCRIPT ./titleXterm
#!/bin/bash
 echo -n "]1;$1"
#echo -n "]2;$@"

############## SCRIPT ./tkFortune
wish -name `basename $0` <<EOF
button .fortune \
    -background black -activebackground black \
    -foreground white -activeforeground white \
    -command {.fortune configure -text [exec fortune -ea] } \
    -font -bitstream-terminal-medium-r-normal--18-140-100-100-c-110-iso8859-1 \
    -justify left
pack .fortune
bind .fortune <3> exit
.fortune invoke
EOF

############## SCRIPT ./tkNewMail
#!/bin/sh
# \
exec sudo wish4.1 $0 ${@+"$@"}

#exec sudo wish $0 ${@+"$@"}

#
# $Id: tkNewMail.MASTER,v 4.22 1996/04/24 13:10:38 loverso Exp loverso $
#
# Author: John Robert LoVerso <john@loverso.southborough.ma.us>
#
#       Copyright 1994, John Robert LoVerso
#
#       Permission to use, copy, modify, and distribute this software and its
#       documentation for any purpose and without fee is hereby granted,
#       provided that the above copyright notice appear in all copies.
#       The author makes no representations about the suitability of this
#       software for any purpose. It is provided "as is" without express

#
# xbiff/xlbiff/xclock as one application.
# John R LoVerso, 7/23/93, 10/93, 11/93, and so on, and so on ...
#
# Originally based upon "qbiff" by Jimmy Aitken <jimmy@pyra.co.uk>.
# xbiff and xclock, together in Tcl/Tk, written during the break at LISA VI
# (10/21/92) and placed into the public domain. <jimmy@pyra.co.uk>
#
#
# This requires TclX for direct RPOP; otherwise, vanilla Tk4.0 is OK.
#

puts "Checkpoint 960718170459"
if [string match tkNewMail [file tail [pwd]]] {
	# fallback for testing

puts "Checkpoint 960718170439"
	set appDir .
	set auto_path [concat . lib $auto_path]
} else {
	# Default application path
puts "Checkpoint 960718170440"
	if [catch {set appDir $env(tkNewMailPATH)}] {
		set appDir /afs/ri/user/loverso/local/lib/tcl/tkNewMail
	}
	if ![catch {glob $appDir} path] {
		set auto_path [concat $path $auto_path]
	}
}

puts "Checkpoint 960718170443"
set Debug 0

# Invoke app and arg parsing
Initialize tkNewMail

puts "Checkpoint 960718170444"
# Initialize mail drop handler types
InitAllMailDrops

if $dropList { ListDrops; exit }
if $dropTest { TestDrops; exit }

if {[SetDrop $dropType $dropArgs drop] == {}} {
	exit
}

#
# Set mail icon style
#

if {[info exists iconStyle] && [string compare $iconStyle ""]} {
	setIconStyle $iconStyle
} else {
	catch {unset iconStyle}
}

#
# Main tkNewMail program
#
puts "Checkpoint 960718170445"
. config -relief raised -border 2
catch {
	if ![string match +0+0 $position] {
		wm geom . $position
		wm minsize . 1 1
	}
}
puts "Checkpoint 960718170447"
frame .msg
pack .msg -side bottom
puts "Checkpoint 960718170448"
set W(count) [label .msg.text]
set W(bitmap) [label .msg.bitmap -padx 0 -text {} -borderw 0]
pack $W(count) -side right
pack $W(bitmap) -side left
puts "Checkpoint 960718170449"
if {$clockType != "none"} {
	if ![catch {$clockType:init $clockTicks} clockWidget] {
		if {$clockWidget != ""} {
			pack $clockWidget
		}
	} else {
		puts stderr "tkNewMail: clock init error: $clockWidget"
	}
}
puts "Checkpoint 960718170450"
bind . <Any-Enter> {enterApp %W}
bind . <Any-Leave> {leaveApp %W %d}
bind all <Control-Key-q> {destroy .}
bind all <Key-d> {incr Debug}
bind all <Key-D> {set Debug 0}
puts "Checkpoint 960718170451"
proc makeScanWindow {w} {
	if [winfo exists $w] {
		bind $w <Any-Destroy> {}
		destroy $w
	}
puts "Checkpoint 960718170452"
	toplevel $w -class ScanWindow
	wm iconify $w
	bind $w <Any-Enter> [bind . <Any-Enter>]
	bind $w <Any-Leave> [bind . <Any-Leave>]
	bind $w <Any-Map> {mapPopup %W}
	bind $w <Any-Unmap> {unmapPopup %W}
	bind $w <Any-Destroy> {after 1 makeScanWindow %W}
puts "Checkpoint 960718170453"
	global iconPosition
	eval wm iconposition $w $iconPosition

	updateMailCounts
	return $w
}
puts "Checkpoint 960718170454"
set W(icon) [makeScanWindow .icon]

set popup(time) [expr $scanSecs * 1000]
puts "Checkpoint 960718170455"
# start check for mail every 30 seconds
MailLoop [expr $checkSecs * 1000]
puts "Checkpoint 960718170457"
# EOF - enter Tk event loop

############## SCRIPT ./tkResetProduct
#!/usr/local/bin/wish -f
button	.productResetButton		\
	-text "Power-cycle DOT Product"	\
	-command { exec /afs/ri/project/norma-nd/farm/bin/mule -f -reset product >/dev/tty }
pack	.productResetButton

############## SCRIPT ./tolower
tr '[A-Z]' '[a-z]'

############## SCRIPT ./tossDuplicate
read previous
if [ "$previous" = "" ]
then
	exit 0
fi

while :
do
	read current
	if [ "$current" = "" ]
	then
	        break
	fi

echo "######" COMPARE $previous $current
	if cmp $previous $current >/dev/null 2>&1
	then
echo "######" TOSSING $previous
#		echo Tossing $previous
		rm $previous
	fi

	previous=$current
done

############## SCRIPT ./tossDuplicateEmail
export max=$@
echo "################" ENTER $PWD MAX=$max
last=1
current=2

while [ $last -lt $max ]
do
	if diff -b $last $current >/dev/null 2>&1
	then
		echo Tossing $PWD/$last
		rm $last
	fi

	last=$[ $last + 1 ]
	current=$[ $last + 1 ]
done
echo "################" LEAVE $PWD MAX=$max

############## SCRIPT ./stashFunction
###############################################################################
function usage()  {

    echo "Failed:" $@
    cat
    exit 1
}

###############################################################################

read rzq f
test "$rzq" != "function" && usage "Not function declaration"
test -z "$f" && usage "No function name present"
f=`echo $f | sed -e 's/[)(]*//g'`
rzq=`tds`
mkdir -p FUNCTION/$f
echo "function $f" >FUNCTION/$f/$rzq
cat               >>FUNCTION/$f/$rzq

############## SCRIPT ./touchtone
cat <<EOF
+----------------+----------------+---------------+
|                |    A  B  C     |    D  E  F    |
|                |                |               |
|       1        |       2        |       3       |
|                |                |               |
+----------------+----------------+---------------+
|    G  H  I     |    J  K  L     |    M  N  O    |
|                |                |               |
|       4        |       5        |       6       |
|                |                |               |
+----------------+----------------+---------------+
|    P  R  S     |    T  U  V     |    W  X  Y    |
|                |                |               |
|       7        |       8        |       9       |
|                |                |               |
+----------------+----------------+---------------+
|                |                |               |
|       *        |       0        |       #       |
|                |                |               |
+----------------+----------------+---------------+
EOF

############## SCRIPT ./toupper
tr '[a-z]' '[A-Z]'

############## SCRIPT ./uniqueWords
eat | tr " " "\
" | sort -u

############## SCRIPT ./unquote
sed -e 's/^[> 	][> 	]*/ /'

############## SCRIPT ./vxgdbScript
#!/bin/sh
#
# vxgdb: invoke an appropriate version of vxgdb or xvxgdb.
#
# modification history
# --------------------
# 01j,12mar91,c_s  Added "tron" to architecture-invalid error message
# 01i,05mar91,maf  Added support for TRON targets.
# 01h,24oct91,maf  Removed unused usage () function, which was causing
#                     problems on DECstation host.
# 01g,19aug91,maf  Fixed bug with "-l" mode; no longer runs line debugger
#                    in background.
# 01f,29jul91,maf  No longer complains if defaultTargetArch is undefined
#                    but VXGDB_DEBUGGER is defined.
# 01e,27jul91,maf  Test for undefined default target arch no longer uses
#                    expr; reduces debugger startup time.
#                  Minor tweaks.
# 01d,12jul91,c_s  No longer uses debuggerDir; complains if install script
#		     has not provided a default target architecture and
#		     none can be deduced from the shell; made consistent
#		     with xvxgdb's using the path to find its debugger;
#		     changed cat<<EOF to echo in usage statement; added
#		     sparc to list of recognized architectures; unused shell
#		     arguments are passed to debugger; if VXGDB_DEBUGGER
#		     is set, it is used as the debugger to execute.
# 01c,30may91,maf  Now uses default target architecture provided during
#                    installation by install script.
# 01b,28may91,c_s  Brought up to WRS coding standard, put under RCS control,
#                  made so that install script can modify path.
# 01a,23may91,c_s  Initial version.
#
#*/

defaultTargetArch=UNDEFINED

if [ "$1" = "-t" ]
then
    case $2 in
	68*)
	    targetArch=68k
	    shift
            shift
            ;;
	960|i960)
	    targetArch=960
	    shift
            shift
            ;;
	[Ss][Pp][Aa][Rr][Cc])
	    targetArch=sparc
	    shift
	    shift
	    ;;
	[Tt][Rr][Oo][Nn])
	    targetArch=tron
	    shift
	    shift
	    ;;
	*)
	    echo Target architecture must be one of 68k, 960, sparc, tron. >&2
	    exit 2
            ;;
    esac
fi

if [ "$targetArch" = "" ]
then
    if [ "$VX_CPU_FAMILY" != "" ]
    then
	targetArch=$VX_CPU_FAMILY
    else
	if [ "$defaultTargetArch" = "UNDEFINED" ]
	then
	    if [ "$VXGDB_DEBUGGER" = "" ]
	    then
	        echo "No default target architecture is defined for VxGDB."  >&2
		echo "You must use the \"-t\" flag or define VX_CPU_FAMILY." >&2
		exit 1
	    fi
	else
	    targetArch=$defaultTargetArch
	fi
    fi
fi

if [ "$1" = "-l" ]
then
    lineDebugger=1
    shift;
fi

vxgdbPath=vxgdb$targetArch
xvxgdbPath=xvxgdb

if [ $lineDebugger ]
then
    $vxgdbPath $@
else
    if [ "$VXGDB_DEBUGGER" != "" ]
    then
echo "######## Checkpoint" 980601131417
	$xvxgdbPath $@ &
echo "######## Checkpoint" 980601131428
    else
echo "######## Checkpoint" 980601131437
        $xvxgdbPath -xrm "*debugger: $vxgdbPath" $@ &
echo "######## Checkpoint" 980601131439
    fi
fi

wait

############## SCRIPT ./w1rld1
telnet world

############## SCRIPT ./whoPasa
#!/bin/csh -f
who >/tmp/whoNow

while 1
    mv /tmp/whoNow /tmp/whoLast
    who >/tmp/whoNow
    diff /tmp/whoLast /tmp/whoNow | sed -e '/^[0-9]/d' | sort

    echo "########################################################"
    sleep $argv
end

#    -e '/ mod    /d' \
#

############## SCRIPT ./word1
exec awk '{ print $1 }'

############## SCRIPT ./word2
exec awk '{ print $2 }'

############## SCRIPT ./yearMonthDayString
date '+%Y%m%d'

############## SCRIPT ./ymd
date '+%Y%m%d'

############## SCRIPT ./ymdhms
echo `ymd``hms`

############## SCRIPT ./ifn
echo "#define $@ 0"
echo "#if    !$@"
cat
echo "#endif /* #if !$@ */" | rjc

############## SCRIPT ./lisaNote
timeStamp=`timeDateString`
echo "####################" Recording comments for Note $timeStamp...
echo "####################" $timeStamp >>~/.lisaNotes
cat >>~/.lisaNotes
echo "" >>~/.lisaNotes
echo "####################" Completed comments for Note $timeStamp

############## SCRIPT ./calibrate
#
# A system-speed-dependent delay function
#

timeStamp=`date '+%Y%m%d%H%M%S'`
 tempFile=/tmp/tempFile$timeStamp$$

function countDownFrom() {
    timeLeft=$@
    while [ $timeLeft -gt 0 ]
    do
        timeLeft=$[$timeLeft - 1]
    done
}

function sayAfterDelay()  {
    countDownFrom $1
    echo -ne "$2"
}

function countUntilSig14() {
    count=0
    trap 'echo $count >$tempFile ; break ' 14
    while :
    do
        count=$[$count + 1]
    done
}

function rangeFor10seconds()  {
    >$tempFile
    countUntilSig14 &
    sleep 10
    kill -14 $!
    wait
    cat $tempFile
}

echo tempFile $tempFile
echo Starting rangeFor10seconds

rangeFor10seconds

exit 0

count=$1

read stop  junk </proc/uptime
read start junk </proc/uptime

countDownFrom $count

read stop  junk </proc/uptime

echo start is $start
echo stop  is $stop

echo "( $stop - $start ) / $count" | math

############## SCRIPT ./genCscopeFileListMRCY
#
# This script expects to be invoked in the root of a Mercury
# MC/OS source tree.  This would typically be /vobs/mcos with
# a given ClearCase view selected, but it should also work if
# you're one of those who copy the contents of a given view out
# onto your local disk somewhere.  Further, if $MC_BUILD_OUTPUT
# is defined in your environment, this script will also look in
# that subtree for files of interest.
#
# This script generates a file-list named cscope.files which is
# what Cscope expects to use while building its database.  That
# file-list can also be fed to glimpseindex and [ce]tags to good
# effect.  This script was created when it became apparent that
# simply saying something like:
#
#    find . -type f -name '*.[ch]'
#
# yielded a file-list with many redundant entries and which caused
# the corresponding cscope/[ce]tags databases to be gigantic.  The
# existence of this script should not be seen as implying that the
# author has any penetrating insight into the alleged organization
# of our build environment; it's more the case that every time I've
# seen a file in my file-list that I don't like I've just added
# another RE herein to make it go away...
#
# Approximate reduction in cscope database size: 80Mb -> 8Mb
#
# NOTES:
# - This is definitely a work-in-progress; suggestions for
#   improvement are welcome.  This was developed primarily
#   in a view of SAT_MRG vintage; YMMV with others.
#
# - It unfortunately appears to be normal for this script to
#   spew warnings about stale symlinks in our build environment
#   which no longer point anywhere useful...
#
# - Probably needs modification such that we gather the
#   .[chs] files from the {cpu,pf,port}/host/* directories.
#       (now mostly implemented)
#
# - For you minimalists out there:  it should be mentioned that
#   jgillono has a similar script which accomplishes approximately
#   the same thing as this one while being smaller and probably
#   faster; this one discards duplicate files, is somewhat more
#   configurable and handles files from $MC_BUILD_OUTPUT.
#
# - For 4.x please consider this note from mrz:
#
# >Date: Fri, 02 Oct 1998 13:27:18 -0400
# >From: Michael Zucca <mrz@mc.com>
# >Subject: cscope script under 4.x
# >
# >I've run your script under 4.x and it seems to work fine.
# >However, you need to use the following CSCOPE_PACKAGE_LIST
# >
# >cpu exec ics obj mc_utils os os_specs pf port stdc mercury
# >
# >This assumes you've already done a build and make mercury.
#
# mod   980605
# mod 19990615 <<--  Now Y2K compliant!

####
# The timeStamp is handy for generating any
# unique-per-script-invocation temp files and such...
#
timeStamp=`date '+%Y%m%d%H%M%S'`
  md5List=md5List$timeStamp
 tempFile=tempFile$timeStamp
parentDir=`dirname $PWD`

cat /dev/null >$tempFile

####
# Make sure we have an md5sum executable...
#
md5sumPath=`type md5sum | tail -1`

if [ -z "$md5sumPath" ]
then
    echo "#### Required executable (md5sum) not in PATH."
    # bach:/opt/local/bin/md5sum was usable as of 981109
    exit 1
fi

####
# Preserve existing instances of cscope.files, if any...
#
if [ -f cscope.files ]
then
    mv                   cscope.files              cscope.files$timeStamp
    echo "####" Existing cscope.files preserved as cscope.files$timeStamp
fi

####
# On many of our Sun boxes only the /usr/xpg4/bin
# version of grep understands the -e switch
#
if [ -x /usr/xpg4/bin/grep ]
then
    GREP=/usr/xpg4/bin/grep
else
    GREP=grep          # We'll just have to hope this grep does what we need...
fi

####
# Use mod's whitespace-collapser if we can...
#
if [ -x ~mod/local/bin/eat ]
then
    COLLAPSE_WHITESPACE=~mod/local/bin/eat
else
    COLLAPSE_WHITESPACE="sed -e 's/[	 ][	 ]*/ /g' "
fi

####
# We can initialize the PACKAGE_LIST from a number of different
# sources which are considered in precedence order:
#
#  - An environment variable named CSCOPE_PACKAGE_LIST
#  - A file named  CSCOPE_PACKAGE_LIST in the current             directory
#  - A file named .CSCOPE_PACKAGE_LIST in the current user's home directory
#  - The DEFAULT_PACKAGE_LIST variable defined below
#
# Note that overrides defined from the contents of a file can
# have lines in them which are "commented out" (excluded in
# their entirety) if a '#' appears at ANY POINT in that line...
#
#DEFAULT_PACKAGE_LIST="cpu dbg ebi ebi_specs exec obj \
#                      ics mc_utils os os_specs pf tatl tatl_leaf \
#                      port stdc stdc_leaf " #drivers driver_bin"
#
 DEFAULT_PACKAGE_LIST="	cpu       dbg    driver_bin drivers   ebi	\
			ebi_specs exec   flash      hw_specs  ic_specs	\
			ics       kdsmc  mc_utils   obj       os	\
			os_specs  pf     port       stdc      stdc_leaf"
#			dmc       prommc tatl       tatl_leaf new_tests

if [ -z "$CSCOPE_PACKAGE_LIST" ]
then
    if [ -f CSCOPE_PACKAGE_LIST ]
    then
        echo "PACKAGE_LIST taken from file CSCOPE_PACKAGE_LIST"
        PACKAGE_LIST=`fgrep -v "#" CSCOPE_PACKAGE_LIST`
    else
        if [ -f ~/.CSCOPE_PACKAGE_LIST ]
        then
            echo "PACKAGE_LIST taken from file ~/.CSCOPE_PACKAGE_LIST"
            PACKAGE_LIST=`fgrep -v "#" ~/.CSCOPE_PACKAGE_LIST`
        else
            echo "Using DEFAULT_PACKAGE_LIST"
            PACKAGE_LIST="$DEFAULT_PACKAGE_LIST"
        fi
    fi
else
    echo "PACKAGE_LIST taken from env \$CSCOPE_PACKAGE_LIST"
    PACKAGE_LIST="$CSCOPE_PACKAGE_LIST"
fi

####
# Describe what we settled on...
#
echo "#### PACKAGES..."
echo $PACKAGE_LIST

if [ $MC_BUILD_OUTPUT ]
then
    echo "####" \$MC_BUILD_OUTPUT defined in environment:
    echo $MC_BUILD_OUTPUT
else
    echo "####" \$MC_BUILD_OUTPUT is UNDEFINED in environment...
    if [ -e out ]
    then
        echo "####" ...will try $PWD/out
        MC_BUILD_OUTPUT=$PWD/out
    fi
fi

####
# We first generate a file which is a list of all leaf-node
# directories of possible interest in the various Packages.
# We say -follow to prevent our search from ending prematurely
# as it encounters directories that are actually symLinks...
#
# Examples of candidate starting points:
#
# ad21000 ada adm_work binutils bison build c cpu cpu_specs
# cr dbg diag dmc dpk driver_bin drivers ebi ebi_specs eng_mgt
# esp exec flexlm gcc gdb gdbmc gmake gnu gnu_flex gnu_libstdc
# hoo hoo2 hoo3 hoo5 hoo7 hw_specs ic_specs ics kdsmc lang links
# madd matlab mc_utils mcos mcos2 mcos3 msp msptools native_tools
# new_tests obj old_msptest os os_specs peakware peg perennial
# pf plumhall port rel_os_specs rel_port rel_stdc releng rtests
# sal sqa ssg stage staging stars stdc stdc.old stdc_leaf sv
# svmc sysadmin target_headers target_headers_2 target_headers_3
# target_headers_4 target_headers_5 target_libs target_scripts
# target_scripts.old target_tools tcl test texinfo tools utils
#
# Start gathering directories of interest...
#
for package in $PACKAGE_LIST $MC_BUILD_OUTPUT
do
    for dir in $PWD $parentDir $parentDir/mcos2 $parentDir/mcos3
    do
        if [ -e $dir/$package ]
        then
            package=$dir/$package
            break
        fi
    done

    echo -n "####" finding directories in $package...
    find $package -follow -type d \
       \( -name src -o -name include -o -name generated \) -print >>$tempFile
    echo DONE
done

####
# Now consider additional specific directories (and only directories -
# no symLinks) from within the cpu/ and pf/ Packages...
#
# THIS PART NEEDS WORK # XXX
#
#for dir in cpu/host/adi21060/adi21060  \
#           cpu/host/adi21060/adi21k_le \
#           cpu/host/i860/i860          \
#           cpu/host/lib/adi21060       \
#           cpu/host/lib/adi21k_le      \
#           cpu/host/lib/i860           \
#           cpu/host/lib/ix86           \
#           cpu/host/lib/ix86_db        \
#           cpu/host/lib/mc68020        \
#           cpu/host/lib/mips           \
#           cpu/host/lib/ppc            \
#           cpu/host/lib/ppc_elf        \
#           cpu/host/lib/sparc          \
#           cpu/host/lib/sparc_elf      \
#           cpu/host/ppc/ppc            \
#           pf/host/ce860/i860          \
#           pf/host/lib/adi21060        \
#           pf/host/lib/adi21k_le       \
#           pf/host/lib/i860            \
#           pf/host/lib/ppc             \
#           pf/host/ppc/ppc             \
#           pf/host/race_860/i860       \
#           pf/host/sharc/adi21060      \
#           pf/host/sharc/adi21k_le     \
#           pf/host/vmbs_860/i860
#do
#    if [ -e $dir ]
#    then
#        dir=$PWD/$dir
#    else
#        if [ -e $parentDir/$dir ]
#        then
#            dir=$parentDir/$dir
#        fi
#    fi
#
#    if [ -e $dir ]
#    then
#        echo -n "####" finding directories in $dir...
#        find $dir -follow -type d -print >>$tempFile
#    else
#        echo "####" Ignoring $dir
#    fi
#done

####
# Before we start gathering files we toss a few directories...
#
$GREP -v -e '/curses/'         \
         -e '/imports/'        \
         -e '/mercury/'        \
         -e '\.old'            \
         -e '/target_headers/' \
         -e '/example'         \
         -e '/target_tools/'   \
         -e '\.tmpl$'          < $tempFile >cscope.files

mv cscope.files $tempFile

####
# Gather files...
#
for dir in `cat $tempFile`
do
    if [ -L $dir ]
    then
        echo "####" SKIPPING $dir "(symLink)"
    else
        if [ -d $dir ]
        then
            echo -n "####" finding files in $dir...
            find $dir -type f -print >>cscope.files

            ####
            # We reluctantly conclude that certain rules files
            # with names like [Mm]akefil*, and which live in
            # otherwise uninteresting directories, should be
            # considered for our list, so we feel around for
            # them while we're in the neighborhood...
            #
            # XXX This is broken since *akefil* can
            #     evaluate to more than one file, or to NULL
            #
            if [ -e $dir/../*akefil* ]
            then
                pushd $dir/.. >/dev/null
                for f in *akefil*
                do
                    if fgrep -s '#define' $f
                    then
                        echo $PWD/$f >>cscope.files
                    fi
                done
                popd >/dev/null
            fi
            echo DONE
        else
            echo "####" Script ERROR - $dir NOT directory
            exit 1
        fi
    fi
done

oldLineCount=`wc -l cscope.files`

#cp                           cscope.files          cscope.filesRAW_DEBUG$timeStamp
#echo "###DEBUG - raw copy of cscope.files saved as cscope.filesRAW_DEBUG$timeStamp"

####
# Now toss files with names we don't want...
#
$GREP -v -e '[0-9]$'                \
         -e '860'                   \
         -e '\.ann$'                \
         -e '\.[ao]$'               \
         -e '\.aps$'                \
         -e 'ar_names$'             \
         -e '\.bat$'                \
         -e '/c80/'                 \
         -e 'cfg$'                  \
         -e '\.clw*'                \
         -e '\.contrib*'            \
         -e '\.cpp_inc$'            \
         -e '\.dep*'                \
         -e 'desc$'                 \
         -e '\.dsp*'                \
         -e '\.dsw*'                \
         -e '\.duplicate$'          \
         -e 'enerated/headers\.mk$' \
         -e 'src/exampl'            \
         -e 'EXPORTS$'              \
         -e '\.gperf$'              \
         -e 'ibrary$'               \
         -e 'INCLUDES$'             \
         -e '\.ico$'                \
         -e '\.ini$'                \
         -e 'ISSUES$'               \
         -e '\.java*'               \
         -e '\.keep*'               \
         -e '-k\.s$'                \
         -e '\.lib$'                \
         -e '\.mak*'                \
         -e '\.mcl$'                \
         -e '\.mdp$'                \
         -e '\.ncb$'                \
         -e 'Notes$'                \
         -e '\.opt*'                \
         -e '\.pch$'                \
         -e '\.pdb$'                \
         -e '/\.pkg_facilities\.h$' \
         -e '\.facilities\.mk$'     \
         -e '\.plg*'                \
         -e '/psosx/'               \
         -e 'rb/src/rb_test.c$'     \
         -e '\.rc*'                 \
         -e 'README$'               \
         -e '\.tmpl$'               \
         -e '\.txt$'                \
         -e '\.vep$'    < cscope.files | sort -u >$tempFile

#        -e 'akefile$'              \
#        -e '\.mk$'                 \
#        -e '\.c_[chs]$'            \
#

mv $tempFile cscope.files

####
# Force inclusion of specific files that live off the beaten path...
#
for f in $PWD/os/scripts/host_api.c
do
    echo $f >>cscope.files
done

#cp                           cscope.files          cscope.filesSED_DEBUG$timeStamp
#echo "###DEBUG - raw copy of cscope.files saved as cscope.filesSED_DEBUG$timeStamp"

####
# Use md5 to compute a signature value for each file; we
# then look for duplicates in a sorted list of those
# signatures.  Since each signature can be relied upon to be
# unique for each unique file, duplicate signatures indicate
# duplicate files which may be removed from our list.
#
echo "#### Begin DUPLICATE-ELIMINATION -"
echo "#### Calculating md5 tag for each file..."
xargs -l10 md5sum <cscope.files | sort >$md5List

####
# From the $md5List, clip out a list of md5 tags which are
# associated with duplicate files, one tag per group of
# two-or-more duplicate files... (Using cscope.files as
# a temporary file here)
#
$COLLAPSE_WHITESPACE <$md5List | cut -f 1 -d ' ' | uniq -d >cscope.files

####
# Move filenames mentioning the $MC_BUILD_OUTPUT area to the end of
# $md5List on the assumption that this will select the "mother" file in
# preference to generated files when choosing from a set of duplicates.
#
if [ ! -z "$MC_BUILD_OUTPUT" ]
then
    echo "####" Arranging prejudice against duplicates from MC_BUILD_OUTPUT...
    fgrep -v $MC_BUILD_OUTPUT $md5List  >rzqTemp$$
    fgrep    $MC_BUILD_OUTPUT $md5List >>rzqTemp$$
    mv              rzqTemp$$ $md5List
fi

echo "####" Selecting one representative from each set of duplicates...
cat cscope.files | while read id
do
    echo "####" Selecting first entry from these duplicates:
    fgrep $id $md5List
    fgrep $id $md5List | head -1 >>$tempFile
done

####
# Since $md5List is really just cscope.files with an md5 tag on
# each line we now delete from $md5List ALL lines having a tag
# that corresponds to a duplicated file.  We then add our list
# of representatives back in and sort the whole mess, overwriting
# cscope.files with the no-duplicates version...
#
echo "####" Discarding names of ALL duplicate files...
fgrep -f cscope.files -v <$md5List >>$tempFile

echo "####" Allowing representatives back into the list...
$COLLAPSE_WHITESPACE < $tempFile | cut -f 2 -d ' ' | sort >cscope.files

####
# With the (probably vain) hope that we can influence
# cscope and friends to select the "mother" files in
# preference to files from the MC_BUILD_OUTPUT area,
# we once again sweep them to the end of the list...
#
if [ ! -z "$MC_BUILD_OUTPUT" ]
then
    echo "####" Moving MC_BUILD_OUTPUT files to end of list...
    fgrep -v $MC_BUILD_OUTPUT cscope.files  >$tempFile
    fgrep    $MC_BUILD_OUTPUT cscope.files >>$tempFile
    mv       $tempFile        cscope.files
fi

echo "####" Done...
ls -l cscope.files

newLineCount=`wc -l cscope.files`
echo "####" oldLineCount=$oldLineCount newLineCount=$newLineCount

rm -f $tempFile $md5List

exit 0

############## SCRIPT ./semolinaIPaddr
 expect <<EOF
#
# Send 1 char at a time, 100 millis apart
#
 set send_slow {1 0.1}
#spawn /usr/bin/mh/inc -host world.std.com -norpop
 spawn ssh mod@semolina "/sbin/ifconfig eth0"
#expect "Password (world.std.com:mod): "
#expect "Password (pop.ne.mediaone.net:mod):"
 expect "mod@semolina's password:"
#
# Sleep to allow the terminal settings to
# be changed to avoid echoing the password...
#
 sleep 2
#send -s w1rld1\r
 send -s cdb1999\r
 set timeout -1
 expect eof
EOF

############## SCRIPT ./launchDetached
cd /tmp
( $@ ) >>/tmp/detachedLog$$ 2>&1 &

############## SCRIPT ./currentIPaddr
line=(`/sbin/ifconfig eth0 | fgrep 'inet addr'`)
echo ${line[1]} | sed -e 's/^.*://'

############## SCRIPT ./sweepDeleted
 timeStamp=`date '+%Y%m%d%H%M%S'`
  tempFile=tempFile$timeStamp

 cat /dev/null >$tempFile

 for f in ,*
 do
     echo "" >> $tempFile
     cat $f          >> $tempFile
     echo "" >> $tempFile
     rm $f
 done

 folder -push +deleted
 inc +deleted -file     $tempFile
 folder -pop
 rm                     $tempFile

############## SCRIPT ./cs
cscope -dU -l -L -1 $@ | sed -e 's/ /RZQ1/' -e 's/ /RZQ1/' -e 's/ /RZQ1/' -e's/ /RZQ2/g' -e 's/RZQ1/ /g' | lineup | sed -e 's/RZQ2/ /g'

############## SCRIPT ./gl
glimpse -H . $@

############## SCRIPT ./sourceToolInitOLD
#!/usr/bin/bash
#!/u/bin/bash
#!/opt/local/bin/bash
#!/n/viewserver/home/merlin/home2/bin/sun4/sos4/bash

timeStamp=`date '+%Y%m%d%H%M%S'`
 tempFile=tempFile$timeStamp

genCscopeFileList
sed -e 's;/n/bach/;/;' <cscope.files >$tempFile ; mv $tempFile cscope.files
glimpseindex -F -H /vobs/mcos -E -B -n -o <cscope.files >.glimpseLog 2>&1 &

rm -f TAGS
etags - <cscope.files &

genCtagsForAKM &

############## SCRIPT ./sweepGNHLUG
 pushd ~/.mail/deleted
 timeStamp=`date '+%Y%m%d%H%M%S'`
  tempFile=tempFile$timeStamp

 cat /dev/null >$tempFile

 for f in ? ?? ??? ????
 do
#    if fgrep -iq  gnhlug@zk3         $f
     if fgrep -iq  gnhlug             $f
#    if grep  -iq 'gnhlug.*@.*gnhlug' $f
     then
         echo "" >> $tempFile
         cat $f          >> $tempFile
         echo "" >> $tempFile
         rm $f
     fi
 done

 folder -push +ARCHIVE/GNHLUG
 inc +ARCHIVE/GNHLUG  -file     $tempFile
 folder -pop
 rm                             $tempFile
 popd

############## SCRIPT ./lineup1
eat | sed -e 's/[	 ][	 ]*$//' -e 's/ /RZQ/g' -e 's/RZQ/ /' | lineup | sed -e 's/RZQ/ /g'
#MCLX version of 20020428
#sed -e 's/^[	 ][	 ]*//' -e 's/[	 ][	 ]*$//' -e 's/[	 ][	 ]*/RZQ/g' -e 's/RZQ/ /' | lineup | sed -e 's/RZQ/ /g'

############## SCRIPT ./prettyMCLX20011017
#indent -bap -br -bs -ce -d1 -nei -eei -nfc1 -i4 -lp -npcs -psl -st
#indent -bap -br -bs -ce -d1      -eei -nfc1 -i4 -lp -npcs -psl -st

indent  --blank-lines-after-declarations                   \
        --blank-lines-after-procedures                     \
        --braces-on-if-line                                \
        --brace-indent2                                    \
        --braces-on-struct-decl-line                       \
        --break-before-boolean-operator                    \
        --case-indentation0                                \
        --cuddle-else                                      \
        --case-brace-indentation0                          \
        --dont-format-comments                             \
        --dont-line-up-parentheses                         \
        --dont-space-special-semicolon                     \
        --k-and-r-style                                    \
        --original                                         \
        --no-comment-delimiters-on-blank-lines             \
        --no-parameter-indentation                         \
        --no-space-after-casts                             \
        --no-space-after-function-call-names               \
        --procnames-start-lines                            \
        --standard-output                                  \
        --space-after-parentheses                          \
 | detab                                                   \
 | sed -e 's/ if *(/ if(/g'                                \
       -e 's/ while *(/ while(/g'                          \
       -e 's/ for *(/ for(/g'                              \
       -e 's/ switch *(/ switch(/g'                        \
       -e 's/ return *(/ return(/g'                        \
       -e 's/[	 ]*$//'                                    \
       -e '/[^	 ][	 ]{$/s/{$/ {/'                     \
       -e 's/([	 ]*)$/()/'                                 \
       -e 's/([	 ]*);$/();/'                               \
       -e 's/( *\(char *\**\) *)/(\1)/g'                   \
       -e 's/( *\(float *\**\) *)/(\1)/g'                  \
       -e 's/( *\(int *\**\) *)/(\1)/g'                    \
       -e 's/( *\(long  *int *\**\) *)/(\1)/g'             \
       -e 's/( *\(long *\**\) *)/(\1)/g'                   \
       -e 's/( *\(signed  *char *\**\) *)/(\1)/g'          \
       -e 's/( *\(signed  *int *\**\) *)/(\1)/g'           \
       -e 's/( *\(unsigned  *char *\**\) *)/(\1)/g'        \
       -e 's/( *\(unsigned  *int *\**\) *)/(\1)/g'         \
       -e 's/( *\(unsigned *\**\) *)/(\1)/g'               \
       -e 's/( *\(unsigned  *long  *int *\**\) *)/(\1)/g'  \
       -e 's/( *\(unsigned  *long\) *)/(\1)/g'             \
       -e 's/( *\(unsigned  *long *\*\) *)/(\1)/g'         \
       -e 's/( *\(signed  *long  *int *\**\) *)/(\1)/g'    \
       -e 's/( *\(void *\**\) *)/(\1)/g'                   \
       -e 's/( *void *)/(void)/g'                          \
       -e 's/( *\(short  *int *\**\) *)/(\1)/g'            \
       -e 's/( *\(short *\**\) *)/(\1)/g'                  \
       -e 's/( *\(unsigned  *short  *int *\**\) *)/(\1)/g' \
       -e 's/( *\(unsigned  *short\) *)/(\1)/g'            \
       -e 's/( *\(unsigned  *short *\*\) *)/(\1)/g'        \
       -e 's/( *\(signed  *short  *int *\**\) *)/(\1)/g'   \

exit 0

#       -bad, --blank-lines-after-declarations
#           Force blank lines after the declarations.
#
#       -bap, --blank-lines-after-procedures
#           Force blank lines after procedure bodies.
#
#       -bbb, --blank-lines-after-block-comments
#           Force blank lines after block comments.
#
#       -bbo, --break-before-boolean-operator
#           Prefer to break long lines before boolean operators.
#
#       -bc, --blank-lines-after-commas
#           Force newline after comma in declaration.
#
#       -bl, --braces-after-if-line
#           Put braces on line after if, etc.
#
#       -blin, --brace-indentn
#           Indent braces n spaces.
#
#       -bls, --braces-after-struct-decl-line
#           Put braces on the line after struct declaration lines.
#
#       -br, --braces-on-if-line
#           Put braces on line with if, etc.
#
#       -brs, --braces-on-struct-decl-line
#           Put braces on struct declaration line.
#
#       -bs, --Bill-Shannon, --blank-before-sizeof
#           Put a space between sizeof and its argument.
#
#       -cn, --comment-indentationn
#           Put comments to the right of code in column n.
#
#       -cbin, --case-brace-indentationn
#           Indent braces after a case label N spaces.
#
#       -cdn, --declaration-comment-columnn
#           Put comments to the right of the declarations in column n.
#
#       -cdb, --comment-delimiters-on-blank-lines
#           Put comment delimiters on blank lines.
#
#       -ce, --cuddle-else
#           Cuddle else and preceeding `}´.
#
#       -cin, --continuation-indentationn
#           Continuation indent of n spaces.
#
#       -clin, --case-indentationn
#           Case label indent of n spaces.
#
#       -cpn, --else-endif-columnn
#           Put comments to the right of #else and #endif statements in column n.
#
#       -cs, --space-after-cast
#           Put a space after a cast operator.
#
#       -dn, --line-comments-indentationn
#           Set indentation of comments not to the right of code to n spaces.
#
#       -din, --declaration-indentationn
#           Put variables in column n.
#
#       -fc1, --format-first-column-comments
#           Format comments in the first column.
#
#       -fca, --format-all-comments
#           Do not disable all formatting of comments.
#
#       -gnu, --gnu-style
#           Use GNU coding style.  This is the default.
#
#       -hnl, --honour-newlines
#           Prefer to break long lines at the position of newlines in the input.
#
#       -in, --indent-leveln
#           Set indentation level to n spaces.
#
#       -ipn, --parameter-indentationn
#           Indent parameter types in old-style function definitions by n spaces.
#
#       -kr, --k-and-r-style
#           Use Kernighan & Ritchie coding style.
#
#       -ln, --line-lengthn
#           Set maximum line length for non-comment lines to n.
#
#       -lcn, --comment-line-lengthn
#           Set maximum line length for comment formatting to n.
#
#       -lp, --continue-at-parentheses
#           Line up continued lines at parentheses.
#
#       -lps, --leave-preprocessor-space
#           Leave space between `#´ and preprocessor directive.
#
#       -nbad, --no-blank-lines-after-declarations
#           Do not force blank lines after declarations.
#
#       -nbap, --no-blank-lines-after-procedures
#           Do not force blank lines after procedure bodies.
#
#       -nbbo, --break-after-boolean-operator
#           Do not prefer to break long lines before boolean operators.
#
#       -nbc, --no-blank-lines-after-commas
#           Do not force newlines after commas in declarations.
#
#       -ncdb, --no-comment-delimiters-on-blank-lines
#           Do not put comment delimiters on blank lines.
#
#       -nce, --dont-cuddle-else
#           Do not cuddle } and else.
#
#       -ncs, --no-space-after-casts
#           Do not put a space after cast operators.
#
#       -nfc1, --dont-format-first-column-comments
#           Do not format comments in the first column as normal.
#
#       -nfca, --dont-format-comments
#           Do not format any comments.
#
#       -nhnl, --ignore-newlines
#           Do not prefer to break long lines at the position of newlines in the input.
#
#       -nip, --no-parameter-indentation
#           Zero width indentation for parameters.
#
#       -nlp, --dont-line-up-parentheses
#           Do not line up parentheses.
#
#       -npcs, --no-space-after-function-call-names
#           Do not put space after the function in function calls.
#
#       -nprs, --no-space-after-parentheses
#           Do not put a space after every ´(´ and before every ´)´.
#
#       -npsl, --dont-break-procedure-type
#           Put the type of a procedure on the same line as its name.
#
#       -nsc, --dont-star-comments
#           Do not put the `*´ character at the left of comments.
#
#       -nsob, --leave-optional-blank-lines
#           Do not swallow optional blank lines.
#
#       -nss, --dont-space-special-semicolon
#           Do not force a space before the semicolon after certain statements.  Disables `-ss´.
#
#       -nv, --no-verbosity
#           Disable verbose mode.
#
#       -orig, --original
#           Use the original Berkeley coding style.
#
#       -npro, --ignore-profile
#           Do not read `.indent.pro´ files.
#
#       -pcs, --space-after-procedure-calls
#           Insert a space between the name of the procedure being called and the `(´.
#
#       -pin, --paren-indentationn
#           Specify the extra indentation per open parentheses ´(´ when a statement is broken.See  STATEMENTS.
#
#       -pmt, --preserve-mtime
#           Preserve access and modification times on output files.See  MISCELLANEOUS OPTIONS.
#
#       -prs, --space-after-parentheses
#           Put a space after every ´(´ and before every ´)´.
#
#       -psl, --procnames-start-lines
#           Put the type of a procedure on the line before its name.
#
#       -sbin, --struct-brace-indentationn
#           Indent braces of a struct, union or enum N spaces.
#
#       -sc, --start-left-side-of-comments
#           Put the `*´ character at the left of comments.
#
#       -sob, --swallow-optional-blank-lines
#           Swallow optional blank lines.
#
#       -ss, --space-special-semicolon
#           On one-line for and while statments, force a blank before the semicolon.
#
#       -st, --standard-output
#           Write to standard output.
#
#       -T  Tell indent the name of typenames.
#
#       -tsn, --tab-sizen
#           Set tab size to n spaces.
#
#       -v, --verbose
#           Enable verbose mode.
#
#       -version
#           Output the version number of indent.

############## SCRIPT ./cc-E
#
# A pipe that tidies up the output of a cc -E run a little bit...
#
sed -e 's/[	 ][	 ]*$//' -e 's/^#/RZQ#/' -e '/^RZQ/s/$/ *\//' -e 's/^RZQ/\/* /' | cat -s

############## SCRIPT ./mclxalums
fromHack | sed -e '/^To:/s/^.*$/To: "MCLX alums list" <mclx_alums@spineless.org>/' -e '/^cc:/d'

############## SCRIPT ./diffLinuxConfig
# Compares two Linux kernel config files and generates a summary.
# mod 20030421
#
#TO-DO:
#   allow commandline specification of which comparisons you
#   actually want to see.

function usage()  {
    echo usage: $0 configFile1 configFile2
    exit 1
}

####
# These seem not to work as I expected...
#
allow_null_glob_expansion=setInScriptFile
set +f

####
# The timeStamp is handy for generating any
# unique-per-script-invocation temp files and such...
#
timeStamp=`date '+%Y%m%d%H%M%S'`
  md5List=md5List$timeStamp
  tempDir=/tmp/tempDir$timeStamp
     dir1=$tempDir/dir1
     dir2=$tempDir/dir2

if [ ! $# -eq 2 ]
then
    echo must mention two config files
    usage
fi

if [ ! -f $1 ]
then
    echo $1 not a file
    usage
fi

if [ ! -f $2 ]
then
    echo $2 not a file
    usage
fi

if diff -q $1 $2 >/dev/null
then
    echo "#### FILES ARE IDENTICAL"
    exit 0
fi

if diff -qb $1 $2 >/dev/null
then
    echo "#### FILES ARE IDENTICAL EXCEPT FOR WHITESPACE"
    exit 0
fi

mkdir -p $dir1 $dir2

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Build dir1/token/{EN,DIS}ABLED files for every item in file1

fgrep CONFIG_ $1 | while read rawLine
do
    echo "$rawLine" | grep -e '^[	 ]*#' >/dev/null
    enabled=$?
    if [ $enabled -eq 0 ]
    then                                                             # Disabled
        line=`echo "$rawLine" | sed -e 's/^[	 ]*#[	 ]*//' `
    else                                                              # Enabled
        line=`echo "$rawLine" | sed -e 's/^[	 ]*//' `
    fi
    token=`echo $line  | sed -e 's/[	 =].*$//' `

    mkdir -p $dir1/$token
    if [ $enabled -eq 0 ]
    then                                                             # Disabled
#echo "######## DISABLED1 <$token> <$rawLine>"
        echo "$rawLine" >$dir1/$token/DISABLED
    else                                                              # Enabled
#echo "######## ENABLED1 <$token> <$rawLine>"
        echo "$rawLine" >$dir1/$token/ENABLED
    fi
done

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Build dir2/token/{EN,DIS}ABLED files for every item in file2

fgrep CONFIG_ $2 | while read rawLine
do
    echo "$rawLine" | grep -e '^[	 ]*#' >/dev/null
    enabled=$?
    if [ $enabled -eq 0 ]
    then                                                             # Disabled
        line=`echo "$rawLine" | sed -e 's/^[	 ]*#[	 ]*//' `
    else                                                              # Enabled
        line=`echo "$rawLine" | sed -e 's/^[	 ]*//' `
    fi
    token=`echo $line  | sed -e 's/[	 =].*$//' `

    mkdir -p $dir2/$token
    if [ $enabled -eq 0 ]
    then                                                             # Disabled
#echo "#### DISABLED2 <$token> <$rawLine>"
        echo "$rawLine" >$dir2/$token/DISABLED
    else                                                              # Enabled
#echo "#### ENABLED2 <$token> <$rawLine>"
        echo "$rawLine" >$dir2/$token/ENABLED
    fi
done

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# We now have a basic indication of which tokens are {EN,DIS}ABLED.
# If we've somehow ended up with both kinds of definitions for any token
# we assume the ENABLED state takes precedence and we therefore toss the
# DISABLED.  This should normally not happen but might be possible with
# hand-tweaked config files.

for dir in $dir1 $dir2
do
    cd $dir
    for token in *
    do
        if [ -f $token/ENABLED ]
        then
            if [ -f $token/DISABLED ]
            then
                echo "#### $token both DISABLED and ENABLED ?"
                rm $token/DISABLED
            fi
        fi
    done
done

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Look for tokens that are DISABLED in config1
# but not even mentioned in config2

cd $dir1
for token in *
do
    if [ -f $token/DISABLED ]
    then
        if [ ! -d "$dir2/$token" ]        # Not even mentioned in other config?
        then
            echo   $token >>$tempDir/uniqueDISABLED1
            rm -rf $token
        fi
    fi
done

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Look for tokens that are ENABLED in config1
# but not even mentioned in config2

cd $dir1
for token in *
do
    if [ -f $token/ENABLED ]
    then
        if [ ! -d "$dir2/$token" ]        # Not even mentioned in other config?
        then
            cat $token/ENABLED >>$tempDir/uniqueENABLED1
            rm -rf $token
        fi
    fi
done

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Look for tokens that are DISABLED in config2
# but not even mentioned in config1

cd $dir2
for token in *
do
    if [ -f $token/DISABLED ]
    then
        if [ ! -d "$dir1/$token" ]        # Not even mentioned in other config?
        then
            echo   $token >>$tempDir/uniqueDISABLED2
            rm -rf $token
        fi
    fi
done

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Look for tokens that are ENABLED in config2
# but not even mentioned in config1

cd $dir2
for token in *
do
    if [ -f $token/ENABLED ]
    then
        if [ ! -d "$dir1/$token" ]        # Not even mentioned in other config?
        then
            cat $token/ENABLED >>$tempDir/uniqueENABLED2
            rm -rf $token
        fi
    fi
done

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Look for tokens that are DISABLED in both configs

cd $dir1
for token in *
do
    if [ -f $token/DISABLED ]
    then
        if [ -f $dir2/$token/DISABLED ]
        then
            echo   $token >>$tempDir/commonDISABLED
            rm -rf $token $dir2/$token
        fi
    fi
done

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Look for identically ENABLED tokens in both configs

cd $dir1
for token in *
do
    if [ -f $token/ENABLED ]
    then
        if [ -f $dir2/$token/ENABLED ]
        then
            if diff -qb $token/ENABLED $dir2/$token/ENABLED >/dev/null
            then
                cat $token/ENABLED >>$tempDir/commonENABLED
                rm -rf $token $dir2/$token
            fi
        fi
    fi
done

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Look for differently ENABLED tokens in both configs

cd $dir1
for token in *
do
    if [ -f $token/ENABLED ]
    then
        if [ -f $dir2/$token/ENABLED ]
        then
            x1=`sed -e 's/^.*=/	=/' <      $token/ENABLED`
            x2=`sed -e 's/^.*=/	=/' <$dir2/$token/ENABLED`
            echo "$token$x1 (vs)$x2" >>$tempDir/differentlyENABLED
            rm -rf $token $dir2/$token
        fi
    fi
done

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Look for tokens ENABLED in dir1 but DISABLED in dir2

cd $dir1
for token in *
do
    if [ -f $token/ENABLED ]
    then
        if [ -f $dir2/$token/DISABLED ]
        then
            cat $token/ENABLED >>$tempDir/enabled1disabled2
            rm -rf $token $dir2/$token
        fi
    fi
done

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Look for tokens ENABLED in dir2 but DISABLED in dir1

cd $dir2
for token in *
do
    if [ -f $token/ENABLED ]
    then
        if [ -f $dir1/$token/DISABLED ]
        then
            cat $token/ENABLED >>$tempDir/enabled2disabled1
            rm -rf $token $dir1/$token
        fi
    fi
done

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Generate the summary:

echo "########" Comparison of kernel config files $1 and $2

if [ -f $tempDir/commonDISABLED ]
then
    echo ; echo "####" Common DISABLED options:
    fmt < $tempDir/commonDISABLED
fi

if [ -f $tempDir/uniqueDISABLED1 ]
then
    echo ; echo "#### DISABLED options unique to $1":
    fmt < $tempDir/uniqueDISABLED1
fi

if [ -f $tempDir/uniqueDISABLED2 ]
then
    echo ; echo "#### DISABLED options unique to $2":
    fmt < $tempDir/uniqueDISABLED2
fi

if [ -f $tempDir/commonENABLED ]
then
    echo ; echo "####" Common ENABLED options:
    cat $tempDir/commonENABLED
fi

if [ -f $tempDir/uniqueENABLED1 ]
then
    echo ; echo "#### ENABLED options unique to $1":
    cat $tempDir/uniqueENABLED1
fi

if [ -f $tempDir/uniqueENABLED2 ]
then
    echo ; echo "#### ENABLED options unique to $2":
    cat $tempDir/uniqueENABLED2
fi

if [ -f $tempDir/differentlyENABLED ]
then
    echo ; echo "#### Differently ENABLED options: $1 (vs) $2"
    cat $tempDir/differentlyENABLED
fi

if [ -f $tempDir/enabled1disabled2 ]
then
    echo ; echo "#### Common options ENABLED in $1 but DISABLED in $2":
    cat $tempDir/enabled1disabled2
fi

if [ -f $tempDir/enabled2disabled1 ]
then
    echo ; echo "#### Common options DISABLED in $1 but ENABLED in $2":
    cat $tempDir/enabled2disabled1
fi

rm -rf $tempDir

exit 0

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# ALTERNATE ENDING...

echo "########" Comparison of kernel config files $1 and $2

[ -f $tempDir/commonDISABLED ] && \
   (echo ; echo "####" Common DISABLED options: ; \
    fmt < $tempDir/commonDISABLED )

[ -f $tempDir/uniqueDISABLED1 ] && \
   (echo ; echo "#### DISABLED options unique to $1": ; \
    fmt < $tempDir/uniqueDISABLED1 )

[ -f $tempDir/uniqueDISABLED2 ] && \
   (echo ; echo "#### DISABLED options unique to $2": ; \
    fmt < $tempDir/uniqueDISABLED2 )

[ -f $tempDir/commonENABLED ] && \
   (echo ; echo "####" Common ENABLED options: ; \
    cat $tempDir/commonENABLED )

[ -f $tempDir/uniqueENABLED1 ] && \
   (echo ; echo "#### ENABLED options unique to $1": ; \
    cat $tempDir/uniqueENABLED1 )

[ -f $tempDir/uniqueENABLED2 ] && \
   (echo ; echo "#### ENABLED options unique to $2": ; \
    cat $tempDir/uniqueENABLED2 )

[ -f $tempDir/differentlyENABLED ] && \
   (echo ; echo "#### Differently ENABLED options: $1 (vs) $2" ; \
    cat $tempDir/differentlyENABLED )

[ -f $tempDir/enabled1disabled2 ] && \
   (echo ; echo "#### Common options ENABLED in $1 but DISABLED in $2": ; \
    cat $tempDir/enabled1disabled2 )

[ -f $tempDir/enabled2disabled1 ] && \
   (echo ; echo "#### Common options DISABLED in $1 but ENABLED in $2": ; \
    cat $tempDir/enabled2disabled1 )

rm -rf $tempDir

############## SCRIPT ./extractEmailAddrsORIG
grep -i '[-0-9a-zA-Z_][-0-9a-zA-Z_]*@[-0-9a-zA-Z_][-0-9a-zA-Z_]*\.[-0-9a-zA-Z_][-0-9a-zA-Z_]*' \
 | sed -e 's/[][\#%\^|\$>"<\&`:'"'"';\/*,)(!]/ /g' -e 's/^/ /' \
 | fmt -1 \
 | eat \
 | grep -i '[-0-9a-zA-Z_][-0-9a-zA-Z_]*@[-0-9a-zA-Z_][-0-9a-zA-Z_]*\.[-0-9a-zA-Z_][-0-9a-zA-Z_]*' \
 | sort -fdu

############## SCRIPT ./gatherEmailCurrentFolder

  timeStamp=$$`date '+%Y%m%d%H%M%S'`
tempDirName=gather$timeStamp
 origFolder=`folder -fast`

 cd ~/.mail/$origFolder                    \
 && mkdir ~/.mail/$tempDirName             \
 && refile +$tempDirName `pick -sub "$@" ` \
 && pushd ~/.mail/$tempDirName             \
 && folder -push +$tempDirName             \
 && refile +$origFolder `pick -sub "$@" `  \
 && folder -pop                            \
 && popd                                   \
 && rmdir ../$tempDirName

############## SCRIPT ./genCscopeFileListWORK

####
# The timeStamp is handy for generating any
# unique-per-script-invocation temp files and such...
#
timeStamp=`date '+%Y%m%d%H%M%S'`
  md5List=md5List$timeStamp
 tempFile=tempFile$timeStamp
parentDir=`dirname $PWD`

####
# Preserve existing instances of cscope.files, if any...
#
if [ -f cscope.files ]
then
    mv                   cscope.files              cscope.files$timeStamp
    echo "####" Existing cscope.files preserved as cscope.files$timeStamp
fi

find . -type f -name "*\.[chsS]" | grep -v \
	-e '\.a$'                    \
	-e /acorn/                   \
	-e akefile                   \
	-e /alpha/                   \
	-e appletalk                 \
	-e /arm/                     \
	-e '\.asc$'                  \
	-e /asm-alpha                \
	-e /asm-arm                  \
	-e /asm-m68k/                \
	-e /asm-mips                 \
	-e /asm-ppc                  \
	-e /asm-s390                 \
	-e /asm-sh                   \
	-e /asm-sparc                \
	-e '\.awk$'                  \
	-e '/boot/bbootsect$'        \
	-e '/boot/bsetup$'           \
	-e /boot/compressed/bvmlinux \
	-e '/boot/tools/build$'      \
	-e 'BUGS-parport'            \
	-e bzImage                   \
	-e '[Cc]hange[Ll]og'         \
	-e CHANGES                   \
	-e '/.config$'               \
	-e '/.config.old$'           \
	-e conmakehash               \
	-e '/ContenTable'            \
	-e COPYING                   \
	-e copyright                 \
	-e '/CREDITS$'               \
	-e cscope.file               \
	-e '\.data$'                 \
	-e '/defconfig$'             \
	-e '\.depend$'               \
	-e /Documentation/           \
	-e '\.flags$'                \
	-e 'genCscope'               \
	-e 'gen-devlist$'            \
	-e '\.gz$'                   \
	-e hanges                    \
	-e '/.hdepend$'              \
	-e /hp/                      \
	-e INSTALL                   \
	-e /INTRO                    \
	-e LICENSE                   \
	-e /m68k/                    \
	-e /macintosh                \
	-e MAINTAIN                  \
	-e makeLog                   \
	-e '\.map$'                  \
	-e MARKER                    \
	-e /mips/                    \
	-e /mips64/                  \
	-e 'MODULES$'                \
	-e /nls/                     \
	-e '/notes'                  \
	-e '\.o$'                    \
	-e '\.o\.flags$'             \
	-e 'onfig\.in$'              \
	-e /paride/                  \
	-e '/pci\.ids$'              \
	-e '\.pl$'                   \
	-e /ppc/                     \
	-e /qnx4/                    \
	-e README                    \
	-e '\.reg$'                  \
	-e '\.regions$'              \
	-e RELEASE                   \
	-e REPORT                    \
	-e '/Rules.make$'            \
	-e /s390/                    \
	-e /sbus/                    \
	-e '\.scr$'                  \
	-e /scripts/                 \
	-e '\.sed$'                  \
	-e '\.seq$'                  \
	-e /sgi/                     \
	-e '\.sh$'                   \
	-e /sh/                      \
	-e /sound/                   \
	-e /sparc/                   \
	-e /sparc64/                 \
	-e '/specs'                  \
	-e '\.stamp$'                \
	-e '\.start$'                \
	-e '/System.map$'            \
	-e TODO                      \
	-e '\.txt$'                  \
	-e '\.uni$'                  \
	-e '/.version$'              \
	-e '/vmlinux$' | sort | sed -e 's;^\./;;' >cscope.files

############## SCRIPT ./genHTMLhrefFor
for f in $@
do
	echo '<P> <a href="'$f'">'$f'</a>'
done

while read f
do
	echo '<P> <a href="'$f'">'$f'</a>'
done

############## SCRIPT ./genHTMLimgSrcFor
for f in $@
do
	echo "<P>"
	echo "<H1>$f</H1>"
	echo "<img src=$f>"
	echo ""
done

############## SCRIPT ./ifne
echo "#define $@ 0"
echo "#if    !$@"
cat
echo "#else /* #if !$@ */" | rjc
echo "#endif /* #else #if !$@ */" | rjc

############## SCRIPT ./l2bccmnti
decomment | eat | sed 's/^ //' | bccmnti $@

############## SCRIPT ./l2bccmntl
decomment | eat | sed 's/^ //' | bccmntl

############## SCRIPT ./launchDetachedINPUT
echo SYSTEM:
read response
echo response is $response
sleep 5
echo doing launchDetached $@ $response
sleep 5
launchDetached $@ $response
sleep 5
exit 0

############## SCRIPT ./lineup2
sed -e 's/^[	 ][	 ]*//' -e 's/[	 ][	 ]*$//' -e 's/[	 ][	 ]*/RZQ/g' -e 's/RZQ/ /' -e 's/RZQ/ /' | lineup | sed -e 's/RZQ/ /g'

############## SCRIPT ./lineupLH
#sed -e 's/:/: /' -e 's/[	 ][	 ]*$//' -e 's/[	 ][	 ]*/ /g' -e 's/ /RZQ/g' -e 's/:/ /' | lineup | sed -e 's/ /:/' -e 's/RZQ/ /g'

sed	-e 's/=/ = /' 				\
	-e 's/[	 ][	 ]*$//' 		\
	-e 's/[	 ][	 ]*/ /g' 		\
	-e 's/ = /=RZQ1/'			\
	-e 's/ /RZQ2/g' 			\
	-e 's/=RZQ1/ = /' | lineup | sed 	\
	-e 's/RZQ2/ /g'

############## SCRIPT ./lineuptags
sed -e 's/	/RZQ1/' -e 's/	/RZQ2/' -e 's/[	 ]/RZQ3/g' -e 's/RZQ1/ /' -e 's/RZQ2/ /' | lineup | sed -e 's/RZQ3/ /g'

############## SCRIPT ./linuxppc
cat <<EOF
To: linuxppc-embedded@lists.linuxppc.org
From: mod+linuxppc-embedded@std.com
Subject:

EOF

############## SCRIPT ./phone
wget -O - http://home/index.addr.cgi 2>/dev/null \
    | fmt   -2000                                \
    | grep    $@                                 \
    | sed   -e 's/$/\
/'  | while read data; do echo "$data"           \
    | sed   -e 's/</\
</g'        -e 's/>/>\
/g' | fgrep -v -e '<'                            \
    | sort  -fdu                                 \
    | fmt   -2000                                \
    | sed   -e '/^$/d' ; done

############## SCRIPT ./rotateSymlinksMCLX
#
# Given a subdirectory named by the user on the command
# line and given an "active" TFTP boot-kernel symlink named
# "active" and one or more other (idle) such symlinks with
# names of the form "20011228010242" in that directory,
# this script will take the one that's currently active
# and rename it such that its name is of the idle form.
# Then the idle link that sorts lexicographically first
# will be established as the new active link.
#
# Since the numeric portion of each name is derived
# from the current date and time (and "active" always
# sorts last in such a list) the effect is that we
# rotate through the links.
#

function fail()  {
    echo $@
    exit 1
}

client=$1
test -z "$client" && fail "Must mention client directory"
test -d $client   || fail "$client isn't a directory"
cd $client        || fail "Can't cd to client directory $client"
test -h active    || fail "No active symlink in client directory $client"
sleep 2
mv active `tds`
mv `ls | head -1` active
ls -laF

############## SCRIPT ./separator
cat <<EOF
          ##
          ##
          ##
          ##
          ##
######################
######################
          ##
          ##
          ##
          ##
          ##
EOF

############## SCRIPT ./sourceCookieHere
echo 'printk( "'`tds`'\n" );'
cat

############## SCRIPT ./sweep2linuxList
folder -push +inbox
refile +linuxList `pick --List-id 'Commit messages for the Linux/PPC BK trees'`
refile +linuxList `pick --X-mailing-list 'linuxppc-embedded@lists.linuxppc.org'`
refile +linuxList `pick --X-mailing-list 'linuxppc-dev@lists.linuxppc.org'`
refile +linuxList `pick --List-Id 'linux-galileo.source.mvista.com'`
folder -pop

############## SCRIPT ./tabs
echo "/*  T    T    T    T    T    T    T    T    T    T    T    T    T    T    T  */"

############## SCRIPT ./waterNag
tempFile=/tmp/waterNagTemp$$`tds`

while :
do
    day=`date '+%w'`                      # Day  between 0 and  6 means Mon-Fri
    hour=`date '+%H'`                     # Hour between 8 and 18 means 8am-6pm
    if [    $hour -gt  8   \
         -a $hour -lt 18   \
         -a $day  -gt  0   \
         -a $day  -lt  6 ]
    then
        echo "To: mod@MissionCriticalLinux.com" >$tempFile
        echo "Subject: #=-WATER-=# (wiggle toes)" >>$tempFile
        echo "" >>$tempFile
        fortune >>$tempFile
        echo "" >>$tempFile
        /usr/lib/mh/post $tempFile
        rm -f $tempFile
    fi
    sleep 5000
done

############## SCRIPT ./x10-reset
#!/bin/bash
#!/usr/bin/bash

#
# Script to allow remote-reset of systems via X10-connected
# relays and power modules.
#

myName=$0

###############################################################################
# This dataBase is the sole source for all info in this script.
# No more uncoordinated usage of multiple, stale databases -
# just this ONE single stale database.  Progress!
#
# If you modify the database, please maintain tabular,
# alphabetized layout for readability's sake...
#
# Triples represent {hostname,x10houseCode,x10unitCode}
#

dataBase=( \
	"[A1]		A	1"	\
	"[A2]		A	2"	\
	"[A3]		A	3"	\
	"[A4]		A	4"	\
	"lab21		A	5"	\
	"[A6]		A	6"	\
	"[A7]		A	7"	\
	"[A8]		A	8"	\
	"[A9]		A	9"	\
	"[A10]		A	10"	\
	"[A11]		A	11"	\
	"[A12]		A	12"	\
	"[A13]		A	13"	\
	"[A14]		A	14"	\
	"[A15]		A	15"	\
	"testing	A	16"	\
    )

###############################################################################
function dbTripleForKey()  {
    if [ $# -ne 2 ]
    then
        echo "Internal error - dbTripleForKey() needs key and value"
        exit 1
    fi

    indexLimit=${#dataBase[*]}
    index=0
    while [ $index -lt $indexLimit ]
    do
        triple=( ${dataBase[$index]} )       # Index the database for a triple.
        case "$1" in
        1|2|3)
           if [ ${triple[$[$1 - 1]]} == $2 ]        # Index triple for a field.
           then
               echo ${dataBase[$index]}
               return 0
           fi;;
        *)
            echo "BOGUS key value specified in dbTripleForKey()"
            exit 1;;
        esac

        index=$[$index + 1]
    done
    return 1
}

###############################################################################
function dbTripleForHostname()  {
    if [ $# -ne 1 ]
    then
        echo "Internal error - dbTripleForHostname() needs Hostname"
        exit 1
    fi

    dbTripleForKey 1 $1
}

###############################################################################
function allHostnames()  {
    indexLimit=${#dataBase[*]}
    index=0
    while [ $index -lt $indexLimit ]
    do
        triple=( ${dataBase[$index]} )
        echo ${triple[0]}
        index=$[$index + 1]
    done
}

###############################################################################
function allHouseCodes()  {
    indexLimit=${#dataBase[*]}
    index=0
    while [ $index -lt $indexLimit ]
    do
        triple=( ${dataBase[$index]} )
        echo ${triple[1]}
        index=$[$index + 1]
    done
}

###############################################################################
function allUnitCodes()  {
    indexLimit=${#dataBase[*]}
    index=0
    while [ $index -lt $indexLimit ]
    do
        triple=( ${dataBase[$index]} )
        echo ${triple[2]}
        index=$[$index + 1]
    done
}

###############################################################################
function allDataBaseEntries()  {
    indexLimit=${#dataBase[*]}
    index=0
    while [ $index -lt $indexLimit ]
    do
        echo ${dataBase[$index]}
        index=$[$index + 1]
    done
}

###############################################################################
function usage()  {

    echo "Failed:" $@
    echo ""
    echo "Usage:"
    echo "        $myName Hostname"
    echo ""

    echo "where Hostname specifies a system capable of being"
    echo "reset by means of an X10-connected relay.  The Reset"
    echo "logic of the specified machine will be activated if"
    echo "the machine is found in a list of known systems..."
    echo ""

    allHostnames | fmt
    exit 1
}

###############################################################################
# True execution actually begins here...
#

if [ $# -eq 1 ]                                       # Number of args correct?
then
    triple=( `dbTripleForHostname $1` )   # Fetch desired triple from dataBase.
    if [ $? -eq 0 ]                                   # Found specified system?
    then
        echo     ${triple[*]}                         # Announce what we found.
        target=${triple[1]}${triple[2]}
        heyu turn $target on
        heyu turn $target on
        heyu turn $target off
        heyu turn $target off
        exit 0
    else
        usage "Couldn't find system '$1'"
    fi
else
    usage "exactly one systemName must be specified"
fi

############## SCRIPT ./zeroToday
date | sed -e 's/ [0-9][0-9]:[0-9][0-9]:[0-9][0-9] / 00:00:00 /'

############## SCRIPT ./uniqFilesMD5

if [ -x ~mod/local/bin/eat ]
then
    COLLAPSE_WHITESPACE=~mod/local/bin/eat
else
    COLLAPSE_WHITESPACE="sed -e 's/[	 ][	 ]*/ /g' "
fi

####
# The timeStamp is handy for generating any
# unique-per-script-invocation temp files and such...
#
      timeStamp=`tds`
        tempDir=/tmp
        md5List=$tempDir/md5List$timeStamp
       tempFile=$tempDir/tempFile$timeStamp
      stdinList=$tempDir/stdinList$timeStamp
     tagsOfDups=$tempDir/tagsOfDups$timeStamp
representatives=$tempDir/representatives$timeStamp

for f in $md5List $representatives $tagsOfDups $timeStamp
do
    cat /dev/null >$f
done

cat >$stdinList

####
# Use md5 to compute a signature value for each file and then look
# for duplicates in a sorted list of those values.  Since each
# such value can be relied upon to be unique for each unique file,
# duplicate tags indicate duplicate files which may be removed
# from our list.
#
#echo "#### Calculating md5 tag for each file..."
xargs -l20 md5sum <$stdinList | sort >$md5List

#echo "####" md5List...
#cat $md5List

####
# From the $md5List, clip out a list of md5 tags which are
# associated with duplicate files, one tag per group of
# two-or-more duplicate files...
#
$COLLAPSE_WHITESPACE <$md5List | cut -f 1 -d ' ' | uniq -d >$tagsOfDups

#echo "####" tagsOfDups...
#ls -la $tagsOfDups
#cat $tagsOfDups

if [ ! -s $tagsOfDups ]
then
#   echo "####" No dups
    cat $stdinList
else

#   echo "####" Selecting one representative from each set of duplicates...
    for tag in `cat $tagsOfDups`
    do
#       echo "####" tag:$tag
        fgrep $tag $md5List | head -1 >>$representatives
    done

#   echo "####" representatives...
#   cat $representatives

    ####
    # Since $md5List is really just stdin with an md5 tag on each
    # line we now delete ALL duplicates from $md5List and append what's
    # left to our collection of retained-dup's, then sort the whole mess
    # and overwrite $inputList with the no-duplicates version...
    #
#   echo "####" Discarding names of ALL duplicated files...
    fgrep -f $tagsOfDups -v <$md5List >>$tempFile

#   echo "####" tempFile is...
#   cat $tempFile

#   echo "####" Sorting representatives back into the list...
#   $COLLAPSE_WHITESPACE < $tempFile | cut -f 2 -d ' ' | sort
    cat $representatives  $tempFile | $COLLAPSE_WHITESPACE | cut -f 2 -d ' ' | sort

fi

rm -f $md5List $representatives $tagsOfDups $tempFile $timeStamp $stdinList

exit 0

############## SCRIPT ./extractURLs
sed -e 's/^/ /'                  \
    -e 's/[	 ][	 ]*/ /g' \
    -e 's/[")><]/\
 /g' \
    -e 's/ $//'                  \
    -e 's@[Hh][Tt][Tt][Pp]:/@\
 http:/@g'                       \
    -e 's/http-equiv//'          \
 | fmt -1 | fgrep -i http | sort -fd | uniq

############## SCRIPT ./tagMD5

###############################################################################
function usage()  {
    echo "Failed:" $@
    exit 1
}

###############################################################################

     tmp=$$`tds`
startDir=$PWD

while read f
do
    cd $startDir
    dir=`dirname $f`
    cd $dir                                  || usage "can't CD to dirname($f)"

    tmp=$[$tmp + 1]
    while [ -f $tmp ]
    do
        tmp=$[$tmp + 1]
    done

    base=`basename $f`
    test -f $base                            || usage "no basename($f) in $dir"
    md5=`md5sum $base | word1`
    mv $base $tmp                     || usage "Couldn't mv $base $tmp in $dir"
    test -f $md5               && usage "already have file $md5 in $dir($base)"
    mv $tmp $md5                       || usage "Couldn't mv $tmp $md5 in $dir"
done

############## SCRIPT ./mailias
cat <<EOF
From: Model Citizen <archetype@attbi.com>
Newsgroups: rec.auto.vw,rec.autos.makers.vw,rec.autos.makers.vw.watercooled,rec.autos.vw
From: Sherman Act <monopoly@attbi.com>
FrOM: fAsHiON statEMeNT <aNNOyiNG@poInTLesS.AFfectAtIONS.r.uS>
From: Indifferent <overprivileged@entitled.com>
From: Gooda Murkin <yay.team@patriots.r.us>
From: Dain Bramage <msft@attbi.com>
From: Flatus Elegante <flatus@inspectore.va>
From: Chuck U. Farley <and@your.littleDog.too>
EOF

############## SCRIPT ./linux-fai
cat <<EOF
Mail-Reply-To: mod+linux-fai@std.com
From: mod+linux-fai@std.com
Mail-Followup-To: linux-fai@uni-koeln.de
Reply-To: linux-fai@uni-koeln.de
To: linux-fai@uni-koeln.de
Subject:
EOF

############## SCRIPT ./genShrapnelContenTables
cd /tmp
cat <<EOF | while read mnt dev
/mnt/hdh1 hdh1
/mnt/hdg1 hdg1
/mnt/hda4 hda4
/mnt/hda3 hda3
/boot     hda1
/         hda2
EOF
do
    ( sudo find $mnt -xdev >ContenTable.$dev ; sort <ContenTable.$dev >ContenTableSORT.$dev ; mv ContenTableSORT.$dev ContenTable.$dev ; gzip ContenTable.$dev ) >/tmp/rzqLog.$dev 2>&1 &
done

############## SCRIPT ./lineupequals
sed -e 's/[	 ][	 ]*/ /g' -e 's/^ //' -e 's/ $//' -e 's/=/ = /' | lineup1 | sed -e 's/^\([^ ]*\) \( *\)= /\2\1=/'

############## SCRIPT ./errno
cat /usr/include/asm/errno.h /usr/include/linux/errno.h

############## SCRIPT ./openURL
#!/bin/sh

Usage="Usage: url <url>    supply no args to use the X-selection"
url=$1

if [ "$url" = "" ]; then
	url=`echo 'wm withdraw .; set X ""; catch {set X [selection get]}; puts $X; exit 0' | wish -`
fi

if [ "$url" != "" ]; then
	netscape -noraise -remote openURL\($url,new-window\)
else
	echo "$Usage"
	exit 1
fi

############## SCRIPT ./cycas2
#!/bin/sh
xmodmap -e "keycode 0x6C =  Return"
xmodmap -e "keycode 0x5B =  period"
cd /home/mod/local/binIntelX86/cycas2; ./cycas.real > /dev/null 2>&1 &

############## SCRIPT ./cycas2_verbose
#!/bin/sh
cd /home/mod/local/binIntelX86/cycas2; ./cycas.real &

############## SCRIPT ./cycas2_deinstall
#!/bin/sh
rm -R /home/mod/local/binIntelX86/cycas2
rm /home/mod/local/script/cycas2*
rm /etc/cycas.dir
if test -e /usr/share/gnome/apps/Applications/CYCAS.desktop
then
 rm /usr/share/gnome/apps/Applications/CYCAS.desktop
fi
if test -e /usr/share/pixmaps/cycas2.xpm
then
 rm /usr/share/pixmaps/cycas2.xpm
fi
if test -e /usr/share/applnk/Applications/CYCAS.kdelnk
then
 rm /usr/share/applnk/Applications/CYCAS.kdelnk
fi
if test -e /usr/share/icons/cycas2.xpm
then
 rm /usr/share/icons/cycas2.xpm
fi

############## SCRIPT ./isNullModem
#############################################################
# Nasty hack to allow discovery of whether a given RS232
# cable is wired as a NULL modem after connecting its ends
# to two serial ports on the current machine.  Some of the
# gymnastics here are a clumsy attempt to get around the
# problem where (it seems that) further attempts to read
# from some serial port (tty drivers) hang until they've
# been opened and closed.
#
# Another complication is setting up reader and writer
# tasks and then managing them without wedging ourselves...
#
# The initString was obtained (on a Debian potato system
# running a 2.4.18 kernel on 3 July 2002) by setting
# a serial port to a known-good state and then saying:
#
#  stty -g <thatSerialPort
#
      tty0=/dev/ttyS0
      tty1=/dev/ttyS1
 timeStamp=`date '+%Y%m%d%H%M%S'`
 tempFile0=/tmp/tempFile0$timeStamp
 tempFile1=/tmp/tempFile1$timeStamp
initString="1:0:800008bd:0:3:1c:7f:15:4:5:1:0:11:13:1a:0:12:f:17:16:0:0:2f:0:0:0:0:0:0:0:0:0:0:0:0:0"

###############################################################################
function fail()  {
    echo "FAIL:" $@
    exit 1
}

###############################################################################
test -f $tempFile0                && fail "Temp file $tempFile0 already exists"
test -f $tempFile1                && fail "Temp file $tempFile1 already exists"

#
# Gratuitous open/close sequences...
#
pid0=`( dd bs=1 count=1 if=$tty0 >/dev/null 2>&1 & echo $! ) `
pid1=`( dd bs=1 count=1 if=$tty1 >/dev/null 2>&1 & echo $! ) `
sleep 2
( kill -9 $pid0 ) >/dev/null 2>&1
( kill -9 $pid1 ) >/dev/null 2>&1

#
# Init serial ports to known values, same baud rates, etc...
#
wait
rzq0=`stty -g <$tty0`     || fail "Couldn't read current settings from $tty0"
rzq1=`stty -g <$tty1`     || fail "Couldn't read current settings from $tty1"
stty $initString <$tty0   || (                     fail "Couldn't init $tty0" )
stty $initString <$tty1   || ( stty $rzq0 <$tty0 ; fail "Couldn't init $tty1" )

#
# Pretty much committed from here on out.
# Prep the Reader task...
#
( while [ ! -f $tempFile1 ]; do :; done; read -t 2 ttyData <$tty1 ; echo ttyData $ttyData >$tempFile1 ) &
readerPID=$!

#
# ...and the Writer task...
#
( while [ ! -f $tempFile0 ]; do :; done; rm $tempFile0 ; echo isNullModem >$tty0 ) &
writerPID=$!

#
# ...Signal them to start...
#
>$tempFile1
>$tempFile0

#
# ...then see if the Reader got the Writer's message.
#
sleep 2
if fgrep isNullModem $tempFile1 >/dev/null 2>&1
then
    echo -n "SUCCESS: null modem detected"
    result=0
else
    echo -n "FAIL (apparently NOT a null modem)"
    ( kill -9 $readerPID ) >/dev/null 2>&1
#   ( kill -9 $writerPID ) >/dev/null 2>&1

    #
    # A parting gratuitous open/close sequence...
    #
    pid0=`( dd bs=1 count=1 if=$tty0 >/dev/null 2>&1 & echo $! ) `
    pid1=`( dd bs=1 count=1 if=$tty1 >/dev/null 2>&1 & echo $! ) `
    sleep 2
    ( kill -9 $pid0 ) >/dev/null 2>&1
    ( kill -9 $pid1 ) >/dev/null 2>&1
    result=1
fi

#
# Restore previous tty states...
#
echo " - cleaning up..."
pid0=`( stty $rzq0 <$tty0 >/dev/null & echo $! ) `
pid1=`( stty $rzq1 <$tty1 >/dev/null & echo $! ) `
sleep 2
( kill -9 $pid0 ) >/dev/null 2>&1
( kill -9 $pid1 ) >/dev/null 2>&1

rm -f $tempFile1 $tempFile0

exit $result

############## SCRIPT ./notify
for site in $@
do
    ssh world.std.com 'retrieve $site'
    echo "######### NOTIFIED $site"
done

############## SCRIPT ./skeptics
#X-message-flag: ALERT!!  You *MUST* Reboot IMMEDIATELY!!
#cc: mod@std.com
#From: mod@std.com (Michael O'Donnell)
#Reply-To: mod@std.com

if [ -z "$1" ]
then
	export RZQ=lucid@skeptics.org
else
	export RZQ=lucid+"$1"@skeptics.org
fi

cat <<EOF
From:             "$RZQ" <$RZQ>
Mail-Followup-To: "$RZQ" <$RZQ>
Mail-Reply-To:    "$RZQ" <$RZQ>
Reply-To:         "$RZQ" <$RZQ>
cc:               "$RZQ" <$RZQ>
To:
Subject:

EOF

############## SCRIPT ./fisette
 fromHack | sed -e 's/^[Tt][Oo]:[	 ].*$/To: fisette@charter.net/'

############## SCRIPT ./loonyCounterScript
#!/bin/sh
# my home site without having to ftp during the day.
# Ted Park, August, 1994.
#SPOOLDIR="/usr/spool/news/clari/feature/dilbert"
SPOOLDIR="/usr/spool/news/talk/abortion"
if [ -f art_proc ] ; then
 echo "art_proc exists."
else
  echo "No art_proc file."
  touch art_proc
fi
for i in `ls $SPOOLDIR`
do
   echo $i
   if [ -f art_proc ] ; then
      if grep -s $i art_proc ; then
      :
      else
         echo "Now adding to list."
         echo $i >> art_proc
         head  $SPOOLDIR/$i | grep "^From: " | sed -e 's/^From: //' >> poster.list
         head  $SPOOLDIR/$i | grep "^Subject: " | sed -e 's/^Subject: //' >> subject.list
      fi
   else
     echo "No art_proc file."
   fi
done
cat /dev/null > /tmp/file3
cat /dev/null > /tmp/sfile3
FIRSTCOUNT=`cat poster.list | wc -l `
SECONDCOUNT=0
sort -u poster.list > /tmp/file2
sort -u subject.list > /tmp/sfile2
echo "Counting"
cat /tmp/file2 | while read i ; do
  echo $i
  COUNT=`grep "$i" poster.list | wc -l`
  SECONDCOUNT=`echo "$COUNT + $SECONDCOUNT" | bc`
  echo $SECONDCOUNT
  PERCENT=`echo ${COUNT} ${FIRSTCOUNT} | awk '{printf ("scale=6;%d/%d*100\n",$1,$2)}' | bc`
  echo "$COUNT ! $PERCENT ! $i" | awk -F '!' '{printf ("%03d %8.2f%% %s \n", $1, $2, $3)}' >> /tmp/file3
done
echo $FIRSTCOUNT
echo "Out of $FIRSTCOUNT  articles: " > summary
cat /tmp/file3 | sort -r |  sed -e 's/^00/  /' -e 's/^0/ /' >> summary
SECONDCOUNT=0
cat /tmp/sfile2 | while read i ; do
  echo $i
  COUNT=`grep "$i" subject.list | wc -l`
  SECONDCOUNT=`echo "$COUNT + $SECONDCOUNT" | bc`
  echo $SECONDCOUNT
  PERCENT=`echo ${COUNT} ${FIRSTCOUNT} | awk '{printf ("scale=6;%d/%d*100\n",$1,$2)}' | bc`
  echo "$COUNT ! $PERCENT ! $i" | awk -F '!' '{printf ("%03d %8.2f%% %s \n", $1, $2, $3)}' >> /tmp/sfile3
done
echo $FIRSTCOUNT
echo "Out of $FIRSTCOUNT  articles: " > ssummary
cat /tmp/sfile3 | sort -r |  sed -e 's/^00/  /' -e 's/^0/ /' >> ssummary

############## SCRIPT ./diffLinuxConfigWORK/diffConfig.version1

function usage()  {
    echo usage: $0 configFile1 configFile2
    exit 1
}

####
# The timeStamp is handy for generating any
# unique-per-script-invocation temp files and such...
#
timeStamp=`date '+%Y%m%d%H%M%S'`
  md5List=md5List$timeStamp
  tempDir=/tmp/tempDir$timeStamp
 tempFile=$tempDir/tempFile$timeStamp
     dir1=$tempDir/dir1
     dir2=$tempDir/dir2

allow_null_glob_expansion=setInScriptFile

if [ ! $# -eq 2 ]
then
    echo must mention two config files
    usage
fi

if [ ! -f $1 ]
then
    echo $1 not a file
    usage
fi

if [ ! -f $2 ]
then
    echo $2 not a file
    usage
fi

mkdir -p $dir1/ONLY
mkdir    $dir1/COMMON
mkdir -p $dir2/ONLY
mkdir    $dir2/COMMON

fgrep CONFIG $1 | sed -e '/^[	 ]*#/d' | while read line
do
    token=`echo $line | sed -e 's/=.*$//' `
    echo $line >$dir1/COMMON/$token
done

fgrep CONFIG $2 | sed -e '/^[	 ]*#/d' | while read line
do
    token=`echo $line | sed -e 's/=.*$//' `
    if [ ! -f $dir1/COMMON/$token ]
    then
        echo $line >$dir2/ONLY/$token
    else
        echo $line >$dir2/COMMON/$token
    fi
done

cd $dir1/COMMON
for token in *
do
    if [ ! -f $dir2/COMMON/$token ]
    then
        mv $token $dir1/ONLY
    fi
done

cd $dir1/ONLY
echo "############# ONLY in $1":
ls -C

cd $dir2/ONLY
echo "############# ONLY in $2":
ls -C

cd $dir1/COMMON
for token in *
do
    if ! diff -q $dir1/COMMON/$token $dir2/COMMON/$token >>$tempFile
    then
        echo "############ begin ############" $1 $token $2
        diff $dir1/COMMON/$token $dir2/COMMON/$token
        echo "############  end  ############" $1 $token $2
    fi
rm $token $dir2/COMMON/$token
done

#rm -rf $tempDir

############## SCRIPT ./diffLinuxConfigWORK/diffConfig.version3

allow_null_glob_expansion=setInScriptFile
set +f

function usage()  {
    echo usage: $0 configFile1 configFile2
    exit 1
}

####
# The timeStamp is handy for generating any
# unique-per-script-invocation temp files and such...
#
timeStamp=`date '+%Y%m%d%H%M%S'`
  md5List=md5List$timeStamp
  tempDir=/tmp/tempDir$timeStamp
 tempFile=$tempDir/tempFile$timeStamp
     dir1=$tempDir/dir1
     dir2=$tempDir/dir2

mkdir -p $dir1
mkdir -p $dir2

if [ ! $# -eq 2 ]
then
    echo must mention two config files
    usage
fi

if [ ! -f $1 ]
then
    echo $1 not a file
    usage
fi

if [ ! -f $2 ]
then
    echo $2 not a file
    usage
fi

fgrep CONFIG $1 | while read rawLine
do
    echo "$rawLine" | grep -e '^[	 ]*#' >/dev/null
    enabled=$?
    if [ $enabled -eq 0 ]
    then                                                             # Disabled
        line=`echo "$rawLine" | sed -e 's/^[	 ]*#[	 ]*//' `
    else                                                              # Enabled
        line=`echo "$rawLine" | sed -e 's/^[	 ]*//' `
    fi
    token=`echo $line  | sed -e 's/[	 =].*$//' `

    mkdir -p $dir1/$token
    if [ $enabled -eq 0 ]
    then                                                             # Disabled
#echo "######## DISABLED1 <$token> <$rawLine>"
        echo "$rawLine" >$dir1/$token/DISABLED
    else                                                              # Enabled
#echo "######## ENABLED1 <$token> <$rawLine>"
        echo "$rawLine" >$dir1/$token/ENABLED
    fi
done

fgrep CONFIG $2 | while read rawLine
do
    echo "$rawLine" | grep -e '^[	 ]*#' >/dev/null
    enabled=$?
    if [ $enabled -eq 0 ]
    then                                                             # Disabled
        line=`echo "$rawLine" | sed -e 's/^[	 ]*#[	 ]*//' `
    else                                                              # Enabled
        line=`echo "$rawLine" | sed -e 's/^[	 ]*//' `
    fi
    token=`echo $line  | sed -e 's/[	 =].*$//' `

    mkdir -p $dir2/$token
    if [ $enabled -eq 0 ]
    then                                                             # Disabled
#echo "#### DISABLED2 <$token> <$rawLine>"
        echo "$rawLine" >$dir2/$token/DISABLED
    else                                                              # Enabled
#echo "#### ENABLED2 <$token> <$rawLine>"
        echo "$rawLine" >$dir2/$token/ENABLED
    fi
done

cd $dir1
for token in *
do
    if [ -f $token/ENABLED ]
    then
        if [ -f $token/DISABLED ]
        then
            echo "####" $token is both DISABLED and ENABLED - trimming...
            rm $token/DISABLED
        fi
    fi
done

cd $dir2
for token in *
do
    if [ -f $token/ENABLED ]
    then
        if [ -f $token/DISABLED ]
        then
            echo "####" $token is both DISABLED and ENABLED - trimming...
            rm $token/DISABLED
        fi
    fi
done

cd $dir1
for token in *
do
    if [ -f $token/DISABLED  -a -f $dir2/$token/DISABLED ]
    then
        echo $token >>$tempDir/commonDISABLED
        rm $token/DISABLED $dir2/$token/DISABLED
        rmdir       $token
        rmdir $dir2/$token
    fi

    if [ -f $token/ENABLED  -a -f $dir2/$token/ENABLED ]
    then
        if diff -qb $token/ENABLED $dir2/$token/ENABLED >/dev/null
        then
            cat $token/ENABLED >>$tempDir/commonENABLED
            rm $token/ENABLED $dir2/$token/ENABLED
            rmdir       $token
            rmdir $dir2/$token
        fi
    fi
done

cd $dir1
for token in *
do
    if [ -f $token/DISABLED ]
    then
        echo  $token >>$tempDir/uniqueDISABLED1
        rm    $token/DISABLED
        rmdir $token
    fi

    if [ -f $token/ENABLED ]
    then
        cat   $token/ENABLED >>$tempDir/uniqueENABLED1
        rm    $token/ENABLED
        rmdir $token
    fi

done

cd $dir2
for token in *
do
    if [ -f $token/DISABLED ]
    then
        echo  $token >>$tempDir/uniqueDISABLED2
        rm    $token/DISABLED
        rmdir $token
    fi

    if [ -f $token/ENABLED ]
    then
        cat   $token/ENABLED >>$tempDir/uniqueENABLED2
        rm    $token/ENABLED
        rmdir $token
    fi

done

echo "####" Common DISABLED options:
cat  $tempDir/commonDISABLED

echo "####" Common ENABLED options:
cat  $tempDir/commonENABLED

echo "####" Enabled options unique to $1:
cat  $tempDir/uniqueENABLED1

echo "####" Enabled options unique to $2:
cat  $tempDir/uniqueENABLED2

echo EARLY EXIT...
exit 1

cd $dir1/COMMON/ENABLED
for token in `find . -type f`
do
    if [ ! -f $dir2/COMMON/DISABLED/$token -a ! -f $dir2/COMMON/ENABLED/$token ]
    then
        mv $token $dir1/UNIQUE/ENABLED
    fi
done

cd $dir1/COMMON/DISABLED
for token in `find . -type f`
do
    if [ ! -f $dir2/COMMON/DISABLED/$token -a ! -f $dir2/COMMON/ENABLED/$token ]
    then
        mv $token $dir1/UNIQUE/DISABLED
    fi
done

echo "############# Disabled options unique to $1"
cd $dir1/UNIQUE/DISABLED/
for f in `find . -type f -print`
do
    cat $f
done

echo "############# Disabled options unique to $2"
cd $dir2/UNIQUE/DISABLED/
for f in `find . -type f -print`
do
    cat $f
done

echo "############# Enabled options unique to $1"
cd $dir1/UNIQUE/ENABLED/
for f in `find . -type f -print`
do
    cat $f
done

echo "############# Enabled options unique to $2"
cd $dir2/UNIQUE/ENABLED/
for f in `find . -type f -print`
do
    cat $f
done

echo "############# Common options, enabled but different..."
cd $dir1/COMMON/ENABLED
for token in `find . -type f -print`
do
    if ! diff -q $dir1/COMMON/ENABLED/$token $dir2/COMMON/ENABLED/$token >>$tempFile
    then
        echo "############ begin ############" $1 $token $2
        diff $dir1/COMMON/ENABLED/$token $dir2/COMMON/ENABLED/$token
        echo "############  end  ############" $1 $token $2
    fi
rm $token $dir2/COMMON/ENABLED/$token
done

 rm -rf $tempDir

############## SCRIPT ./diffLinuxConfigWORK/diffConfig.version2

allow_null_glob_expansion=setInScriptFile
set +f

function usage()  {
    echo usage: $0 configFile1 configFile2
    exit 1
}

####
# The timeStamp is handy for generating any
# unique-per-script-invocation temp files and such...
#
timeStamp=`date '+%Y%m%d%H%M%S'`
  md5List=md5List$timeStamp
  tempDir=/tmp/tempDir$timeStamp
 tempFile=$tempDir/tempFile$timeStamp
     dir1=$tempDir/dir1
     dir2=$tempDir/dir2

if [ ! $# -eq 2 ]
then
    echo must mention two config files
    usage
fi

if [ ! -f $1 ]
then
    echo $1 not a file
    usage
fi

if [ ! -f $2 ]
then
    echo $2 not a file
    usage
fi

mkdir -p $dir1/COMMON/DISABLED $dir1/UNIQUE/DISABLED \
         $dir1/COMMON/ENABLED  $dir1/UNIQUE/ENABLED  \
         $dir2/COMMON/DISABLED $dir2/UNIQUE/DISABLED \
         $dir2/COMMON/ENABLED  $dir2/UNIQUE/ENABLED

fgrep CONFIG $1 | while read rawLine
do
    echo "$rawLine" | grep -e '^[	 ]*#' >/dev/null
    enabled=$?
    if [ $enabled -eq 0 ]
    then                                                             # Disabled
        line=`echo "$rawLine" | sed -e 's/^[	 ]*#[	 ]*//' `
    else                                                              # Enabled
        line=`echo "$rawLine" | sed -e 's/^[	 ]*//' `
    fi
    token=`echo $line  | sed -e 's/[	 =].*$//' `

    if [ $enabled -eq 0 ]
    then                                                             # Disabled
#echo "######## DISABLED1 <$token> <$rawLine>"
        echo "$rawLine" >$dir1/COMMON/DISABLED/$token
    else                                                              # Enabled
#echo "######## ENABLED1 <$token> <$rawLine>"
        echo "$rawLine" >$dir1/COMMON/ENABLED/$token
    fi
done

fgrep CONFIG $2 | while read rawLine
do
    echo "$rawLine" | grep -e '^[	 ]*#' >/dev/null
    enabled=$?
    if [ $enabled -eq 0 ]
    then                                                             # Disabled
        line=`echo "$rawLine" | sed -e 's/^[	 ]*#[	 ]*//' `
    else                                                              # Enabled
        line=`echo "$rawLine" | sed -e 's/^[	 ]*//' `
    fi
    token=`echo $line  | sed -e 's/[	 =].*$//' `

    if [ $enabled -eq 0 ]
    then                                                             # Disabled
#echo "######## DISABLED2 <$token> <$rawLine>"
        if [ -f $dir1/COMMON/DISABLED/$token -o -f $dir1/COMMON/ENABLED/$token ]
        then
            echo "$rawLine" >$dir2/COMMON/DISABLED/$token
        else
            echo "$rawLine" >$dir2/UNIQUE/DISABLED/$token
        fi
    else                                                              # Enabled
#echo "######## ENABLED2 <$token> <$rawLine>"
        if [ -f $dir1/COMMON/DISABLED/$token -o -f $dir1/COMMON/ENABLED/$token ]
        then
            echo "$rawLine" >$dir2/COMMON/ENABLED/$token
        else
            echo "$rawLine" >$dir2/UNIQUE/ENABLED/$token
        fi
    fi
done

cd $dir1/COMMON/ENABLED
for token in `find . -type f`
do
    if [ ! -f $dir2/COMMON/DISABLED/$token -a ! -f $dir2/COMMON/ENABLED/$token ]
    then
        mv $token $dir1/UNIQUE/ENABLED
    fi
done

cd $dir1/COMMON/DISABLED
for token in `find . -type f`
do
    if [ ! -f $dir2/COMMON/DISABLED/$token -a ! -f $dir2/COMMON/ENABLED/$token ]
    then
        mv $token $dir1/UNIQUE/DISABLED
    fi
done

echo "############# Disabled options unique to $1"
cd $dir1/UNIQUE/DISABLED/
for f in `find . -type f -print`
do
    cat $f
done

echo "############# Disabled options unique to $2"
cd $dir2/UNIQUE/DISABLED/
for f in `find . -type f -print`
do
    cat $f
done

echo "############# Enabled options unique to $1"
cd $dir1/UNIQUE/ENABLED/
for f in `find . -type f -print`
do
    cat $f
done

echo "############# Enabled options unique to $2"
cd $dir2/UNIQUE/ENABLED/
for f in `find . -type f -print`
do
    cat $f
done

echo "############# Common options, enabled but different..."
cd $dir1/COMMON/ENABLED
for token in `find . -type f -print`
do
    if ! diff -q $dir1/COMMON/ENABLED/$token $dir2/COMMON/ENABLED/$token >>$tempFile
    then
        echo "############ begin ############" $1 $token $2
        diff $dir1/COMMON/ENABLED/$token $dir2/COMMON/ENABLED/$token
        echo "############  end  ############" $1 $token $2
    fi
rm $token $dir2/COMMON/ENABLED/$token
done

 rm -rf $tempDir

############## SCRIPT ./diffLinuxConfigWORK/diffConfig

function usage()  {
    echo usage: $0 configFile1 configFile2
    exit 1
}

####
# These seem not to work as I expected...
#
allow_null_glob_expansion=setInScriptFile
set +f

####
# The timeStamp is handy for generating any
# unique-per-script-invocation temp files and such...
#
timeStamp=`date '+%Y%m%d%H%M%S'`
  md5List=md5List$timeStamp
  tempDir=/tmp/tempDir$timeStamp
 tempFile=$tempDir/tempFile$timeStamp
     dir1=$tempDir/dir1
     dir2=$tempDir/dir2

if [ ! $# -eq 2 ]
then
    echo must mention two config files
    usage
fi

if [ ! -f $1 ]
then
    echo $1 not a file
    usage
fi

if [ ! -f $2 ]
then
    echo $2 not a file
    usage
fi

fgrep CONFIG $1 | while read rawLine
do
    echo "$rawLine" | grep -e '^[	 ]*#' >/dev/null
    enabled=$?
    if [ $enabled -eq 0 ]
    then                                                             # Disabled
        line=`echo "$rawLine" | sed -e 's/^[	 ]*#[	 ]*//' `
    else                                                              # Enabled
        line=`echo "$rawLine" | sed -e 's/^[	 ]*//' `
    fi
    token=`echo $line  | sed -e 's/[	 =].*$//' `

    mkdir -p $dir1/$token
    if [ $enabled -eq 0 ]
    then                                                             # Disabled
#echo "######## DISABLED1 <$token> <$rawLine>"
        echo "$rawLine" >$dir1/$token/DISABLED
    else                                                              # Enabled
#echo "######## ENABLED1 <$token> <$rawLine>"
        echo "$rawLine" >$dir1/$token/ENABLED
    fi
done

fgrep CONFIG $2 | while read rawLine
do
    echo "$rawLine" | grep -e '^[	 ]*#' >/dev/null
    enabled=$?
    if [ $enabled -eq 0 ]
    then                                                             # Disabled
        line=`echo "$rawLine" | sed -e 's/^[	 ]*#[	 ]*//' `
    else                                                              # Enabled
        line=`echo "$rawLine" | sed -e 's/^[	 ]*//' `
    fi
    token=`echo $line  | sed -e 's/[	 =].*$//' `

    mkdir -p $dir2/$token
    if [ $enabled -eq 0 ]
    then                                                             # Disabled
#echo "#### DISABLED2 <$token> <$rawLine>"
        echo "$rawLine" >$dir2/$token/DISABLED
    else                                                              # Enabled
#echo "#### ENABLED2 <$token> <$rawLine>"
        echo "$rawLine" >$dir2/$token/ENABLED
    fi
done

cd $dir1
for token in *
do
    if [ -f $token/ENABLED ]
    then
        if [ -f $token/DISABLED ]
        then
            echo "####" $token is both DISABLED and ENABLED - trimming...
            rm $token/DISABLED
        fi
    fi
done

cd $dir2
for token in *
do
    if [ -f $token/ENABLED ]
    then
        if [ -f $token/DISABLED ]
        then
            echo "####" $token is both DISABLED and ENABLED - trimming...
            rm $token/DISABLED
        fi
    fi
done

cd $dir1
for token in *
do
    if [ -f $token/DISABLED  -a -f $dir2/$token/DISABLED ]
    then
        echo $token >>$tempDir/commonDISABLED
        rm $token/DISABLED $dir2/$token/DISABLED
        rmdir       $token
        rmdir $dir2/$token
    fi

    if [ -f $token/ENABLED  -a -f $dir2/$token/ENABLED ]
    then
        if diff -qb $token/ENABLED $dir2/$token/ENABLED >/dev/null
        then
            cat $token/ENABLED >>$tempDir/commonENABLED
            rm $token/ENABLED $dir2/$token/ENABLED
            rmdir       $token
            rmdir $dir2/$token
        fi
    fi
done

cd $dir1
for token in *
do
    if [ -f $token/DISABLED ]
    then
        echo  $token >>$tempDir/uniqueDISABLED1
        rm    $token/DISABLED
        rmdir $token
    fi

    if [ -f $token/ENABLED ]
    then
        cat   $token/ENABLED >>$tempDir/uniqueENABLED1
        rm    $token/ENABLED
        rmdir $token
    fi

done

cd $dir2
for token in *
do
    if [ -f $token/DISABLED ]
    then
        echo  $token >>$tempDir/uniqueDISABLED2
        rm    $token/DISABLED
        rmdir $token
    fi

    if [ -f $token/ENABLED ]
    then
        cat   $token/ENABLED >>$tempDir/uniqueENABLED2
        rm    $token/ENABLED
        rmdir $token
    fi

done

echo "####" Common DISABLED options:
cat  $tempDir/commonDISABLED

echo "####" Common ENABLED options:
cat  $tempDir/commonENABLED

echo "####" Enabled options unique to $1:
cat  $tempDir/uniqueENABLED1

echo "####" Enabled options unique to $2:
cat  $tempDir/uniqueENABLED2

#rm -rf $tempDir $tempFile

############## SCRIPT ./diffLinuxConfigWORK/diffConfigRECOVERED

allow_null_glob_expansion=setInScriptFile
set +f

function usage()  {
    echo usage: $0 configFile1 configFile2
    exit 1
}

####
# The timeStamp is handy for generating any
# unique-per-script-invocation temp files and such...
#
timeStamp=`date '+%Y%m%d%H%M%S'`
  md5List=md5List$timeStamp
  tempDir=/tmp/tempDir$timeStamp
 tempFile=$tempDir/tempFile$timeStamp
     dir1=$tempDir/dir1
     dir2=$tempDir/dir2

if [ ! $# -eq 2 ]
then
    echo must mention two config files
    usage
fi

if [ ! -f $1 ]
then
    echo $1 not a file
    usage
fi

if [ ! -f $2 ]
then
    echo $2 not a file
    usage
fi

mkdir -p $dir1/COMMON/DISABLED $dir1/UNIQUE/DISABLED \
         $dir1/COMMON/ENABLED  $dir1/UNIQUE/ENABLED  \
         $dir2/COMMON/DISABLED $dir2/UNIQUE/DISABLED \
         $dir2/COMMON/ENABLED  $dir2/UNIQUE/ENABLED

fgrep CONFIG $1 | while read rawLine
do
    echo "$rawLine" | grep -e '^[	 ]*#' >/dev/null
    enabled=$?
    if [ $enabled -eq 0 ]
    then                                                             # Disabled
        line=`echo "$rawLine" | sed -e 's/^[	 ]*#[	 ]*//' `
    else                                                              # Enabled
        line=`echo "$rawLine" | sed -e 's/^[	 ]*//' `
    fi
    token=`echo $line  | sed -e 's/[	 =].*$//' `

    if [ $enabled -eq 0 ]
    then                                                             # Disabled
#echo "######## DISABLED1 <$token> <$rawLine>"
        echo "$rawLine" >$dir1/COMMON/DISABLED/$token
    else                                                              # Enabled
#echo "######## ENABLED1 <$token> <$rawLine>"
        echo "$rawLine" >$dir1/COMMON/ENABLED/$token
    fi
done

fgrep CONFIG $2 | while read rawLine
do
    echo "$rawLine" | grep -e '^[	 ]*#' >/dev/null
    enabled=$?
    if [ $enabled -eq 0 ]
    then                                                             # Disabled
        line=`echo "$rawLine" | sed -e 's/^[	 ]*#[	 ]*//' `
    else                                                              # Enabled
        line=`echo "$rawLine" | sed -e 's/^[	 ]*//' `
    fi
    token=`echo $line  | sed -e 's/[	 =].*$//' `

    if [ $enabled -eq 0 ]
    then                                                             # Disabled
#echo "######## DISABLED2 <$token> <$rawLine>"
        echo "$rawLine" >$dir2/COMMON/DISABLED/$token
    else                                                              # Enabled
#echo "######## ENABLED2 <$token> <$rawLine>"
        echo "$rawLine" >$dir2/COMMON/ENABLED/$token
    fi
done

cd $dir1/COMMON/ENABLED
for token in `find . -type f`
do
    if [ ! -f $dir2/COMMON/DISABLED/$token -a ! -f $dir2/COMMON/ENABLED/$token ]
    then
        mv $token $dir1/UNIQUE/ENABLED
    fi
done

cd $dir1/COMMON/DISABLED
for token in `find . -type f`
do
    if [ ! -f $dir2/COMMON/DISABLED/$token -a ! -f $dir2/COMMON/ENABLED/$token ]
    then
        mv $token $dir1/UNIQUE/DISABLED
    fi
done

echo "############# Disabled options unique to $1"
cd $dir1/UNIQUE/DISABLED/
for f in `find . -type f -print`
do
    cat $f
done

echo "############# Disabled options unique to $2"
cd $dir2/UNIQUE/DISABLED/
for f in `find . -type f -print`
do
    cat $f
done

echo "############# Enabled options unique to $1"
cd $dir1/UNIQUE/ENABLED/
for f in `find . -type f -print`
do
    cat $f
done

echo "############# Enabled options unique to $2"
cd $dir2/UNIQUE/ENABLED/
for f in `find . -type f -print`
do
    cat $f
done

echo "############# Common options, enabled but different..."
cd $dir1/COMMON/ENABLED
for token in `find . -type f -print`
do
    if ! diff -q $dir1/COMMON/ENABLED/$token $dir2/COMMON/ENABLED/$token >>$tempFile
    then
        echo "############ begin ############" $1 $token $2
        diff $dir1/COMMON/ENABLED/$token $dir2/COMMON/ENABLED/$token
        echo "############  end  ############" $1 $token $2
    fi
rm $token $dir2/COMMON/ENABLED/$token
done

 rm -rf $tempDir

############## SCRIPT ./lineup3
sed -e 's/^[	 ][	 ]*//' -e 's/[	 ][	 ]*$//' -e 's/[	 ][	 ]*/RZQ/g' -e 's/RZQ/ /' -e 's/RZQ/ /' -e 's/RZQ/ /' | lineup | sed -e 's/RZQ/ /g'

############## SCRIPT ./rpm2cpio
#!/usr/bin/perl

# Why does the world need another rpm2cpio?  Because the existing one
# won't build unless you have half a ton of things that aren't really
# required for it, since it uses the same library used to extract RPMs.
# In particular, it won't build on the HPsUX box I'm on.

#
# Expanded quick-reference help by Rick Moen (not the original author
# of this script).
#

# add a path if desired
$gzip = "gzip";

sub printhelp {
  print "\n";
  print "rpm2cpio, perl version by orabidoo <odar\@pobox.com>\n";
  print "\n";
  print "use: rpm2cpio [file.rpm]\n";
  print "dumps the contents to stdout as a GNU cpio archive\n";
  print "\n";
  print "In case it's non-obvious, you'll need to redirect output\n";
  print "from this script, e.g., './rpm2cpio package.rpm > package.cpio'.\n";
  print "Then, unpack in, say, /tmp with a cpio incantation like this one:\n";
  print "'cpio -ivd < package.cpio'\n";
  print "\n";
  print "You can optionally combine both steps:\n";
  print "'rpm2cpio package.rpm | cpio -iduv'\n";
  print "\n";
  print "In either event, you will also need the 'cpio' utility available\n";
  print "on your system.  If you can't find it elsewhere, source code for\n";
  print "GNU cpio is always available at ftp://ftp.gnu.org/gnu/cpio/.)\n";
  print "You'll also, of course, need Perl, and will want this Perl script\n";
  print "set as executable, i.e., by doing 'chmod 775 rpm2cpio'\n";
  print "\n";
  print "Be aware that this script works ONLY on version 3-format RPM\n";
  print "archives.  You can check an archive's RPM-format version using\n";
  print "the Unix 'file' utility.  Also, be aware that the 'cpio'\n";
  print "incantations above will unpack files at the current directory\n";
  print "level.\n";
  print "\n";

  exit 0;
}

if ($#ARGV == -1) {
  printhelp if -t STDIN;
  $f = "STDIN";
} elsif ($#ARGV == 0) {
  open(F, "< $ARGV[0]") or die "Can't read file $ARGV[0]\n";
  $f = 'F';
} else {
  printhelp;
}

printhelp if -t STDOUT;

# gobble the file up
undef $/;
$|=1;
$rpm = <$f>;
close ($f);

($magic, $major, $minor, $crap) = unpack("NCC C90", $rpm);

die "Not an RPM\n" if $magic != 0xedabeedb;
die "Not a version 3 RPM\n" if $major != 3;

$rpm = substr($rpm, 96);

while ($rpm ne '') {
  $rpm =~ s/^\c@*//s;
  ($magic, $crap, $sections, $bytes) = unpack("N4", $rpm);
  $smagic = unpack("n", $rpm);
  last if $smagic eq 0x1f8b;
  die "Error: header not recognized\n" if $magic != 0x8eade801;
  $rpm = substr($rpm, 16*(1+$sections) + $bytes);
}

die "bogus RPM\n" if $rpm eq '';

open(ZCAT, "|gzip -cd") || die "can't pipe to gzip\n";
print STDERR "CPIO archive found!\n";

print ZCAT $rpm;
close ZCAT;

############## SCRIPT ./peter
 fromHack | sed -e 's/^[Tt][Oo]:[	 ].*$/To: Peter Baldwin <Peter.Baldwin2@verizon.net>/'

#fromHack | sed -e 's/^[Tt][Oo]:[	 ].*$/To: Julie Rohrbacher <julieroh723@yahoo.com>, rohrbacj@marion.k12.fl.us/'

############## SCRIPT ./mbc
 fromHack | sed -e 's/^[Tt][Oo]:[	 ].*$/To: mbc@mc.com/' -e 's/michael.odonnell@comcast.net/mod+mbc@std.com/'

#fromHack | sed -e 's/^[Tt][Oo]:[	 ].*$/To: Julie Rohrbacher <julieroh723@yahoo.com>, rohrbacj@marion.k12.fl.us/'

############## SCRIPT ./forward2peter
    tempFile=/tmp/gzTemp$$`tds`
    tempMsg=/tmp/gzMsgTemp$$`tds`
    cat >$tempFile
    subject="`grep -i '^subject:' $tempFile | head -1 | sed -e 's/^[Ss][Uu][Bb][Jj][Ee][Cc][Tt]: *//'`"
    echo "To: Peter.Baldwin2@verizon.net"      >$tempMsg
    echo 'From: "Michael ODonnell" <michael.odonnell@comcast.net>' >>$tempMsg
    echo 'cc: "Michael ODonnell" <michael.odonnell@comcast.net>' >>$tempMsg
    echo "Subject: FWD - $subject"            >>$tempMsg
    echo ""                                   >>$tempMsg
    rq ' '                         <$tempFile >>$tempMsg
    /usr/lib/mh/post -watch -verbose            $tempMsg
    rm $tempFile $tempMsg

myName=$0

function fail()  {
    echo $myName FAILED: $@
    echo "usage:"
    echo "      $0"
    rm -f $tempFile
    exit 1
}

tempFile=`mktemp`        || fail "Script couldn't create temp file"
cat /dev/null >$tempFile || fail "Script couldn't modify temp file"

timeStamp=`date '+%Y%m%d%H%M%S'`
############## SCRIPT ./labannex
#!/bin/bash
#!/usr/bin/bash
#!/u/bin/bash
#!/opt/local/bin/bash
#!/n/viewserver/home/merlin/home2/bin/sun4/sos4/bash
#!/bin/sh

#
# labannex - connect to lab systems connected via their console
#            ports to various Annex serial-port concentrators.
#

myName=$0

###############################################################################
# A database of systemName/annexName/portNumber triples
#
# This dataBase is the sole source for all info in this script.
# No more uncoordinated usage of multiple, stale databases -
# just this ONE single stale database.  Progress!
#
# If you modify the database, please maintain tabular,
# alphabetized layout for readability's sake...
#

dataBase=( \
	"167Esystems   conannex     5009"	\
	"ae-2700-4     labannex8    5007"	\
	"ae-2700-5     labannex10   5002"	\
	"allegro       labannex9    5001"	\
	"asw-tools     labannex16   5007"	\
	"avocet        labannex13   5016"	\
	"bach          labannex14   5014"	\
	"barnie        labannex17   5016"	\
	"beaker        labannex14   5012"	\
	"bermuda       labannex11   5001"	\
	"blizzard      conannex     5060"	\
	"blue          labannex12   5004"	\
	"bogon         labannex11   5009"	\
	"bugs          labannex16   5002"	\
	"burlington    labannex12   5010"	\
	"calvin        labannex12   5014"	\
	"capella       conannex     5027"	\
	"caramel       labannex5    5001"	\
	"cedar1        labannex4    5002"	\
	"cedar2        labannex4    5003"	\
	"cedar3        misannex     5032"	\
	"cedar4        misannex     5009"	\
	"cedar5        conannex     5003"	\
	"cedar6        misannex     5040"	\
	"cedar7        console      5050"	\
	"cedar8        labannex4    5007"	\
	"coco          labannex2    5003"	\
	"cpg1          conannex     5048"	\
	"crow          labannex14   5010"	\
	"delrina       labannex14   5015"	\
	"deneb         labannex6    5007"	\
	"dilbert       labannex8    5004"	\
	"dogwood       labannex12   5002"	\
	"donald        labannex12   5008"	\
	"eagle         labannex11   5016"	\
	"elmo          labannex18   5007"	\
	"elrond        labannex14   5013"	\
	"explorer      labannex12   5016"	\
	"fever         labannex12   5007"	\
	"fig           labannex9    5002"	\
	"foiliage      labannex16   5006"	\
	"fotty         labannex7    5002"	\
	"fox           labannex16   5003"	\
	"fred          labannex17   5015"	\
	"garfield      labannex2    5004"	\
	"ginger        labannex17   5002"	\
	"grape         labannex7    5001"	\
	"hal           conannex     5007"	\
	"hawaii        labannex12   5006"	\
	"honda         labannex11   5014"	\
	"hoot          conannex     5013"	\
	"huckle        labannex14   5011"	\
	"hudson        labannex13   5005"	\
	"idli          labannex14   5003"	\
	"ine           conannex     5021"	\
	"integrity     labannex12   5001"	\
	"ipg4          labannex7    5004"	\
	"jade          labannex2    5001"	\
	"jaws          conannex     5055"	\
	"jellyfish     labannex11   5007"	\
	"jete          labannex17   5009"	\
	"jordan        labannex12   5013"	\
	"kalu          labannex12   5011"	\
	"kangaroo      labannex4    5005"	\
	"katrus        labannex5    5008"	\
	"killer        labannex15   5002"	\
	"klink1        labannex16   5004"	\
	"klink_x10     labannex16   5005"	\
	"kong          labannex18   5001"	\
	"lab1          labannex18   5002"	\
	"liberator     labannex11   5005"	\
	"lotus         labannex19   5007"	\
	"luminous      labannex11   5010"	\
	"maltese       labannex5    5005"	\
	"marconi       conannex     5047"	\
	"marvin        labannex16   5010"	\
	"mcos-5v-1     labannex6    5003"	\
	"mcos-5v-2     labannex5    5006"	\
	"mcos-5v-4     labannex6    5001"	\
	"mcos-5v-5     labannex15   5006"	\
	"melrose       labannex11   5013"	\
	"misty         labannex12   5003"	\
	"mohawk        labannex17   5003"	\
	"mp1           conannex     5011"	\
	"mufasa        labannex16   5001"	\
	"neptune       labannex17   5014"	\
	"niagara       labannex14   5006"	\
	"ocean         labannex11   5012"	\
	"octopus       labannex13   5002"	\
	"outback       labannex11   5004"	\
	"ox            labannex15   5001"	\
	"pandora       labannex9    5005"	\
	"parrot        labannex11   5003"	\
	"pc-c80-3      conannex     5014"	\
	"pc-hw15       conannex     5038"	\
	"piano         labannex15   5004"	\
	"pitts         labannex14   5007"	\
	"presto        labannex8    5006"	\
	"ranger        labannex15   5008"	\
	"raptor        labannex11   5011"	\
	"raven         conannex     5053"	\
	"releng-1604-1 misannex     5019"	\
	"releng-1604-2 misannex     5034"	\
	"releng-1675   labannex2    5006"	\
	"releng-5v-1   labannex15   5005"	\
	"releng-5v-3   labannex8    5003"	\
	"robin         conannex     5014"	\
	"saturn3       labannex13   5004"	\
	"sharc-167     conannex     5042"	\
	"sharc-167     labannex12   5009"	\
	"sharc4        labannex9    5003"	\
	"shawmut       labannex5    5003"	\
	"shrapnel      labannex6    5002"	\
	"simpson       labannex2    5002"	\
	"snapple       labannex14   5002"	\
	"snoopy        conannex     5002"	\
	"snoopy1       labannex18   5005"	\
	"sqa167-2      misannex     5036"	\
	"sqa-2700-1    labannex15   5003"	\
	"sqa-2700-2    labannex10   5005"	\
	"sqa-2700-3    labannex15   5013"	\
	"sqa-2700-4    labannex10   5001"	\
	"sqa-2ce       labannex8    5001"	\
	"sqa-50gt-1    labannex10   5004"	\
	"sqa-50gt-2    labannex8    5008"	\
	"sqa-6750-1    labannex18   5009"	\
	"sqa-8vt-2     labannex18   5004"	\
	"sqa-8vt-3     labannex18   5011"	\
	"ssghw         console      5058"	\
	"stap          labannex4    5006"	\
	"stap2         conannex     5001"	\
	"starfish      labannex11   5002"	\
	"stars1        labannex16   5008"	\
	"stars2        labannex16   5009"	\
	"stars3        labannex15   5011"	\
	"stars4        labannex15   5012"	\
	"ste-177-1     labannex15   5009"	\
	"ste-177-2     labannex15   5010"	\
	"ste-20vt-2    labannex18   5003"	\
	"ste-2604-1    labannex8    5002"	\
	"ste-8vt-1     labannex18   5008"	\
	"sterling      labannex11   5015"	\
	"stingray      labannex11   5006"	\
	"straw         labannex14   5001"	\
	"sunra         labannex14   5016"	\
	"symantec      labannex14   5008"	\
	"symantec2     labannex14   5004"	\
	"terra         labannex14   5005"	\
	"testdrive     labannex4    5004"	\
	"thor          labannex5    5002"	\
	"tinman        labannex14   5009"	\
	"titan         conannex     5006"	\
	"tools-1604-1  labannex17   5001"	\
	"tools-5v-1    labannex6    5005"	\
	"tools-5v-2    labannex6    5006"	\
	"venus         conannex     5057"	\
	"villeneuve    labannex13   5003"	\
	"vishnu        labannex11   5008"	\
	"vol           labannex17   5005"	\
	"werewolf      labannex5    5007"	\
	"wilma         labannex6    5008"	\
	"woodman       labannex7    5003"	\
	"wren          misannex     5040"	\
	"xanadu        labannex2    5008"	\
	"yago          labannex5    5002"	\
	"z1173         misannex     5026"	\
	"z1281         labannex4    5006"	\
	"zac           labannex12   5005"	\
	"zeus          labannex2    5007"	\
    )

###############################################################################
function dbTripleForKey()  {
    if [ $# -ne 2 ]
    then
        echo "Internal error in $FUNCNAME() - need key and value"
        exit 1
    fi

    indexLimit=${#dataBase[*]}
    index=0
    while [ $index -lt $indexLimit ]
    do
        triple=( ${dataBase[$index]} )       # Index the database for a triple.
        case "$1" in
        1|2|3)
           if [ ${triple[$[$1 - 1]]} == $2 ]        # Index triple for a field.
           then
#              echo "$triple"
               echo ${dataBase[$index]}
               return 0
           fi;;
        *)
            echo "BOGUS key value specified"
            exit 1;;
        esac

        index=$[$index + 1]
    done
    return 1
}

###############################################################################
function dbTripleForSystem()  {
    if [ $# -ne 1 ]
    then
        echo "Internal error in $FUNCNAME() - must specify system"
        exit 1
    fi

    dbTripleForKey 1 $1
}

###############################################################################
function allSystemNames()  {
    indexLimit=${#dataBase[*]}
    index=0
    while [ $index -lt $indexLimit ]
    do
        triple=( ${dataBase[$index]} )
        echo ${triple[0]}
        index=$[$index + 1]
    done
}

###############################################################################
function allAnnexNames()  {
    indexLimit=${#dataBase[*]}
    index=0
    while [ $index -lt $indexLimit ]
    do
        triple=( ${dataBase[$index]} )
        echo ${triple[1]}
        index=$[$index + 1]
    done
}

###############################################################################
function allPortNumbers()  {
    indexLimit=${#dataBase[*]}
    index=0
    while [ $index -lt $indexLimit ]
    do
        triple=( ${dataBase[$index]} )
        echo ${triple[2]}
        index=$[$index + 1]
    done
}

###############################################################################
function allDataBaseEntries()  {
    indexLimit=${#dataBase[*]}
    index=0
    while [ $index -lt $indexLimit ]
    do
        echo ${dataBase[$index]}
        index=$[$index + 1]
    done
}

###############################################################################
function usage()  {

    echo "Failed:" $@
    echo ""
    echo "Usage:"
    echo "        $myName systemName"
    echo ""

    echo "where systemName specifies some system connected"
    echo "to one of our Annex serial-port concentrators."
    echo "A telnet session specifying the appropriate Annex"
    echo "and port will be spawned if the specified system"
    echo "is found in the list of known systems..."
    echo ""

    allSystemNames | fmt
    exit 1
}

###############################################################################
# True execution actually begins here...
#

if [ $# -eq 1 ]                                       # Number of args correct?
then
    triple=( `dbTripleForSystem $1` ) # Fetch appropriate triple from dataBase.
    if [ $? -eq 0 ]                                   # Found specified system?
    then
        echo     ${triple[*]}                         # Announce what we found.
        telnet   ${triple[1]} ${triple[2]}                # Attempt connection.
        finger @"${triple[1]}"        # Sometimes useful after failed attempts.
        exit 0
    else
        usage "Couldn't find system '$1'"
    fi
else
    usage "exactly one systemName must be specified"
fi

############## SCRIPT bashScriptingExamples

function rzq() { case $# in 0) echo Zero; ;; 1) echo One; ;; 2) echo Two; ;; *) echo Other: $#; ;; esac; }

###############################################################################
# Given the specified hierarchy(s) where RPM files are to be found,
# we populate a dataBase with records for each file, obtained using
# rpm queries.  We then ask rpm to describe its current notion of all
# packages that are actually installed on the machine where
# we're executing, independent of those specified RPM files.  Finally we
# attempt to correlate each package RPM believes is installed with one
# of the entries in our dataBase and report the corresponding RPM file.
###############################################################################
myName=$0

function failed()  {
    echo $myName FAILED: $@
    echo "usage:"
    echo "      $0 -d rpmSearchHierarchy [-d rpmSearchHierarchy]"
    exit 1
}

###############################################################################
# Layout of the dataBase[] triples:
# basicPkgName elaboratedPkgName RPMfileName

declare -a dataBase=("")             # In case anybody doubts this is an array.

###############################################################################
function dbTripleForKey()  {
    if [ $# -ne 2 ]
    then
        failed "Internal error in $FUNCNAME() - need fieldIndex and key"
    fi

    index=0
    while [ $index -lt ${#dataBase[*]} ]          # Until indexLimit reached...
    do
        triple=( ${dataBase[$index]} )       # Index the database for a triple.
        case "$1" in
        1|2|3)
            if [ ${triple[$[$1 - 1]]} = $2 ]        # Index triple for a field.
            then
#               echo "$triple"
                echo ${dataBase[$index]}
                return 0                         # First hit terminates search.
            fi
            ;;
        *)
            failed "$FUNCNAME() - bogus key value specified"
            ;;
        esac

        let index++
    done
    return 1
}

###############################################################################
function tripleForBasicPkgName()  {
    if [ $# -ne 1 ]
    then
        failed "Internal error in $FUNCNAME() - must specify basicPkgName"
    fi

    dbTripleForKey 1 $1                               # Field 1 is basicPkgName
}

###############################################################################
function tripleForElaboratedPkgName()  {
    if [ $# -ne 1 ]
    then
        failed "Internal error in $FUNCNAME() - must specify elaboratedPkgName"
    fi

    dbTripleForKey 2 $1                          # Field 2 is elaboratedPkgName
}

###############################################################################
function tripleForRPMfileName()  {
    if [ $# -ne 1 ]
    then
        failed "Internal error in $FUNCNAME() - must specify RPMfileName"
    fi

    dbTripleForKey 3 $1                                # Field 3 is RPMfileName
}

###############################################################################
function dbCountOfField()  {
    local instances

    if [ $# -ne 2 ]
    then
        failed "Internal error in $FUNCNAME() - need fieldIndex and key"
    fi

    index=0
    instances=0
    while [ $index -lt ${#dataBase[*]} ]
    do
        triple=( ${dataBase[$index]} )       # Index the database for a triple.
        case "$1" in
        1|2|3)
            if [ ${triple[$[$1 - 1]]} = $2 ]        # Index triple for a field.
            then
                let instances++
            fi
            ;;
        *)
            failed "BOGUS key value specified"
            ;;
        esac

        let index++
    done

    echo $instances
    return 0
}

###############################################################################
function dbCountOfBasicPkgName()  {
    dbCountOfField 1 $1                               # Field 1 is basicPkgName
}

###############################################################################
function dbCountOfElaboratedPkgName()  {
    dbCountOfField 2 $1                          # Field 2 is elaboratedPkgName
}

###############################################################################
function dbCountOfRPMfileName()  {
    dbCountOfField 3 $1                                # Field 3 is RPMfileName
}

###############################################################################
function allBasicPkgNames()  {
    index=0
    while [ $index -lt ${#dataBase[*]} ]
    do
        triple=( ${dataBase[$index]} )
        echo ${triple[0]}
        let index++
    done
}

###############################################################################
function allElaboratedPkgNames()  {
    index=0
    while [ $index -lt ${#dataBase[*]} ]
    do
        triple=( ${dataBase[$index]} )
        echo ${triple[1]}
        let index++
    done
}

###############################################################################
function allRPMfileNames()  {
    index=0
    while [ $index -lt ${#dataBase[*]} ]
    do
        triple=( ${dataBase[$index]} )
        echo ${triple[2]}
        let index++
    done
}

###############################################################################
function allDataBaseEntries()  {
    index=0
    while [ $index -lt ${#dataBase[*]} ]
    do
        echo ${dataBase[$index]}
        let index++
    done
}

###############################################################################
function addDBentry()  {
    if [ $# -ne 3 ]
    then
        failed "Internal error - $FUNCNAME() needs basicPkgName elaboratedPkgName RPMfileName "
    fi

    dataBase[${#dataBase[*]}]="$1 $2 $3"
}

###############################################################################
function addDBentryUnique()  {
    local count

    if [ $# -ne 3 ]
    then
        echo "Internal error - $FUNCNAME() needs basicPkgName elaboratedPkgName RPMfileName "
        exit 1
    fi

    count=`dbCountOfBasicPkgName $1`
    if [ $count -ne 0 ]
    then
        echo "MULTIPLE($[$count+1]) instances of basicPkgName $1 in DB"      1>&2
#       return 1
    fi

    count=`dbCountOfElaboratedPkgName $2`
    if [ $count -ne 0 ]
    then
        echo "MULTIPLE($[$count+1]) instances of elaboratedPkgName $2 in DB" 1>&2
#       return 1
    fi

    count=`dbCountOfRPMfileName $3`
    if [ $count -ne 0 ]
    then
        echo "MULTIPLE($[$count+1]) instances of RPMfileName $3 in DB"       1>&2
#       return 1
    fi

    addDBentry "$1" "$2" "$3"
}

###############################################################################
function gatherRPMinfoRootedAt()  {
    local basicPkgName
    local elaboratedPkgName
    local RPMfileName

    if [ $# -ne 1 ]
    then
        echo "Internal error in $FUNCNAME() - need startingDirectory"
        exit 1
    fi

    cd $1 || failed "Can't cd $1"
    for RPMfileName in `find . -type f -name '*.rpm' | sed -e s/..// `
    do
             basicPkgName="`rpm -q --queryformat '%{NAME}'                                         -p $RPMfileName 2>/dev/null`"
        elaboratedPkgName="`rpm -q --queryformat '%{NAME}-%{VERSION}-%{RELEASE}-%{SERIAL}-%{ARCH}' -p $RPMfileName 2>/dev/null`"
        addDBentryUnique $basicPkgName $elaboratedPkgName $RPMfileName

        if [ -n "$showDots" ]                                      # Debugging.
        then
            echo -n .
        fi
        if [ -n "$announcePkgs" ]                                  # Debugging.
        then
            echo $basicPkgName
        fi
    done
}

###############################################################################
# True execution actually begins here...
#

startingDirs=""
dumpDataBase=""
announcePkgs=""
    showDots=""

currentOptArg=""
while :
do
    getopts "d:b3a." currentOptArg

    case "$currentOptArg" in
    '?')                                                # End of supplied args.
        break
        ;;
    b)                                                       # debugging output
        set -x
        ;;
    '.')                                                # Show progress dots...
        showDots="setFromCommandLine"
        ;;
    3)                                                       # Show all triples
        dumpDataBase="setFromCommandLine"
        ;;
    a)                     # Announce simple package names as they're processed
        announcePkgs="setFromCommandLine"
        ;;
    d)
        startingDirs="$startingDirs $OPTARG"
        ;;
    *)
        failed "Unexpected commandline parameter: $currentOptArg"
        ;;
    esac
done

if [ -z "$startingDirs" ]
then
    failed No startingDirs specified
fi

for dir in $startingDirs
do
    gatherRPMinfoRootedAt $dir
done

if [ -n "$dumpDataBase" ]
then
    echo "###################### allDataBaseEntries #####################################"
    allDataBaseEntries
    echo "###############################################################################"
fi

for elaboratedPkgName in `rpm -q -a --queryformat '%{NAME}-%{VERSION}-%{RELEASE}-%{SERIAL}-%{ARCH} ' 2>/dev/null`
do
    if [ -n "$announcePkgs" ]
    then
        echo -n "$elaboratedPkgName     "
    fi

    triple=( `tripleForElaboratedPkgName $elaboratedPkgName` )
    if [ $? -eq 0 ]                      # Found elaboratedPkgName in question?
    then
        echo ${triple[2]}                   # utter corresponding RPM filename.
    else
        echo "Couldn't find RPM file for package $elaboratedPkgName" 1>&2
    fi
done

exit 0

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# ftSSS disk scanning ("scrubbing") script
#
# Notes:
# - At many points in this script we "eval" various strings which are
#   assumed to contain zero or more BASH variable assignment statements,
#   sometimes including multiple (and seemingly contradictory or redundant)
#   assignments to the same variable.  This is intentional; we are taking
#   advantage of the left to right evaluation order and we only care about
#   the last assignment to a given variable.
#
# - The functions defined herein are sometimes executed "in-line" ie.
#   in the same BASH context as the caller, and sometimes executed in
#   subordinate shells (eg. via backquotes) where context is not shared.
#   Therefore, variable assignments and the effects of certain directives
#   like "exit" and "return" may have different (sometimes unexpected)
#   effects.  The general approach is for every function to return a string
#   via stdout as its output and signal success/fail via its return code.
#
# - It's intended that everything emitted via stdout by any function
#   defined herein be "captured" and processed by their callers.
#   The only code emitting anything to this program's stdout (ie. visible
#   to the outside world) should be the main loop.  We use stderr as the
#   notification channel.  XXX_MIKE - this works when invoked "by hand"
#   but RHAT's script infrastructure hoses it up when launched using their
#   /etc/init.d/functions:daemon() so we're currently using stdout...
#
# - Interaction with OSM/ASN is via records written into the COMPLETION_DIR
#   where they are harvested and removed at the OSM plugin's convenience.
#

myName=$0
myPID=$$

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Emit a time/date string in YYYYMMDDHHMMSS format
#
function timeDateString()  {
	date '+%Y%m%d%H%M%S'
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Write script name and an optional message to our debugging channel.
# Use of this channel not necessarily associated with an error condition.
#
function trace()  {
	echo "diskscrub[$$]" "$@" >> /tmp/diskscrub.trace
#	logger -d -t"scrubScan[$myPID]" "$@"
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Write script name and an optional message to stdout.
# Use of this channel not necessarily associated with an error condition.
#
function announce()  {
	echo "$@"
#	logger -d -t"scrubScan[$myPID]" "$@"
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
function warning()  {
#	announce WARNING: $@
	echo WARNING: $@ 1>&2
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
function notice()  {
	announce "NOTICE: $@"
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Terminate main script and all child processes.
#
function suicide()  {
	warning Execution terminated.
	rm -f $PID_FILE
	sleep 1
	kill -1 -"$myPID"
	sleep 1
	kill -9 -"$myPID"
	exit 1 || return 1
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Gripe and die.
#
function fatal()  {
	warning $@
	suicide
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Emit a time/date string in YYYYMMDDHHMMSS format
#
function trapSignals()  {
	trap fatal SIGIO SIGUSR2 SIGSEGV SIGUSR1 SIGKILL SIGFPE \
		SIGBUS SIGABRT SIGTRAP SIGILL SIGQUIT SIGINT SIGHUP
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# updateProgress

function updateProgress()  {
	echo $@ progressTime=`timeDateString` >$PROGRESS_FILE || fatal "Can't update $PROGRESS_FILE"
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# recordCompletion

function recordCompletion()  {
	local now

	if [ -z "$@" -o "$@" = "" ]
	then
		fatal 'NULL completion record?'
	fi
	now=`timeDateString`
#	logger -d -t"scrubScan[$myPID]" "$@ completionTime=$now"
	echo "scrubScan[$myPID]" "$@ completionTime=$now"
	echo "$@ completionTime=$now" > $COMPLETION_DIR/$now || fatal "Can't write completion record in $COMPLETION_DIR/"
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# scrubConfigFor
#
# Extract selected directives corresponding to the specified scrubTarget
# from the CONFIG_FILE and utter them in a format suitable for direct
# execution as BASH variable assignments.
#
function scrubConfigFor()  {
	local configLine

	# These locals assumed to be set via 'eval $configLine'
	local INTERVAL BUFFER_K IGNORE PROGRESS_UPDATE


	test "$#" -ge 1 || fatal "$FUNCNAME - no device specified"

	if ! [ -f "$CONFIG_FILE" ]
	then
		echo ""			     # Config file need not be present.
		return 0
	fi

	if ! configLine="`sed -e 's/#.*$//' <$CONFIG_FILE | grep -e scrubTarget="$1 "`"
	then
		echo ""        # Specified device need not have a config entry.
		return 0
	fi

	configLine=`echo $configLine`                # Collapse multiple lines.
	eval "$configLine"

	echo -n "scrubTarget=$scrubTarget"
	test -n "$IGNORE"          && echo -n " IGNORE=$IGNORE"
	test -n "$BUFFER_K"        && echo -n " BUFFER_K=$BUFFER_K"
	test -n "$INTERVAL"        && echo -n " INTERVAL=$INTERVAL"
	test -n "$PROGRESS_UPDATE" && echo -n " PROGRESS_UPDATE=$PROGRESS_UPDATE"
	echo
	return 0
}



# ##############################################################################
# # Config file for the disk scrubber
# #
# # The main diskscrub script only cares about lines that include an
# # assignment to the "scrubTarget" variable.  Meanwhile, the launcher
# # script only cares about assignments to the DISKSCRUB_OPTIONS variable.
# #
#
# #
# # The disk scrubber should be niced down to a very low priority.
# #
# DISKSCRUB_OPTIONS="+20"
#
#
# # # # # # # # # # # # # # # # # # # # # # # # #
# # NOTES:
# #
# # - Each scrubTarget must be referred to using its UDEV name.
# #
# # - The following settings are processed on a per-target basis and must be
# #   on a line with an assignment to "scrubTarget" or they will be ignored.
# #
# # Example directive usage:
# #
# #scrubTarget=/dev/sda1 INTERVAL=20 BUFFER_K=4096
# #scrubTarget=/dev/sdd2 IGNORE=foo
#
# # # # #
# # Note that *any* definition of IGNORE associated with a given
# # scrubTarget will cause the corresponding device to be ignored.
# #
# #IGNORE=qwerty
#
# # # # #
# # A minimum of INTERVAL seconds will pass between reads from
# # the device being scanned.  Default: INTERVAL=5
# #
# #INTERVAL=5
#
# # # # #
# # We will update the PROGRESS_FILE (used to monitor scanning progress
# # and also to resume on restart) every PROGRESS_UPDATE passes.
# # Default: PROGRESS_UPDATE=30
# #
# #PROGRESS_UPDATE=30
#
# # # # #
# # The scrubTarget will be read in bursts of (BUFFER_K * 1024Kb)
# # Default: BUFFER_K=1024  (ie. 1Mb)
# #
# #BUFFER_K=1024



# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# lastKnownScrubTarget
#
# We attempt to recognize which device (if any) was last mentioned
# in the PROGRESS_FILE, if any.
#
function lastKnownScrubTarget()  {
	local progressLine
	local target

	if ! [ -f "$PROGRESS_FILE" ]
	then
		echo ""
		return 0                            # OK for file to be absent.
	fi

	if ! progressLine="`fgrep -e 'scrubTarget=' $PROGRESS_FILE`"
	then
		echo ""
		return 0                    # We need not find anything useful.
	fi

	progressLine=`echo $progressLine` # Collapse multiple lines.
	target=`unset scrubTarget ; eval $progressLine ; echo $scrubTarget`
	echo "$target"
	return 0
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# deviceAvailable
#
# Indicate whether it's reasonable to expect to be able to read from
# the specified device, based on whether we can read the first Kblock.
#
function deviceAvailable()  {
	local device
	local result


	test "$#" -ge 1 || fatal "usage: $FUNCNAME deviceName"

	device=$1
	if ! [ -b "$device" ]				        # Block device?
	then
		return 1		      # False: device is NOT available.
	fi

	result=`dd bs=1k if=$device of=/dev/null count=1 2>&1`
	result=`echo $result`			     # Collapse multiple lines.
	test "$result" != "1+0 records in 1+0 records out"
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Use "udevinfo -q path" to compute the path to the proper /sys/
# entry that will allow us to extract the count of 512-byte blocks
# for the specified device, and then report that value.
#
function halfKblocksInDevice()  {
	local halfKblocks
	local udevPath


	test "$#" -ge 1 || fatal "usage: $FUNCNAME deviceName"

	if ! udevPath=/sys`udevinfo -q path -n $1`
	then
		warning $FUNCNAME "Can't query UDEV path for $1"
		echo 0                           # Hopefully useless to caller.
		return 1
	fi

	if ! [ -f "$udevPath"/size ]
	then
		warning $FUNCNAME "No /sysfs size entry for $1"
		echo 0                           # Hopefully useless to caller.
		return 1
	fi

	if ! halfKblocks=`cat "$udevPath"/size`
	then
		warning $FUNCNAME "Can't read halfKblock count from $udevPath/size"
		echo 0                           # Hopefully useless to caller.
		return 1
	fi

	echo $halfKblocks
	return 0
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Crunch the output from "mdadm --detail -scan" such that the info
# for each device is directly usable as a line of BASH variable assignments.
# (Function name derived directly from invocation-name-plus-args...)
#
# Example output:
# ARRAY=/dev/md1 RAIDlevel=raid1 deviceCount=2 UUID=882916ea:cc37277e:7283e6d0:32cae0f9 devices=/dev/sda2,/dev/sdd2
# ARRAY=/dev/md2 RAIDlevel=raid1 deviceCount=2 UUID=62a193b5:ddfa55fc:b350ea53:fe57f9db devices=/dev/sda3,/dev/sdd3
# ARRAY=/dev/md0 RAIDlevel=raid1 deviceCount=2 UUID=af480699:428ccef0:fececc75:bf64cb05 devices=/dev/sda1,/dev/sdd1
#
function mdadmDetailScanLines()  {
	mdadm --detail -scan					\
		| tr "[:space:]" " "				\
		| tr -s "[:space:]"				\
		| sed -e 's/$/\
/'								\
		| sed						\
			-e 's/num-devices=/deviceCount=/g'	\
			-e 's/level=/RAIDlevel=/g'		\
			-e 's/ARRAY /\
ARRAY=/g'							\
		| sed -e '/^$/d'
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Crunch the current output from "mdadm --detail -verbose" for the
# specified MD device such that it's directly usable as a lineful of BASH
# variable assignments.  Some duplicate items that are also provided by
# mdadmDetailScanLines() are stripped.
# (Function name derived directly from invocation-name-plus-args...)
#
# Example output (single long line wrapped here for readability)
# from invocation of mdadmDetailVerboseAssignments /dev/md0:
#
# version="00.90.01" creationTime="Wed Dec 14 13:38:37 2005"
# arraySizeK="104320 (101.88 MiB 106.82 MB)"
# deviceSizeK="104320 (101.88 MiB 106.82 MB)"
# deviceTotal="2" preferredMinor="0" persistence="Superblock is persistent"
# updateTime="Thu Jan 19 04:03:15 2006" state="clean" activeDeviceCount="2"
# workingDeviceCount="2" failedDeviceCount="0" spareDeviceCount="0"
# NMMDSinfo="0 8 1 0 active sync /dev/sda1 1 8 17 1 active sync /dev/sdd1"
# events="0.137"
#
function mdadmDetailVerboseAssignments()  {
	local ARRAY
	test "$#" -ge 1 || fatal "usage: $FUNCNAME deviceName"

	ARRAY=$1
	mdadm --detail --verbose $ARRAY					\
	| sed 								\
	-e 's;^'"$ARRAY"':;ARRAY='"$ARRAY"';' 				\
	-e 's/^/ /' 							\
	-e 's/[	 ][	 ]*/ /g' 					\
	-e 's/ $//' 							\
	-e '/ : / { s/$/"/ ; s/ : /="/ }' 				\
	-e 's/Active Devices/activeDeviceCount/' 			\
	-e 's/Array Size/arraySizeK/' 					\
	-e 's/Creation Time/creationTime/' 				\
	-e 's/Device Size/deviceSizeK/' 				\
	-e 's/Events=/events=/'						\
	-e 's/Failed Devices/failedDeviceCount/' 			\
	-e 's/Persistence=/persistence=/' 				\
	-e 's/Preferred Minor/preferredMinor/' 				\
	-e 's/Raid Devices/deviceCount/' 				\
	-e 's/Raid Level/RAIDlevel/' 					\
	-e 's/Spare Devices/spareDeviceCount/'          		\
	-e 's/State=/state=/' 						\
	-e 's/Total Devices/deviceTotal/' 				\
	-e 's/Update Time/updateTime/' 					\
	-e 's/Version=/version=/' 					\
	-e 's/Working Devices/workingDeviceCount/'			\
	| fgrep -v							\
	-e "ARRAY=" -e "deviceCount=" -e "RAIDlevel=" -e "UUID="	\
	| tr "[:space:]" " "						\
	| tr -s "[:space:]"						\
	| sed -e 's/^ //'						\
	-e 's/Number Major Minor RaidDevice State \(.*\) events=/NMMDSinfo="\1" events=/' \
	-e 's/$/\
/'
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# latestIntentions
#
# Gather the latest output from mdadmDetailScanLines and augment each line
# with info from mdadmDetailVerboseAssignments (plus relevant directives,
# if any, from the config file, if any) and utter each such augmented line
# such that it's useful in the Intentions List.
#
# A (long) example output line, wrapped here for readability:
#
# scrubTarget=/dev/sdd1 ARRAY=/dev/md0 RAIDlevel=raid1 deviceCount=2
# UUID=af480699:428ccef0:fececc75:bf64cb05 devices=/dev/sda1,/dev/sdd1
# version="00.90.01" creationTime="Wed Dec 14 13:38:37 2005"
# arraySizeK="104320 (101.88 MiB 106.82 MB)"
# deviceSizeK="104320 (101.88 MiB 106.82 MB)"
# deviceTotal="2" preferredMinor="0" persistence="Superblock is persistent"
# updateTime="Fri Jan 27 04:04:14 2006" state="clean" activeDeviceCount="2"
# workingDeviceCount="2" failedDeviceCount="0" spareDeviceCount="0"
# NMMDSinfo="0 8 1 0 active sync /dev/sda1 1 8 17 1 active sync /dev/sdd1"
# events="0.165" halfKblocksInDevice=208782
# intentionCreationTime=20060127105345 scrubTarget=/dev/sdd1
# BUFFER_K=1024 INTERVAL=5 PROGRESS_UPDATE=30
#
function latestIntentions()  {
	local config
	local mdadmDSline
	local mdadmDVAline
	local scrubTarget
	local timeStamp

	# These assumed to be set via 'eval $mdadmDSline/$mdadmDVAline'
	local activeDeviceCount ARRAY             arraySizeK
	local BUFFER_K          creationTime      deviceCount
	local devices           deviceSizeK       deviceTotal
	local events            failedDeviceCount IGNORE
	local INTERVAL          NMMDSinfo         persistence
	local preferredMinor    PROGRESS_UPDATE   RAIDlevel
	local spareDeviceCount  state             updateTime
	local UUID              version           workingDeviceCount


	timeStamp=`timeDateString`

	mdadmDetailScanLines | while read mdadmDSline
	do
		unset activeDeviceCount ARRAY             arraySizeK
		unset BUFFER_K          creationTime      deviceCount
		unset devices           deviceSizeK       deviceTotal
		unset events            failedDeviceCount IGNORE
		unset INTERVAL          NMMDSinfo         persistence
		unset preferredMinor    PROGRESS_UPDATE   RAIDlevel
		unset spareDeviceCount  state             updateTime
		unset UUID              version           workingDeviceCount

		eval "$mdadmDSline"

		if [ -z "$ARRAY" ]
		then
			warning $FUNCNAME: "mdadmDetailScanLines defined no ARRAY in <$mdadmDSline> ??"
			continue
		fi

		mdadmDVAline="`mdadmDetailVerboseAssignments $ARRAY`"
		eval "$mdadmDVAline"                 # Collapse multiple lines.

		if [ -z "$RAIDlevel" ]
		then
			warning $FUNCNAME: "RAIDlevel undefined in <$mdadmDVAline> ??"
			continue
		fi

		if [ "$RAIDlevel" != "raid1" ]
		then
			continue       # We'll only scan components of a Raid1.
		fi

		if [ -z "$devices" ]
		then
			warning $FUNCNAME: "no scrubTargets defined in <$mdadmDVAline> ??"
			continue
		fi

		for scrubTarget in `echo $devices | tr "," ' '`
		do
			if ! echo "$NMMDSinfo" | fgrep -q -e " $scrubTarget"
			then
				warning $FUNCNAME: scrubTarget $scrubTarget not mentioned in mdadm output'?'
				continue
			fi
			if ! halfKblocksInDevice=`halfKblocksInDevice $scrubTarget`
			then
				warning $FUNCNAME: "Can't compute halfKblocksInDevice for $scrubTarget"
				continue
			fi

			config=`scrubConfigFor $scrubTarget`

			#
			# Actual output lines generated here:
			#
			echo "scrubTarget=$scrubTarget \
$mdadmDSline \
$mdadmDVAline \
halfKblocksInDevice=$halfKblocksInDevice \
intentionCreationTime=$timeStamp \
$config"
			echo		# A blank line for (ha!) readability...
		done
	done
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# scrub
#
# Scan the specified device.  Invocation parameters assumed
# to be one of the lines from the intentions file.
#
# Any exit from this function will set the return code to indicate
# success/failure and utter the original intentions along with
# additional info indicating the outcome.
#
function scrub()  {
	local currentOffset KblocksLeft KblocksRead
	local percent       progress    result
	local skip          timeLast    timeStarted

	# These locals assumed to be set via 'eval $@'
	local activeDeviceCount ARRAY                 arraySizeK
	local BUFFER_K          creationTime          deviceCount
	local devices           deviceSizeK           deviceTotal
	local events            failedDeviceCount     halfKblocksInDevice
	local IGNORE            intentionCreationTime INTERVAL
	local NMMDSinfo         persistence           preferredMinor
	local PROGRESS_UPDATE   RAIDlevel             scrubTarget
	local spareDeviceCount  state                 updateTime
	local UUID              version               workingDeviceCount


	INTERVAL=$DEFAULT_INTERVAL
	BUFFER_K=$DEFAULT_BUFFER_K
	PROGRESS_UPDATE=$DEFAULT_PROGRESS_UPDATE
	KblocksRead=0
	percent=0
	skip=0
	currentOffset=0

	eval $@

	timeStarted=`timeDateString`

	trapSignals
#	notice "$@"

	if [ -n "$IGNORE" ]
	then
		warning $FUNCNAME: Configured to IGNORE scrubTarget $scrubTarget.
		echo $@ KblocksRead=0 timeStarted=$timeStarted percentDone=0 completion=ignored
		return 0                                 # Counts as a Success.
	fi

	progress=$PROGRESS_UPDATE
	deviceSizeK=$[$halfKblocksInDevice / 2] # Re-use.
	KblocksLeft=$deviceSizeK

	# First process as many BUFFER_K-sized chunks as we can...

	while [ $KblocksLeft -ge $BUFFER_K ]
	do
		result=`dd bs="$BUFFER_K"k if=$scrubTarget of=/dev/null count=1 skip=$skip 2>&1`
		result=`echo $result`                # Collapse multiple lines.
		if [ "$result" != "1+0 records in 1+0 records out" ]
		then
			warning Read Error for dd bs="$BUFFER_K"k if=$scrubTarget of=/dev/null count=1 skip=$skip
			if deviceAvailable $scrubTarget
			then
				echo $@ KblocksRead=$KblocksRead timeStarted=$timeStarted percentDone=$percent completion=readError
				return 1		 # Failure.
			else
				warning Device $scrubTarget no longer available'?'
				echo $@ KblocksRead=$KblocksRead timeStarted=$timeStarted percentDone=$percent completion=deviceNotAvailable
				return 0		 # Counts as a Success.
			fi
		fi
		let skip++
		let currentOffset+=$[$BUFFER_K * 1024]
		let KblocksLeft-=$BUFFER_K
		let KblocksRead+=$BUFFER_K

		percent=$[ ( $KblocksRead * 100 ) / ( ( $halfKblocksInDevice + 2 ) / 2 ) ]
		test $progress -gt 0 && let progress--
		if [ $progress -eq 0 ]
		then
			updateProgress $@ KblocksRead=$KblocksRead timeStarted=$timeStarted percentDone=$percent
			progress=$PROGRESS_UPDATE
		fi
		test $INTERVAL -gt 0 && sleep $INTERVAL
	done

	# OK - we've processed all the BUFFER_K-sized chunks,
	# so we now nibble away at the what's left, 1k at a time...

	while [ $KblocksLeft -gt 0 ]
	do
		result=`dd bs=1k if=$scrubTarget of=/dev/null count=1 skip=$KblocksRead 2>&1`
		result=`echo $result`		     # Collapse multiple lines.
		if [ "$result" != "1+0 records in 1+0 records out" ]
		then
			warning Read Error for dd bs=1k if=$scrubTarget of=/dev/null count=1 skip=$KblocksRead
			if deviceAvailable $scrubTarget
			then
				echo $@ KblocksRead=$KblocksRead timeStarted=$timeStarted percentDone=$percent completion=readError
				return 1		 # Failure.
			else
				warning Device $scrubTarget no longer available'?'
				echo $@ KblocksRead=$KblocksRead timeStarted=$timeStarted percentDone=$percent completion=deviceNotAvailable
				return 0		 # Counts as a Success.
			fi
		fi
		let currentOffset+=1024
		let KblocksRead++
		let KblocksLeft--
	done

	if [ $progress -ge 0 ]
	then
		updateProgress $@ KblocksRead=$KblocksRead timeStarted=$timeStarted percentDone=100 completion=success
	fi

	echo $@ KblocksRead=$KblocksRead timeStarted=$timeStarted percentDone=100 completion=success
	return 0	# Success.
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Functions now defined - init some variables and commence execution...
#

 SCRUB_HOME_DIR=/opt/ft/diskscrub
 COMPLETION_DIR=$SCRUB_HOME_DIR/diskscrub.completion
    CONFIG_FILE=/etc/opt/ft/diskscrub.conf
  PROGRESS_FILE=$SCRUB_HOME_DIR/diskscrub.progress
INTENTIONS_FILE=$SCRUB_HOME_DIR/diskscrub.intentions
       PID_FILE=/var/run/diskscrub.pid
   MINIMUM_NICE=15

# # # #
# The device being scanned will be read in bursts into a
# buffer whose size is 1024 * DEFAULT_BUFFER_K
#
DEFAULT_BUFFER_K=1024

# # # #
# A minimum of INTERVAL seconds will pass between
# reads from the device being scanned.
#
DEFAULT_INTERVAL=5

# # # #
# We will update the PROGRESS_FILE (used to resume on restart)
# every PROGRESS_UPDATE passes.  Set negative to disable.
#
DEFAULT_PROGRESS_UPDATE=30

test `nice` -gt $MINIMUM_NICE || fatal "MINIMUM_NICE is $MINIMUM_NICE"
cd $SCRUB_HOME_DIR            || fatal "Can't cd $SCRUB_HOME_DIR"
mkdir -p $COMPLETION_DIR      || fatal "$COMPLETION_DIR inaccessible"

resumeTarget=`lastKnownScrubTarget`         # Only considered during first pass.

function main()  {
	echo $$ >>$PID_FILE || fatal "Can't write $PID_FILE"
	trapSignals
	while :
	do
		latestIntentions >$INTENTIONS_FILE || fatal "Couldn't write $INTENTIONS_FILE"

		fgrep -e 'scrubTarget=' $INTENTIONS_FILE | while read intention
		do
			if [ -n "$resumeTarget" ]
			then
				thisTarget=`unset scrubTarget ; eval "$intention" ; echo $scrubTarget`
				test "$resumeTarget" = "$thisTarget" || continue
				notice RESUMING with scrubTarget=$thisTarget
			fi

			recordCompletion "`scrub "$intention"`"
		done

		if [ -n "$resumeTarget" ]
		then                         # ...after first pass, regardless.
			unset resumeTarget
		else            # Allow system to settle, RAIDs to rebuild, etc
			sleep 300
		fi
	done

	fatal "Unexpected exit from main loop."     # Theoretically impossible.
}

trapSignals

ls -laF /proc/$$/fd/2

main &                                                            # daemonize()

exit 0


echo "#### PROBLEM - this script needs work...  $0 $@"

exit 1

  set -x

function cleanupTempFiles()  {
    rm -f $pathList $dirList $anchored $unanchored
    exit
}

trap cleanupTempFiles EXIT

if [ $# -lt 1 ]
then
        echo Usage:
        echo "        $0 objectFile_to_extract_fileList_from"
        exit 1
fi

  pathList=`mktemp /tmp/pathList.XXXXXXXX`   || { echo FAILED mktemp /tmp/pathList.XXXXXXXX   ; exit 1 ; }
   dirList=`mktemp /tmp/dirList.XXXXXXXX`    || { echo FAILED mktemp /tmp/dirList.XXXXXXXX    ; exit 1 ; }
  anchored=`mktemp /tmp/anchored.XXXXXXXX`   || { echo FAILED mktemp /tmp/anchored.XXXXXXXX   ; exit 1 ; }
unanchored=`mktemp /tmp/unanchored.XXXXXXXX` || { echo FAILED mktemp /tmp/unanchored.XXXXXXXX ; exit 1 ; }


# Gather a list of all files mentioned in the object file in question.
# We attempt to "canonicalize" every name in the list...
#
objdump -s -G $1 \
        | fgrep -e ' BINCL ' -e ' EXCL ' -e ' SO ' -e ' SOL ' \
        | sed -r -e 's/[[:space:]]+$//' -e 's/^.*[[:space:]]//' \
        | sort -fd \
        | uniq \
        | canonicalPath \
        | sort -fd \
        | uniq > $pathList

cat /dev/null > $dirList
cat /dev/null > $anchored
cat /dev/null > $unanchored

# For every pathname mentioned in that list...
#
while read f
do
        if [ -f "${f}" ]             # If we can immediately ID it as a file...
        then
                echo "${f}" >> $anchored
        elif [ -d "${f}" ]      # If we can immediately ID it as a directory...
        then
                echo "${f}" >> $dirList
        else
                echo "${f}" >> $unanchored    # ...hope we can anchor it later.
        fi
done < $pathList

while read f            # for every unanchored file mentioned in the objdump...
do
    hit=0
    while read d              # for every directory mentioned in the objdump...
    do
        if [ -f "${d}"/"${f}" ]
        then
            echo "${d}"/"${f}" >> $anchored
            let hit++
        fi
    done < $dirList

    if [ $hit -eq 0 ]
    then
        if [ "${f}" != "0" ]       # Special case: Ignore objdump output quirk.
        then
            echo "######### Can't find ${f}"
        fi
    fi
done < $unanchored

canonicalPath < $anchored | sort -u                         # ...one last time.

# cleanupTempFiles # Handled via the trap

#
# A system-speed-dependent delay function
#

echo "############" INCOMPLETE - $0 $@
exit 1

timeStamp=`date '+%Y%m%d%H%M%S'`
 tempFile=/tmp/tempFile$timeStamp$$


function countDownFrom() {
    timeLeft=$@
    while [ $timeLeft -gt 0 ]
    do
        timeLeft=$[$timeLeft - 1]
    done
}

function sayAfterDelay()  {
    countDownFrom $1
    echo -ne "$2"
}

function countUntilSig14() {
    count=0
    trap 'echo $count >$tempFile ; break ' 14
    while :
    do
        count=$[$count + 1]
    done
}

function rangeFor10seconds()  {
    >$tempFile
    countUntilSig14 &
    sleep 10
    kill -14 $!
    wait
    cat $tempFile
}


echo tempFile $tempFile
echo Starting rangeFor10seconds

rangeFor10seconds

exit 0

count=$1

read stop  junk </proc/uptime
read start junk </proc/uptime

countDownFrom $count

read stop  junk </proc/uptime

echo start is $start
echo stop  is $stop

echo "( $stop - $start ) / $count" | math


#!/bin/bash
# Version=20100401 MD5=2a7ffa4f7b1976752c9188869898867f
#
# Copyright (c)2009 WSI Corp. 20090417
#
# Compare two files (File1 and File2, assumed to be zone info descriptions)
# and generate resultFile which will be File1 without any of the zones that
# are mentioned in File2, ie. it will only have zones unique to File1.
# NOTE: We have seen that zone files sometimes contain "clone-zones" -
#       that is, multiple definitions of exactly the same zone.
#       This script does nothing about that...
#
#####################################################################modonnell#

test -n "$MIKE_DEBUG" && set -x

myName=$(basename $0)

###############################################################################
#
function exitHandler()  {
    if [ -n "$MIKE_DEBUG" ] ; then
        echo Leaving TEMP files behind for debug: $tempFile1 $tempFile2
    else
        rm -f $tempFile1 $tempFile2
    fi
}

trap exitHandler EXIT

###############################################################################
#
function FAIL()  {
    echo $myName FAILED: $@
    echo "Usage:"
    echo "      $myName File1 File2 resultFile"
    echo "      resultFile will be zones from File1 that are not present in File2"
    echo "      File1 and File2 will not be modified."
    echo "Example:"
    echo "      $myName someFireFile someWeatherFile newFireFile"
    exit 1
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Functions defined - commence execution...
#
if [ $# -ne 3 ] ; then
    FAIL wrong number of commandline parameters
fi

launch="`date`"
file1=$1
file2=$2
file3=$3

test -e $file3                            && FAIL File $file3 already exists
test -r $file1                            || FAIL File $file1 unreadable
test -r $file2                            || FAIL File $file2 unreadable
tempFile1=`mktemp /tmp/zoneName.XXXXXXXX` || FAIL mktemp1 /tmp/zoneName.XXXXXXXX
tempFile2=`mktemp /tmp/zoneName.XXXXXXXX` || FAIL mktemp2 /tmp/zoneName.XXXXXXXX

# Assemble a list of strings identifying the unique zones.
# Don't be fooled by duplicate zones in file1.
#
zT=0 # zonesTotal
zU=0 # zonesUnique

echo "############## Collecting zone tags unique to $file1..."
while read tag ; do
    let zT++
    if ! fgrep -q -e "${tag}" $file2 ; then
        let zU++
        echo "${tag}"
        echo "${tag}" >> $tempFile1                  # Accumulate target lines.
    fi
done < <(grep -e '"' $file1 | sort -bfd | uniq)      # Duplicates filtered out.

set -e                                                  # Now errors are fatal.

# Convert zone tags into sed commands that capture the region
# from the specified zone tag to the END directive.
# ASSUME: no characters in the zone tags qualify as regular expression
#         metacharacters except the slashes, which we escape here.
#
echo "############## Converting zone tags to sed expressions..."
sed -e 's/\//\\\//g' -e 's/^/\/^/' -e 's/$/$\/,\/^END$\/p/' < $tempFile1 > $tempFile2
sort -bfd --key=2 < $tempFile2 > $tempFile1

# Turn sed loose on the zone file, controlled by the script file $tempFile1
# NOTE: If this ever fails because there are too many expressions in
#       the sed script file, that script file can be split into smaller
#       pieces and then each one fed to sed with the results concatenated.
#
echo "############## Generating $file3 from $file1 using sed (be patient)..."
sed -n -f $tempFile1 < $file1 > $file3

echo "LAUNCH -> FINISH:  $launch -> `date`"
echo "RESULTS: ${file3} is ${file1} with $zU unique zones out of $zT"
ls -laCFl $file1 $file2 $file3

EndOfShellSkell
