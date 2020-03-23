#!/bin/bash

REPO_URL="https://github.com/openwrt/openwrt"
# REPO_URL="https://github.com/coolsnowwolf/lede"
REPO_BRANCH="master"
EXEC_DIR=$(cd `dirname $0`; pwd)
SOURCE_DIR="source"
CONFIG_FILE=".config"
CUSTMIZE_SH="custmize.sh"
FIRMWARE="firmware"
NPROC=1

cd $EXEC_DIR

echo "clean environment"

echo "update environmentc"
sudo apt-get update
sudo -E apt-get install build-essential asciidoc binutils bzip2 gawk gettext git libncurses5-dev libz-dev patch unzip zlib1g-dev lib32gcc1 libc6-dev-i386 subversion flex uglifyjs gcc-multilib g++-multilib p7zip p7zip-full msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils upx libelf-dev autoconf automake libtool autopoint device-tree-compiler
sudo -E apt-get -y install 
sudo -E apt-get -y autoremove --purge
sudo -E apt-get clean

echo "complie project: ${REPO_URL}, $REPO_BRANCH"

if [ ! -d "$SOURCE_DIR" ]; then
	echo "create project"
       	git clone --depth 1 $REPO_URL -b $REPO_BRANCH $SOURCE_DIR
	echo "project created"
fi

if [ -d "$SOURCE_DIR" ]; then
	cd $SOURCE_DIR	
	echo "update project"
	echo "backup .config"
	cp $CONFIG_FILE $CONFIG_FILE.old
	if [ -d "OpenWrt-UEFI-Support" ]; then
		echo "restore UEFI"
		./OpenWrt-UEFI-Support/RunMe.sh restore
	fi
	git pull
fi

rm -rf tmp

echo "update feeds"
./scripts/feeds update -a
echo "install feeds"
./scripts/feeds install -a

if [ ! -f "$CONFIG_FILE" ]; then
	echo "first complie, config initial"
	make defconfig
else
	# NPROC=$(nproc)
	echo "make clean"
	make clean
fi

if [  -f "../$CUSTMIZE_SH" ]; then
       	echo "custmize inside setting"
	chmod +x ../$CUSTMIZE_SH
	../$CUSTMIZE_SH
fi

if [  -f "../$CONFIG_FILE" ]; then
	# echo "replace .config"
	# rm -f $CONFIG_FILE.old
	# mv $CONFIG_FILE $CONFIG_FILE.old
	cp ../$CONFIG_FILE $CONFIG_FILE
else
	cp $CONFIG_FILE.old $CONFIG_FILE
fi

echo "downloading"
make download -j8 V=s

echo "${NPROC} thread complie"
make -j$(nproc) V=s

echo "package firmware"
FILE_NAME="openwrt_official_`date +%Y%m%d_%H%M`.tar.gz"
tar --exclude=packages --exclude=*rootfs* -czvf ${FILE_NAME} bin/targets


if [ ! -d "../${FIRMWARE}" ]; then
	mkdir ../${FIRMWARE}
fi

mv ${FILE_NAME} ../${FIRMWARE}/${FILE_NAME}

if [  -f "../${FIRMWARE}/${FILE_NAME}" ]; then
	echo "upload firmware"	
	curl -k -F "file=@${EXEC_DIR}/${FIRMWARE}/${FILE_NAME}" -F "token=ro0rct4tph" -F "model=1" -X POST "https://connect.tmp.link/api_v2/cli_uploader"
else
	echo "nothing complied, nothing uploaed"
fi
