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

test "$MIKE_DEBUG" = "-x"  && set -x
test "$MIKE_DEBUG" = "-xv" && set -xv

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
	echo $@ progressTime=$(timeDateString) >$PROGRESS_FILE || fatal "Can't update $PROGRESS_FILE"
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# recordCompletion

function recordCompletion()  {
	local now

	if [ -z "$@" -o "$@" = "" ]
	then
		fatal 'NULL completion record?'
	fi
	now=$(timeDateString)
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

	if ! configLine="$(sed -e 's/#.*$//' <$CONFIG_FILE | grep -e scrubTarget="$1 ")"
	then
		echo ""        # Specified device need not have a config entry.
		return 0
	fi

	configLine=$(echo $configLine)                # Collapse multiple lines.
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

	if ! progressLine="$(fgrep -e 'scrubTarget=' $PROGRESS_FILE)"
	then
		echo ""
		return 0                    # We need not find anything useful.
	fi

	progressLine=$(echo $progressLine) # Collapse multiple lines.
	target=$(unset scrubTarget ; eval $progressLine ; echo $scrubTarget)
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

	result=$(dd bs=1k if=$device of=/dev/null count=1 2>&1)
	result=$(echo $result)			     # Collapse multiple lines.
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

	if ! udevPath=/sys$(udevinfo -q path -n $1)
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

	if ! halfKblocks=$(cat "$udevPath"/size)
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


	timeStamp=$(timeDateString)

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

		mdadmDVAline="$(mdadmDetailVerboseAssignments $ARRAY)"
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

		for scrubTarget in $(echo $devices | tr "," ' ')
		do
			if ! echo "$NMMDSinfo" | fgrep -q -e " $scrubTarget"
			then
				warning $FUNCNAME: scrubTarget $scrubTarget not mentioned in mdadm output'?'
				continue
			fi
			if ! halfKblocksInDevice=$(halfKblocksInDevice $scrubTarget)
			then
				warning $FUNCNAME: "Can't compute halfKblocksInDevice for $scrubTarget"
				continue
			fi

			config=$(scrubConfigFor $scrubTarget)

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

	timeStarted=$(timeDateString)

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
		result=$(dd bs="$BUFFER_K"k if=$scrubTarget of=/dev/null count=1 skip=$skip 2>&1)
		result=$(echo $result)                # Collapse multiple lines.
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
		result=$(dd bs=1k if=$scrubTarget of=/dev/null count=1 skip=$KblocksRead 2>&1)
		result=$(echo $result)		     # Collapse multiple lines.
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

#SCRUB_HOME_DIR=/opt/ft/diskscrub
 SCRUB_HOME_DIR=/var/tmp/diskscrub
 COMPLETION_DIR=$SCRUB_HOME_DIR/diskscrub.completion
#   CONFIG_FILE=/etc/opt/ft/diskscrub.conf
    CONFIG_FILE=~/diskscrub.conf
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
# A minimum of DEFAULT_INTERVAL seconds will pass between
# reads from the device being scanned.
#
DEFAULT_INTERVAL=5

# # # #
# We will update the PROGRESS_FILE (used to resume on restart)
# every DEFAULT_PROGRESS_UPDATE passes.  Set negative to disable.
#
DEFAULT_PROGRESS_UPDATE=30

test $(nice) -ge $MINIMUM_NICE || fatal "MINIMUM_NICE is $MINIMUM_NICE"
cd $SCRUB_HOME_DIR            || fatal "Can't cd $SCRUB_HOME_DIR"
mkdir -p $COMPLETION_DIR      || fatal "$COMPLETION_DIR inaccessible"

resumeTarget=$(lastKnownScrubTarget)         # Only considered during first pass.

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
				thisTarget=$(unset scrubTarget ; eval "$intention" ; echo $scrubTarget)
				test "$resumeTarget" = "$thisTarget" || continue
				notice RESUMING with scrubTarget=$thisTarget
			fi

			recordCompletion "$(scrub "$intention")"
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

