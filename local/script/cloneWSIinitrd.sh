# hashBang line disabled to accommodate Termux's nonstandard filesystem layout...
#!/bin/bash
#
# Clone an initrd image by starting with a copy of an existing 
# "example" image and then replacing all modules therein with
# the corresponding version from the /lib/modules/* hierachy for 
# the new version.  It's assumed that the initrd is a gzip'd ext2
# image and that only the modules need to be replaced ie. that the
# scripts and such therein are suitable for use in the new image.
# Used with RHEL3's 2.4 kernels
#

if ! [ $# -eq 2 ]
then
    echo $0 cloneSourceVersion newVersion
    echo EXAMPLE: $0 2.4.21-53.ELsmp 2.4.21-53.ELsmpWSIkgdb
    exit 1
fi

                       x=$1
oldImageName=initrd-"${x}".img
                       y=$2
   imageName=initrd-"${y}".img

set -x
rm -f /tmp/"${oldImageName}" /tmp/"${oldImageName}".gz \
         /tmp/"${imageName}"    /tmp/"${imageName}".gz
mkdir -p         /tmp/loopMount/"${imageName}"
cp /boot/"${oldImageName}" /tmp/"${imageName}".gz
gunzip           /tmp/"${imageName}".gz
mount -oloop     /tmp/"${imageName}" /tmp/loopMount/"${imageName}"
pushd                                /tmp/loopMount/"${imageName}"/lib
cp $(for f in *; do find /lib/modules/"${y}"/ -name $f; done) .
popd
umount /tmp/loopMount/"${imageName}"
gzip             /tmp/"${imageName}"
mv               /tmp/"${imageName}".gz /boot/"${imageName}"
