#!/bin/bash

# Process cut'n'pasted data (scraped from Firefox as generated
# by the IEM report generator using my Needs-Patch-Management
# filter) such that it's (slightly more) readable by humans...
# m0d0nne11@mitll 20160725


cat <<"EOF"
d2jj!}sort -bfd --key=2
k!}awk '{ printf( "\%-26s \%-18s \%-17s \%-15s \%-16s \%-14s \%-17s \%-14s \%-16s \%-9s\n", $1, $2, $3, $4, $5, $6, $7, $8, $9, $10 ); } '
]
EOF

sed -E                                                                \
        -e 's/^Computer Name.*$/Hostname/g'                           \
        -e 's/^ll_emailAddr.*$/emailAddr/g'                           \
        -e 's/^ll_roomNum.*$/room/g'                                  \
        -e 's/^NULL in LLAppService.*$/-/'                            \
        -e 's/^ID$/IEMrecord/'                                        \
        -e 's/^Not In IEM.*$/-/'                                      \
        -e 's/^ll_propertyNum.*$/Ptrack/g'                            \
        -e 's/^ll_plateID.*$/plate/g'                                 \
        -e 's/^ll_lastOnlineTime.*$/lastOnline/g'                     \
        -e 's/^ll_jackID.*$/jack/g'                                   \
        -e 's/^ll_macAddr.*$/MACaddr/g'                               \
        -e 's/^IP Address.*$/IPaddr/g'                                \
        -e 's/\[\+]/ /g'                                              \
        -e 's/\@.*$//'                                                \
        -e 's/Last Report Time/lastReport/g'                          \
        -e 's;^(..)/(..)/(....), (..):(..):(..) (.M);\3\1\2\4\5\6\7;' \
        -e 's;^(..)/(..)/(....), (.):(..):(..) (.M);\3\1\20\4\5\6\7;' \
        -e 's;^(..)/(.)/(....), (..):(..):(..) (.M);\3\10\2\4\5\6\7;' \
        -e 's;^(..)/(.)/(....), (.):(..):(..) (.M);\3\10\20\4\5\6\7;' \
        -e 's;^(.)/(..)/(....), (..):(..):(..) (.M);\30\1\2\4\5\6\7;' \
        -e 's;^(.)/(..)/(....), (.):(..):(..) (.M);\30\1\20\4\5\6\7;' \
        -e 's;^(.)/(.)/(....), (..):(..):(..) (.M);\30\10\2\4\5\6\7;' \
        -e 's;^(.)/(.)/(....), (.):(..):(..) (.M);\30\10\20\4\5\6\7;' \
        -e 's/^(....)-(..)-(..) (..):(..):(..)/\1\2\3\4\5\6/'         \
        -e 's/^(..)-(..)-(..)-(..)-(..)-(..)/\1:\2:\3:\4:\5:\6/'      \
        -e 's/^Linux Ubuntu.*12.04.*LTS.* /Ubuntu12.04 /'             \
        -e 's/^Linux Ubuntu.*14.04.*LTS.* /Ubuntu14.04 /'             \
        -e 's/^Linux Ubuntu.*14.10.* /Ubuntu14.10 /'                  \
        -e 's/^Linux CentOS.6.* /CentOS6/'                            \
        -e 's/^Linux CentOS.7.* /CentOS7/'                            \
        -e 's/^Linux Red.*Hat.*6\.5.*$/RHEL6/'                        \
        -e 's/^Linux Red.*Hat.*6\.7.*$/RHEL6/'                        \
  | tr ' ' Z                                                          \
  | paste - - - - - - - - - - - - - - - - - - - - - - -               \
  | sed -E -e 's/[[:space:]]+/ /g' -e 's/[[:space:]]+$//g'            \
  | sed -E                                                            \
        -e 's/.llan.ll.mit.edu/ /'                                    \
        -e 's/ZZ*/Z/g'                                                \
        -e 's/ Z*/ /g'                                                \
        -e 's/Z */Z/g'                                                \
        -e 's/\(.*)//'                                                \
        -e 's/Z/ /g'                                                  \
  | awk '{ printf( "%s %s/%s/%s %s %s %s %s %s %s %s %s\n", $1, $3, $5, $7, $8, $9, $4, $10, $2, $6, $11, $12 ); } ' \
  | lineup


exit

# Example of raw data from cut-buffer:

Computer Name
	
ll_emailAddr
	
ll_roomNum
	
ll_propertyNum
	
ll_plateID
	
ll_lastOnlineTime
	
ll_jackID
	
ll_macAddr
	
IP Address
	
OS
	
Last Report Time
	
ID
div6-vm-om.llan.ll.mit.edu
	
NULL in LLAppService
	
NULL in LLAppService
	
999
	
NULL in LLAppService
	
2016-10-15 18:05:05
	
NULL in LLAppService
	
00-50-56-AA-21-05
	
155.34.66.51
	
Linux CentOS 6.5 (2.6.32-431.29.2.el6.x86_64)
	
10/17/2016, 6:46:10 AM
	
6426677
hcbair4
	
tgibbons@ll.mit.edu
	
B3-389
	
528063
	
B3A-065
	
2016-05-21 18:05:05
	
BR
	
EC-F4-BB-E8-29-C0
	
172.25.175.23
	
Linux Ubuntu 14.04.2 LTS (3.16.0-30-generic)
	
10/14/2016, 4:45:47 PM
	
4903697
mmacera-ws1.llan.ll.mit.edu
	
MMACERA@LL.MIT.EDU
	
B3-350A
	
512305
	
B3A-167
	
2016-10-15 18:05:05
	
BR
	
34-17-EB-BC-77-1B
	
[+] 172.25.59.37
	
Linux Red Hat Enterprise Workstation 6.7 (2.6.32-573.18.1.el6.x86_64)
	
10/17/2016, 6:51:47 AM
	
5121175

Computer Name
	
ll_emailAddr
	
ll_roomNum
	
ll_propertyNum
	
ll_plateID
	
ll_lastOnlineTime
	
ll_jackID
	
ll_macAddr
	
IP Address
	
OS
	
Last Report Time
	
ID
c2e-dev-vm
	
NULL in LLAppService
	
B3-377
	
511678-VM
	
B3A-051
	
2016-05-17 14:06:20
	
BL
	
00-50-56-28-01-29
	
172.25.58.110
	
Linux Ubuntu 14.04.4 LTS (4.2.0-36-generic)
	
5/20/2016, 10:03:24 AM
	
6230102
c2edemo2
	
bcheng@ll.mit.edu
	
B3-370
	
471239
	
B3A-084
	
2016-08-06 18:05:05
	
BR
	
00-21-70-F7-39-BE
	
172.25.57.115
	
Linux Ubuntu 12.04.5 LTS (3.11.0-26-generic)
	
8/15/2016, 8:24:05 AM
	
14576003
div6-vm-om.llan.ll.mit.edu
	
NULL in LLAppService
	
NULL in LLAppService
	
999
	
NULL in LLAppService
	
2016-08-06 18:05:05
	
NULL in LLAppService
	
00-50-56-AA-21-05
	
155.34.66.51
	
Linux CentOS 6.5 (2.6.32-431.29.2.el6.x86_64)
	
8/15/2016, 8:56:30 AM
	
6426677
hcbair4
	
tgibbons@ll.mit.edu
	
B3-389
	
528063
	
B3A-065
	
2016-05-21 18:05:05
	
BR
	
EC-F4-BB-E8-29-C0
	
[+] 172.25.58.22
	
Linux Ubuntu 14.04.2 LTS (3.16.0-30-generic)
	
5/24/2016, 3:39:06 PM
	
4903697
imudev
	
raj@ll.mit.edu
	
NULL in LLAppService
	
494505
	
NULL in LLAppService
	
2015-11-16 18:05:04
	
NULL in LLAppService
	
00-0C-29-BB-5D-7B
	
172.25.58.48
	
Linux Ubuntu Server 12.04.5 LTS (3.2.0-86-generic-pae)
	
6/8/2016, 1:33:59 PM
	
943372
mobuntu
	
NULL in LLAppService
	
B3-384
	
NULL in LLAppService
	
B3A-145
	
2016-06-25 18:05:06
	
BL
	
00-0C-29-90-8C-59
	
172.25.57.15
	
Linux Ubuntu 14.10 (3.16.0-44-generic)
	
7/1/2016, 8:42:58 AM
	
10896901
nagi-centos7
	
nagi@ll.mit.edu
	
B3-389
	
514094
	
B3A-066
	
2016-06-11 18:05:04
	
BR
	
00-0C-29-46-1D-0B
	
[+] 172.25.58.119
	
Linux CentOS 7.2.1511 (3.10.0-327.el7.x86_64)
	
6/15/2016, 1:57:20 PM
	
4824403
nagi-centos7
	
nagi@ll.mit.edu
	
B3-389
	
514094
	
B3A-066
	
2016-06-11 18:05:04
	
BR
	
00-0C-29-46-1D-0B
	
[+] 172.25.58.226
	
Linux CentOS 7.2.1511 (3.10.0-327.el7.x86_64)
	
7/27/2016, 12:09:14 PM
	
11410561
sivaram-centos7
	
nagi@ll.mit.edu
	
B3-389
	
514094
	
B3A-066
	
2016-06-11 18:05:04
	
BR
	
00-0C-29-46-1D-0B
	
[+] 172.25.58.226
	
Linux CentOS 7.2.1511 (3.10.0-327.el7.x86_64)
	
6/15/2016, 2:47:23 PM
	
14408656
SNMP_Radio_Simulator
	
edk@ll.mit.edu
	
B3-384
	
471229
	
B3A-209
	
2016-06-21 18:05:06
	
BR
	
00-21-70-F7-3A-1A
	
172.25.57.139
	
Linux Ubuntu Server 12.04.5 LTS (3.2.0-99-generic-pae)
	
6/23/2016, 11:20:21 AM
	
9543374
StorageOne
	
bhebert@ll.mit.edu
	
5A-315
	
485737
	
5A2-069
	
2016-05-14 18:05:05
	
BL
	
00-25-90-30-B2-6A
	
155.34.61.233
	
Linux Ubuntu 14.04.3 LTS (3.13.0-66-generic)
	
5/15/2016, 8:13:09 PM
	
1185040
ubuntu
	
LOGAN.MERCER@LL.MIT.EDU
	
B3-388
	
511679
	
B3A-071
	
2016-05-14 18:05:05
	
BR
	
00-0C-29-F1-B9-8C
	
172.25.58.149
	
Linux Ubuntu 14.04.3 LTS (3.16.0-46-generic)
	
5/17/2016, 11:35:47 PM
	
9676853
vam
	
shawn@ll.mit.edu
	
C1-162
	
511678
	
C1A-109
	
2016-06-03 17:01:09
	
BL
	
00-0C-29-7E-84-10
	
172.25.175.124
	
Linux Ubuntu 14.04.1 LTS (3.13.0-48-generic)
	
6/6/2016, 4:17:21 PM
	
3996601
vam
	
NULL in LLAppService
	
B3-370
	
999
	
B3A-084
	
2016-05-25 19:18:23
	
BL
	
00-0C-29-CE-C7-A5
	
172.25.175.34
	
Linux Ubuntu 14.04.1 LTS (3.13.0-48-generic)
	
6/3/2016, 1:16:52 PM
	
4514563
vam
	
NULL in LLAppService
	
B3-370
	
999
	
B3A-084
	
2016-05-25 19:18:23
	
BL
	
00-0C-29-CE-C7-A5
	
172.25.175.34
	
Linux Ubuntu 14.04.1 LTS (3.13.0-48-generic)
	
6/1/2016, 4:36:58 PM
	
4871639
vam
	
NULL in LLAppService
	
B3-370
	
999
	
B3A-084
	
2016-05-18 19:47:39
	
BL
	
00-0C-29-CE-C7-A5
	
172.25.57.192
	
Linux Ubuntu 14.04.1 LTS (3.13.0-48-generic)
	
5/31/2016, 5:31:24 PM
	
5856191
vam
	
shawn@ll.mit.edu
	
C1-162
	
511678
	
C1A-109
	
2016-06-03 17:01:09
	
BL
	
00-0C-29-7E-84-10
	
172.25.175.64
	
Linux Ubuntu 14.04.1 LTS (3.13.0-48-generic)
	
7/14/2016, 11:40:23 AM
	
11660609
vam
	
BENJAMIN.HAMILTON@LL.MIT.EDU
	
B3-374
	
494283
	
B3A-161
	
2016-06-18 18:05:05
	
BR
	
00-50-56-36-30-E4
	
172.25.58.115
	
Linux Ubuntu 14.04.4 LTS (3.13.0-86-generic)
	
6/21/2016, 12:53:13 PM
	
12945140
vam
	
NULL in LLAppService
	
B3-370
	
999
	
B3A-084
	
2016-05-18 19:47:39
	
BL
	
00-0C-29-CE-C7-A5
	
172.25.57.158
	
Linux Ubuntu 14.04.1 LTS (3.13.0-48-generic)
	
5/31/2016, 3:40:41 PM
	
14741347
vam-1
	
NULL in LLAppService
	
B3-384
	
NULL in LLAppService
	
B3A-209
	
2016-05-14 18:05:05
	
BR
	
D0-67-E5-33-FD-BD
	
172.25.58.82
	
Linux Ubuntu 12.04.5 LTS (3.8.0-44-generic)
	
5/17/2016, 4:59:05 AM
	
10680124
vam-jtrs
	
ipedan@ll.mit.edu
	
B3-389
	
510818
	
B3A-144
	
2016-01-10 18:05:04
	
BL
	
00-0C-29-5B-A7-F3
	
[+] 172.25.58.236
	
Linux Ubuntu 14.04.2 LTS (3.13.0-37-generic)
	
4/27/2016, 2:33:32 PM
	
2283687
vam-jtrs
	
NULL in LLAppService
	
B3-389
	
NULL in LLAppService
	
B3A-066
	
2016-04-11 18:05:03
	
BR
	
00-0C-29-09-77-D2
	
[+] 172.25.58.200
	
Linux Ubuntu 14.04.2 LTS (3.13.0-37-generic)
	
5/4/2016, 9:32:56 AM
	
8815361
vam-jtrs
	
NULL in LLAppService
	
B3-389
	
NULL in LLAppService
	
B3A-066
	
2016-04-11 18:05:03
	
BR
	
00-0C-29-09-77-D2
	
[+] 172.25.58.101
	
Linux Ubuntu 14.04.2 LTS (3.13.0-37-generic)
	
5/3/2016, 6:01:50 PM
	
14166286
vam-jtrs-om-4-28
	
NULL in LLAppService
	
B3-389
	
NULL in LLAppService
	
B3A-188
	
2016-04-30 17:48:10
	
BR
	
00-0C-29-51-26-39
	
[+] 172.25.58.243
	
Linux Ubuntu 14.04.2 LTS (3.13.0-37-generic)
	
5/2/2016, 7:29:53 AM
	
4293456
vam-jtrs-om_5_03
	
nagi@ll.mit.edu
	
B3-389
	
483867
	
B3A-144
	
2016-06-18 18:05:05
	
BL
	
00-0C-29-89-4E-BC
	
[+] 172.25.58.24
	
Linux Ubuntu 14.04.2 LTS (3.13.0-37-generic)
	
7/21/2016, 4:30:23 PM
	
8632139
5a315-mirror
	
Not In IEM
	
Not In IEM
	
Not In IEM
	
Not In IEM
	
Not In IEM
	
Not In IEM
	
Not In IEM
	
192.168.42.15
	
Linux Ubuntu 14.04.4 LTS (3.13.0-92-generic)
	
8/11/2016, 10:49:38 AM
	
3401277
460710-mitll
	
bhebert@ll.mit.edu
	
B3-389
	
460710
	
B3A-065
	
2016-06-24 15:52:32
	
BR
	
00-1C-23-31-19-6E
	
172.25.58.222
	
Linux Ubuntu 14.04.4 LTS (3.19.0-59-generic)
	
6/28/2016, 12:42:06 PM
	
8174689
471240-mitll
	
bcheng@ll.mit.edu
	
B3-376
	
471240
	
B3A-077
	
2016-06-04 18:04:15
	
BL
	
00-21-70-F7-3A-33
	
[+] 172.25.58.233
	
Linux Ubuntu 14.04.4 LTS (3.19.0-59-generic)
	
6/6/2016, 3:30:14 PM
	
4613135


