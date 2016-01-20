#!/bin/sh -e
SNAPPY_VERSION=`date +%Y%m%d`-0
SNAPPY_IMAGE=roseapple-pi-${SNAPPY_VERSION}.img
SNAPPY_CORE_CH=stable
OEM_SNAP=roseapple-pi.woodrow
DEVICE_TAR=${PWD}/device-roseapple-pi_0.2.tar.xz

buildsnappy()
{
	sudo ubuntu-device-flash core 15.04 -v \
		--oem ${OEM_SNAP} \
		--device-part=${DEVICE_TAR} \
		--channel ${SNAPPY_CORE_CH} \
		-o ${SNAPPY_IMAGE}
}

fixbootflag()
{
	dd conv=notrunc if=boot_fix.bin of=${SNAPPY_IMAGE} seek=440 oflag=seek_bytes
}

pack()
{
	xz -0 ${SNAPPY_IMAGE}
}

echo "build snappy..."
rm -f *.img*
buildsnappy
fixbootflag
pack
