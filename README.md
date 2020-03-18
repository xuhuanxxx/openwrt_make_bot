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
replace **xxxyyyzzz** behind **token=** in make.sh with your own token of [tmp.link](https://tmp.link), then get firmware file at workspace page.
