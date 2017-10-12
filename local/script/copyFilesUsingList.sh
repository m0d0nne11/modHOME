#!/bin/bash

fileList=$1

# deadline1m=$[$(date '+%s') + 60] ; while [ $(date '+%s') -lt $deadline1m ]; do echo Tick...; sleep 1; done ; echo Ding

            destHost=syseng690a
             destDir=/wxdisk/Digital_Media/Movies_Output_1.0/Custom
#             srcDir=/wxdisk/Digital_Media/Movies_Output_1.0/Custom
              srcDir=/wxdisk/ARCHIVE/XXX_MIKE/xw8600a/Movies_Output_1.0/Custom
PER_CYCLE_BYTE_LIMIT=300000000
   SECONDS_PER_CYCLE=30

###############################################################################
#
function tds()  {
    date '+%Y%m%d%H%M%S'
}

sessionTimestamp=$(tds)$$

function smile()  {
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
}

###############################################################################
# Copy the specified file from a directory on the local disk to a different
# "local" directory that's assumed to be mounted from an NFS server.
# ASSUME: srcDir is on local disk
#
function sendFileNFS()  {
	cp -a "${srcDir}"/"$1" "${destDir}"/"$1".$sessionTimestamp
#	dd if="${srcDir}"/"$1" of="${destDir}"/"$1".$sessionTimestamp bs=8k
	mv                  "${destDir}"/"$1".$sessionTimestamp "${destDir}"/"$1"
}

###############################################################################
#
function sendFileSCP()  {
	scp               "${srcDir}"/"$1" "$destHost":"${destDir}"/"$1"
}

###############################################################################
#
function sendFileRSYNC()  {
	rsync -vax -e ssh "${srcDir}"/"$1" "$destHost":"${destDir}"/"$1"
}

###############################################################################
#
function genHundredMbyteFileLists()  {
	local part=0
	local total=0
	local bytes
	local name
	local output

	output=/tmp/part$(printf "%03d" $part).$sessionTimestamp

	while read bytes file
	do
		echo "${file}" >> $output
		let total+=$bytes
echo $output : "${file}" bytes:$bytes total:$total
		if [ $total -gt 100000000 ]
		then
			total=0
			let part++
			output=/tmp/part$(printf "%03d" $part).$sessionTimestamp
		fi
	done
}

###############################################################################
#

while :
do
    smile
    deadline1m=$[$(date '+%s') + $SECONDS_PER_CYCLE]

    # while [ $(date '+%s') -lt $deadline1m ]; do echo Tick...; sleep 1; done ; echo Ding

    echo

    cat $fileList | while read bytes file
    do
            echo PER-CYCLE: $SECONDS_PER_CYCLE seconds, $PER_CYCLE_BYTE_LIMIT bytes...
            let total+=$bytes
            echo SENDING "${file}" bytes:$bytes total:$total
            sendFileNFS "${file}"
            if [ $total -gt $PER_CYCLE_BYTE_LIMIT ]
            then
                    total=0
                    while [ $(date '+%s') -lt $deadline1m ]
                    do
                            echo Waiting for end of $SECONDS_PER_CYCLE second cycle...
                            sleep 2
                    done
                    deadline1m=$[$(date '+%s') + $SECONDS_PER_CYCLE]
            fi
    done
done

