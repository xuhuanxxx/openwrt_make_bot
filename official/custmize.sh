sed -i '/root/d' package/base-files/files/etc/shadow
sed -i '1i\root:$1$XVyBXUIp$qDem8k6G0pkLNUCOB9f0G/:18334:0:99999:7:::'  package/base-files/files/etc/shadow


sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

sed -i '/listen_https/d' package/network/services/uhttpd/files/uhttpd.config
sed -i '/HTTP listen addresses/a\        list listen_https       [::]:443' package/network/services/uhttpd/files/uhttpd.config
sed -i '/HTTP listen addresses/a\        list listen_https       0.0.0.0:443' package/network/services/uhttpd/files/uhttpd.config
sed -i '/redirect_https/s/0/1/g' package/network/services/uhttpd/files/uhttpd.config


if [ -d "package/luci-app-clash" ]; then
		rm -rf "package/luci-app-clash"
fi

git clone https://github.com/frainzy1477/luci-app-clash package/luci-app-clash

if [ -d "package/OpenClash" ]; then
		rm -rf "package/OpenClash"
fi

git clone https://github.com/vernesong/OpenClash package/OpenClash

if [ -d "package/luci-app-adguardhome" ]; then
		rm -rf "package/luci-app-adguardhome"
fi

git clone https://github.com/rufengsuixing/luci-app-adguardhome package/luci-app-adguardhome

#if [ -d "package/luci-app-filetransfer" ]; then
#		rm -rf "package/luci-app-filetransfer"
#fi

# git clone https://github.com/f8q8/luci-app-filetransfer package/luci-app-filetransfer

# git clone https://github.com/falafalafala1668/OpenWrt-UEFI-Support OpenWrt-UEFI-Support
# ./OpenWrt-UEFI-Support/RunMe.sh apply

