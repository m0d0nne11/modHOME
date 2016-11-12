 export ARCH=`arch`
#. $HOME/.bashrc
#export TERM=xterm
 export HOSTNAME=`uname -n`
#stty intr ^c erase '^h' echoe tabs tab0
 stty intr ^c erase '^?' echoe tabs tab0
#ulimit -c 0 -d 65536

#. $HOME/.bashrc
#export TERM=xterm
#export HOSTNAME=`uname -n`
##export SYSNAME=`fs sysname | sed -e 's/Current sysname is //' -e "s/'//g"`
## params accepted by both OSF/1 and HP/ux versions of stty:
#stty	dsusp ^-	eof ^D		erase ^H	intr ^C		\
#	kill ^U		quit ^\\	start ^Q	stop ^S		\
#	susp ^Z								\
#	brkint		-clocal		cread		cs7		\
#	-cstopb		echo		echoe		-echok		\
#	-echonl		hupcl		icanon		icrnl		\
#	iexten		-ignbrk		-igncr		-ignpar		\
#	-inlcr		-inpck		isig		-istrip		\
#	-iuclc		ixany		-ixoff		ixon		\
#	-noflsh		-ocrnl		-ofdel		-ofill		\
#	-olcuc		onlcr		-onlret		-onocr		\
#	opost		parenb		-parmrk		-parodd		\
#	tab0		tabs		-tostop		-xcase
## Dainbramaged HP/ux versions of stty complain about these: (too bad...)
## params accepted only by OSF/1 version of stty:
#if [ `uname` = "OSF1" ] ; then
#stty	lnext ^V	werase ^W	reprint ^R	discard ^O	\
#	-altwerase	-crtscts	echoctl		echoke		\
#	-echoprt	imaxbel		-mdmbuf		-nohang		\
#	-nokerninfo	-onoeot
#fi
#

