sed -i '/root/d' package/base-files/files/etc/shadow
sed -i '1i\root:$1$XVyBXUIp$qDem8k6G0pkLNUCOB9f0G/:18334:0:99999:7:::'  package/base-files/files/etc/shadow

sed -i 's/option lang auto/option lang "zh_cn"/g' feeds/luci/modules/luci-base/root/etc/config/luci

sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate
sed -i '/timezone/d' package/base-files/files/bin/config_generate
sed -i '/zonename/d' package/base-files/files/bin/config_generate
sed -i "/hostname/a\                set system.@system[-1].zonename='Asia/Shanghai'" package/base-files/files/bin/config_generate
sed -i "/hostname/a\                set system.@system[-1].timezone='CST-8'" package/base-files/files/bin/config_generate

#sed -i '/listen_https/d' package/network/services/uhttpd/files/uhttpd.config
#sed -i '/HTTP listen addresses/a\        list listen_https       [::]:443' package/network/services/uhttpd/files/uhttpd.config
#sed -i '/HTTP listen addresses/a\        list listen_https       0.0.0.0:443' package/network/services/uhttpd/files/uhttpd.config
#sed -i '/redirect_https/s/0/1/g' package/network/services/uhttpd/files/uhttpd.config

if [ -d "package/luci-theme-argon" ]; then
	git -C package/luci-theme-argon pull
else 
	git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
fi

if [ -d "package/luci-app-clash" ]; then
	git -C package/luci-app-clash pull
else
	git clone https://github.com/frainzy1477/luci-app-clash package/luci-app-clash
fi

if [ -d "OpenWrt-UEFI-Support" ]; then
	echo "update UEFI"
	# ./OpenWrt-UEFI-Support/RunMe.sh restore
	git -C OpenWrt-UEFI-Support pull
	./OpenWrt-UEFI-Support/RunMe.sh update
	./OpenWrt-UEFI-Support/RunMe.sh apply
else
	echo "add UEFI"
	git clone https://github.com/falafalafala1668/OpenWrt-UEFI-Support OpenWrt-UEFI-Support
	./OpenWrt-UEFI-Support/RunMe.sh apply
fi

