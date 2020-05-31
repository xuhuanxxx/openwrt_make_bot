# openwrt_x86_64_bot
openwrt_x86_64_bot, official for [official source](https://github.com/openwrt/openwrt) and lean for [lean source](https://github.com/coolsnowwolf/lede), tested on google cloud.
## official
- UEFI support ( introduce a unofficial [script](https://github.com/falafalafala1668/OpenWrt-UEFI-Support) by @falafalafala1668 )
- luci web ssl support 
- add theme: argon
- add luci-app-clash
- add openclash
- add adguardhome

## lean
- UEFI support ( just select it )
- luci web ssl support 
- add luci-app-clash
- add openclash
- add adguardhome

## run
- start with no-root account
- clone project to user's home directory
- repalce [tmp.link](https://tmp.link) token in make.sh
- tmux new -s openwrt
- ./openwrt_x86_64_bot/(official|lean)/make.sh
- ctrl+b d

## download
- replace **xxxyyyzzz** behind **token=** in make.sh with your own token of [tmp.link](https://tmp.link), then get firmware file at workspace page.

## certificate
- use [mkcert](https://github.com/FiloSottile/mkcert) to sign a cert for lan ip ( default：192.168.2.1 )
- convert 192.168.2.1.pem to ~~uhttpd.crt~~ uhttpd.der
  - ~~openssl x509 -in 192.168.2.1.pem -out uhttpd.crt~~
  - openssl x509 -outform der -in 192.168.2.1.pem -out uhttpd.der
- convert 192.168.2.1.key.pem to uhttpd.key
  - openssl rsa -in 192.168.2.1-key.pem -out uhttpd.key
- upload uhttpd.crt and uhttpd.key to /etc
- import rootCA to your device
