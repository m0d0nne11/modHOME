# mkdir /mnt/loop4 ; offset=32256 ; losetup --offset=$offset /dev/loop4 lisaLaptopImage.sda.20100214 ; mount /dev/loop4 /mnt/loop4

test -n "$MIKE_DEBUG" && set -x

function successiveLoopMountAttemptsForImage_func() {
    local image=$1;
    local blockSize=512;
    local offset=0;
    local block=0;
    echo "######" SUCCESSIVE LOOP MOUNT ATTEMPTS FOR $image
    while :; do
        offset=$[$block * $blockSize];
        echo "####" OFFSET $offset ...
        losetup --offset=$offset /dev/loop4 "${image}";
        sleep 1;
        losetup --all
        if mount -t vfat -oro /dev/loop4 /mnt/loop4; then
            echo Mount EXT3 succeeded at offset $offset;
            break;
        fi;
        if mount -t ext3 -oro /dev/loop4 /mnt/loop4; then
            echo Mount EXT3 succeeded at offset $offset;
            break;
        fi;
        if mount -t ext4 -oro /dev/loop4 /mnt/loop4; then
            echo Mount EXT4 succeeded at offset $offset;
            break;
        fi;
        losetup --detach /dev/loop4;
        let block++;
    done;
}

successiveLoopMountAttemptsForImage_func $@

# SYNOPSIS
#        kpartx [-a | -d | -l] [-v] wholedisk
#
# DESCRIPTION
#        This tool, derived from util-linux' partx, reads partition tables on specified device and create device maps over partitions segments detected. It is
#        called from hotplug upon device maps creation and deletion.
#
# OPTIONS
#        -a     Add partition mappings
#
#        -r     Read-only partition mappings
#
#        -d     Delete partition mappings
#
#        -l     List partition mappings that would be added -a
#
#        -p     set device name-partition number delimiter
#
#        -g     force GUID partition table (GPT)
#
#        -v     Operate verbosely
#
# EXAMPLE
#        To mount all the partitions in a raw disk image:
#
#               kpartx -av disk.img
#
#        This will output lines such as:
#
#               loop3p1 : 0 20964762 /dev/loop3 63
#
#        The loop3p1 is the name of a device file under /dev/mapper which you can use to access the partition, for example to fsck it:
#
#               fsck /dev/mapper/loop3p1
#
#        When you're done, you need to remove the devices:
#
#               kpartx -d disk.img
#
# SEE ALSO
#        multipath(8) multipathd(8) hotplug(8)

