#!/bin/bash

# Process cut'n'pasted data (scraped from Firefox as generated
# by the NACstat report generator for g65 systems lacking IEM)
# such that it's (slightly more) readable by humans...
# m0d0nne11@mitll 20160801                                           2016-07-29 15:00:54

# lpr -o landscape -o sides=two-sided-long-edge -o cpi=14

cat <<"EOF"
MACvendorFor.sh
yyp!!wordN 7 | tr / ' ' | fmt -1 | fgrep -v -e '-' | email4labID | sort -bfdu | fmt -2400kJj
d2jj!}sort -bfd --key=2
k!}awk '{ printf( "\%-26s \%-18s \%-17s \%-15s \%-16s \%-14s \%-17s \%-14s \%-48s \%-9s \%s\n", $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11 ); } '
]
EOF

tempFile=/tmp/crunchIEMg65badboyTEMP$$

sed -E                                            \
        -e 's/^MAC Addr/MACaddr/'                 \
        -e 's/^Host Registrant/llIDreg/'          \
        -e 's/^System Description/SysDescr/'      \
        -e 's/^NAC Prop#/Ptrack/'                 \
        -e 's/^Host Last Online/lastOnline/'      \
        -e 's/^MAC IP/IPaddr/'                    \
        -e 's/^Faceplate/plate/'                  \
        -e 's/^Room Number/room/'                 \
        -e 's/^Ptrack LLID/llID/'                 \
        -e 's/^IEM Computer ID/iemID/'            \
        -e 's/^IEM Check In Date/lastIEMcheckin/' \
        -e 's/([[:digit:]]{4})-([[:digit:]]{2})-([[:digit:]]{2}) ([[:digit:]]{2}):([[:digit:]]{2}):([[:digit:]]{2})/\1\2\3\4\5\6/' \
  > ${tempFile}

# Gather the contents of all lines beginning with non-whitespace
# (assumed to be column headers) onto a single line.  Follow with
# all lines with leading whitespace, assumed to be table-rows.

cat <(grep -E -e '^[^[:space:]]'             < ${tempFile} | fmt -2400)                               \
    <(grep -E -e '^[[:space:]]+[^[:space:]]' < ${tempFile} | crunchXLS.sh | sed -e 's/^-//' )         \
  | awk '{ printf( "%s %s/%s %s %s %s %s %s/%s %s\n", $2, $10, $9, $1, $8, $6, $4, $12, $3, $7 ); } ' \
  | sed -E                                        \
        -e 's/ Wind[^[:space:]]* / Win7 /g'       \
        -e 's/ Linux-/ /g'                        \
        -e 's/ Mac-OS-X-/ MacOSX/g'               \
  | lineup

rm -f ${tempFile}

exit



1        2        3       4  5        6      7          8      9     10   11    12   13    14
MAC-Addr Hostname llIDreg OS SysDescr Ptrack lastOnline IPaddr plate room Group llID iemID lastIEMcheckin

2  10 9  1  8  6  4  12 3 7  
	

sed -E                                                               \
        -e 's/^Computer Name$/ComputerName/g'                        \
        -e 's/^ll_emailAddr/emailAddr/g'                             \
        -e 's/^ll_roomNum/room/g'                                    \
        -e 's/^NULL in LLAppService/-/'                              \
        -e 's/^Not In IEM/-/'                                        \
        -e 's/^ll_propertyNum/Ptrack/g'                              \
        -e 's/^ll_plateID/plate/g'                                   \
        -e 's/^ll_lastOnlineTime/lastOnline/g'                       \
        -e 's/^ll_jackID/jack/g'                                     \
        -e 's/^ll_macAddr/macAddr/g'                                 \
        -e 's/^IP Address/IPaddress/g'                               \
        -e 's/\[\+]/ /g'                                             \
        -e 's/\@.*$//'                                               \
        -e 's/Last Report Time/lastReport/g'                         \
        -e 's/^(..)-(..)-(..)-(..)-(..)-(..)/\1:\2:\3:\4:\5:\6/'     \
        -e 's/^(....)-(..)-(..) (..):(..):(..)/\1\2\3\4\5\6/'        \
        -e 's;(.)/(.)/(....), (.):(..):(..) (.M);\30\10\20\4\5\6\7;' \
        -e 's;(.)/(.)/(....), (..):(..):(..) (.M);\30\10\2\4\5\6\7;' \
        -e 's;(.)/(..)/(....), (.):(..):(..) (.M);\30\1\20\4\5\6\7;' \
        -e 's;(.)/(..)/(....), (..):(..):(..) (.M);\30\1\2\4\5\6\7;' \
        -e 's;(..)/(.)/(....), (.):(..):(..) (.M);\3\10\20\4\5\6\7;' \
        -e 's;(..)/(.)/(....), (..):(..):(..) (.M);\3\10\2\4\5\6\7;' \
        -e 's;(..)/(..)/(....), (.):(..):(..) (.M);\3\1\20\4\5\6\7;' \
        -e 's;(..)/(..)/(....), (..):(..):(..) (.M);\3\1\2\4\5\6\7;' \
        -e 's/^Linux Ubuntu.*12.04.*LTS.* /Ubuntu12.04 /'            \
        -e 's/^Linux Ubuntu.*14.04.*LTS.* /Ubuntu14.04 /'            \
        -e 's/^Linux Ubuntu.*14.10.* /Ubuntu14.10 /'                 \
        -e 's/^Linux CentOS.6.* /CentOS6/'                           \
        -e 's/^Linux CentOS.7.* /CentOS7/'                           \
  | tr ' ' Z                                                         \
  | paste - - - - - - - - - - - - - - - - - - - - -                  \
  | eat                                                              \
  | sed -E                                                           \
        -e 's/.llan.ll.mit.edu/ /'                                   \
        -e 's/ZZ*/Z/g'                                               \
        -e 's/ Z*/ /g'                                               \
        -e 's/Z */Z/g'                                               \
        -e 's/\(.*)//'                                               \
        -e 's/Z/ /g'                                                 \
  | awk '{ printf( "%s %s/%s/%s %s %s %s %s %s %s %s\n", $1, $3, $5, $7, $8, $9, $4, $10, $2, $6, $11 ); } ' \
  | lineup


1        2        3       4  5        6      7          8      9     10   11    12   13    14
MAC-Addr Hostname llIDreg OS SysDescr Ptrack lastOnline IPaddr plate room Group llID iemID lastIEMcheckin
	
# Next line begins example of raw Cmd-A/Cmd-C data from cut-buffer:

HostsAdapters/NICs/MACs Addresses AllRegisteredUnregistered AllOffline longer thanOnline last HoursDays AllIEM ReportingIEM Not Reporting
 Refresh Enabled   Logout 
Show
entries
Copy
PrintCSV (all)
CSV (visible)
Search all data:
Mon Aug 01 2016 08:00:15 GMT-0400 (EDT)
 
	
MAC Addr
	
Hostname
	
Host Registrant
	
OS
	
System Description
	
NAC Prop#
	
Host Last Online
	
MAC IP
	
Faceplate
	
Room Number
	
Group
	
Ptrack LLID
	
IEM Computer ID
	
IEM Check In Date
														
 
	
MAC Addr
	
Hostname
	
Host Registrant
	
OS
	
System Description
	
NAC Prop#
	
Host Last Online
	
MAC IP
	
Faceplate
	
Room Number
	
Group
	
Ptrack LLID
	
IEM Computer ID
	
IEM Check In Date
	00:25:4B:FD:A8:CA	517907-mitll	AR26635	Mac OS X 10.11.4	Laptop	C02NJ1XJG3QT	2016-08-01 08:00:15				06-65	TH11884		
	00:25:4B:BD:AD:BC	471601-mitll	PAV8760	Mac OS X 10.9.5	Laptop	471601	2016-06-06 13:37:46	172.25.57.38	B3A-145	B3-384	06-65	MI25714		
	C4:ED:BA:A9:A3:47	n3	JE20760	Embedded		518343	2016-06-23 19:02:47	172.25.58.148	B3A-051	B3-377	06-65	BO21143		
	00:24:9B:13:6C:53	521096-MITLL	SC21825	Windows	Laptop	521096	2016-07-05 08:37:04	155.34.66.172	C4A-070	C-435	06-65	SC21825		
	02:98:6E:DE:FA:11		JE20760	Embedded		518343	2016-06-23 19:01:23	172.25.58.215	B3A-051	B3-377	06-65	BO21143		
	0C:C4:7A:AE:4A:65		JO15799	Embedded		530717	2016-06-27 11:55:51	172.25.57.142	B3A-102	B3-350	06-65	MA26173		
	98:5A:EB:CA:4D:75	523822-mitll	TH26238	Mac OS X 10.10.5		C02Q20SZG8WM	2016-07-28 10:57:36	172.25.58.63	B3A-181	B3-390	06-65	TH26238		
	00:0C:29:00:F0:1D		SI26158	Embedded		530558	2016-06-22 09:45:07	172.25.58.12	B3A-144	B3-389	06-65	SI26158		
	00:0C:29:77:0F:9A	localhost	NAV8884	Embedded		514094	2016-06-27 15:24:40	172.25.58.187	B3A-066	B3-389	06-65	NAV8884		
	00:0C:29:0E:E7:EA		SI26158	Embedded		530558	2016-06-27 15:36:28	172.25.58.71	B3A-144	B3-389	06-65	SI26158		
	C0:3F:D5:6E:2C:4C	nuc-13	DE22596	Linux		N/A	2016-07-11 10:52:50	172.25.152.143	F3A-087	F3-335	06-65			
	C0:3F:D5:6E:8E:CB	ubuntu	DE22596	Linux		N/A	2016-07-11 10:44:05	172.25.152.57	F3A-087	F3-335	06-65			
	B8:AE:ED:70:69:F7	ubuntu	DE22596	Linux		N/A	2016-07-11 10:44:05	172.25.152.46	F3A-087	F3-335	06-65			
	B8:AE:ED:70:67:B0	ubuntu	DE22596	Linux		N/A	2016-07-11 10:38:48	172.25.152.128	F3A-087	F3-335	06-65			
	00:25:90:0F:D1:7C						2016-08-01 08:00:15		5A2-069	5A-315	06-65			
	B8:AC:6F:36:42:FC	479118-mitll		Linux Fedora based			2016-07-18 09:59:27	172.29.234.157	B3A-210	B3-355	06-65	JO15799		
	00:21:9B:92:BA:54		BR21223	Embedded		473793	2016-08-01 08:00:15	155.34.61.225	5A2-069	5A-315	06-65	BR21223		
	00:0C:29:82:17:FD	ubuntu		Linux Ubuntu			2016-07-18 14:28:28	172.25.186.44	C4A-066	C-439	06-65			
	00:21:70:F9:42:9D	WM					2016-07-19 08:43:08		B3A-209	B3-384	06-65			
	00:0C:29:86:6F:21	ubuntu	BR25966	Embedded		520968	2016-07-27 10:14:58	172.25.57.63	B3A-080	B3-374	06-65	BR25966		
	00:80:8E:04:15:91	pacecr	RA24903	Embedded		510459	2016-07-22 16:16:34	172.25.79.133	B3A-045	B3-369	06-65	RA24903		
	00:0C:29:11:A5:B0	ubuntu		Linux Ubuntu			2016-07-28 11:58:49		B3A-071	B3-388	06-65			
	00:04:E2:C8:92:BA						2016-07-29 15:00:54		B3A-050	B3-377A	06-65			
	00:04:E2:C8:92:B9						2016-07-29 15:00:54		B3A-050	B3-377A	06-65			
	40:16:7E:64:AC:EA	519413-MITLL	AR17890	Windows 7 Enterprise Service Pack 1	Workstation	519413	2016-06-09 09:55:08	172.29.250.130			06-65	AR17890		
	00:24:9B:0D:D8:EF	blahbalh	PAV8760	Windows 7 Enterprise Service Pack 1			2016-06-14 07:44:25		B3A-085	B3-370	06-65			
	00:50:56:AA:0D:47	VIEW-ISD-MSTR1	KAV9096	Windows 7 Enterprise 6.1 Service Pack 1	VM	999	2016-06-20 10:18:43	155.34.66.218			06-65			
	00:50:56:AA:9C:52	afsfs2	kav9096	RHEL7	VM	999	2016-07-05 20:43:56	155.34.66.99			06-65			
	00:50:56:AA:88:A3	D6-VDI-LC-0005	KAV9096	Windows 7 Enterprise 6.1 Service Pack 1	VM		2016-06-15 08:35:18				06-65			
	00:30:48:F0:BE:ED						2016-07-19 13:59:43		C4A-135	C-434	06-65			
 														
