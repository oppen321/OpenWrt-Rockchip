#!/bin/bash

# 修改默认IP
sed -i 's/192.168.1.1/10.0.0.1/g' package/base-files/luci2/bin/config_generate
sed -i 's/192.168.1.1/10.0.0.1/g' package/base-files/files/bin/config_generate

# 更改默认 Shell 为 zsh
#sed -i 's/\/bin\/ash/\/usr\/bin\/zsh/g' package/base-files/files/etc/passwd

# TTYD 免登录
sed -i 's|/bin/login|/bin/login -f root|g' feeds/packages/utils/ttyd/files/ttyd.config

# 移除要替换的包
rm -rf feeds/packages/net/mosdns
rm -rf feeds/packages/net/msd_lite
rm -rf feeds/packages/net/smartdns
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/luci/themes/luci-theme-netgear
rm -rf feeds/luci/applications/luci-app-mosdns
rm -rf feeds/luci/applications/luci-app-netdata
rm -rf feeds/luci/applications/luci-app-serverchan
rm -rf feeds/packages/lang/golang
find ./ | grep Makefile | grep v2ray-geodata | xargs rm -f
find ./ | grep Makefile | grep mosdns | xargs rm -f

# golong1.23依赖
#git clone --depth=1 https://github.com/sbwml/packages_lang_golang -b 22.x feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 23.x feeds/packages/lang/golang

# 移除要替换的包
rm -rf feeds/packages/net/mosdns
rm -rf feeds/packages/net/msd_lite
rm -rf feeds/packages/net/smartdns
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/luci/themes/luci-theme-netgear
rm -rf feeds/luci/applications/luci-app-mosdns
rm -rf feeds/luci/applications/luci-app-netdata
rm -rf feeds/luci/applications/luci-app-serverchan
rm -rf feeds/packages/lang/golang
find ./ | grep Makefile | grep v2ray-geodata | xargs rm -f
find ./ | grep Makefile | grep mosdns | xargs rm -f

# Git稀疏克隆，只克隆指定目录到本地
function git_sparse_clone() {
  branch="$1" repourl="$2" && shift 2
  git clone --depth=1 -b $branch --single-branch --filter=blob:none --sparse $repourl
  repodir=$(echo $repourl | awk -F '/' '{print $(NF)}')
  cd $repodir && git sparse-checkout set $@
  mv -f $@ ../package
  cd .. && rm -rf $repodir
}

# golong1.23依赖
#git clone --depth=1 https://github.com/sbwml/packages_lang_golang -b 22.x feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 23.x feeds/packages/lang/golang

# 添加额外插件
git clone --depth=1 https://github.com/kongfl888/luci-app-adguardhome package/luci-app-adguardhome
git clone --depth=1 https://github.com/tty228/luci-app-wechatpush package/luci-app-serverchan
git clone --depth=1 https://github.com/ilxp/luci-app-ikoolproxy package/luci-app-ikoolproxy
git clone --depth=1 https://github.com/destan19/OpenAppFilter package/OpenAppFilter
git clone --depth=1 https://github.com/Jason6111/luci-app-netdata package/luci-app-netdata
git_sparse_clone main https://github.com/Lienol/openwrt-package luci-app-filebrowser luci-app-ssr-mudb-server
git clone --depth=1 https://github.com/sirpdboy/luci-app-eqosplus package/luci-app-eqosplus
git_sparse_clone main https://github.com/sirpdboy/sirpdboy-package luci-app-socat

# 科学上网插件
git clone --depth=1 -b master https://github.com/fw876/helloworld package/luci-app-ssr-plus
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall-packages package/openwrt-passwall
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall package/luci-app-passwall
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall2 package/luci-app-passwall2
git_sparse_clone master https://github.com/vernesong/OpenClash luci-app-openclash


# Themes
git clone --depth=1 https://github.com/kiddin9/luci-theme-edge package/luci-theme-edge
git clone --depth=1 https://github.com/oppen321/luci-theme-argon package/luci-theme-argon
git clone --depth=1 https://github.com/oppen321/luci-theme-argon-config package/luci-app-argon-config
git clone --depth=1 https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom package/luci-theme-infinityfreedom

# 自定义设置
cp -f $GITHUB_WORKSPACE/Diy/banner package/base-files/files/etc/banner

# SmartDNS
git clone --depth=1 https://github.com/pymumu/luci-app-smartdns package/luci-app-smartdns
git clone --depth=1 https://github.com/pymumu/openwrt-smartdns package/smartdns

# msd_lite
git clone --depth=1 https://github.com/ximiTech/luci-app-msd_lite package/luci-app-msd_lite
git clone --depth=1 https://github.com/ximiTech/msd_lite package/msd_lite

# MosDNS
git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

# Alist
git clone https://github.com/sbwml/luci-app-alist -b main package/alist

# DDNS.go
git clone --depth=1 https://github.com/sirpdboy/luci-app-ddns-go package/luci-app-ddns-go

# iStore
git_sparse_clone main https://github.com/linkease/istore-ui app-store-ui
git_sparse_clone main https://github.com/linkease/istore luci

# Lucky
git clone --depth=1 https://github.com/sirpdboy/luci-app-lucky package/luci-app-lucky

# 一键配置拨号
git clone --depth=1 https://github.com/sirpdboy/luci-app-netwizard package/luci-app-netwizard

# 定时任务
git clone --depth=1 https://github.com/sirpdboy/luci-app-autotimeset package/luci-app-autotimeset

# 在线更新
git clone --depth=1 https://github.com/oppen321/luci-app-gpsysupgrade package/luci-app-gpsysupgrade

# luci-app-partexp
git clone --depth=1 https://github.com/sirpdboy/luci-app-partexp package/luci-app-partexp

# x86 型号只显示 CPU 型号
sed -i 's/${g}.*/${a}${b}${c}${d}${e}${f}${hydrid}/g' package/lean/autocore/files/x86/autocore

# 修改本地时间格式
sed -i 's/os.date()/os.date("%a %Y-%m-%d %H:%M:%S")/g' package/lean/autocore/files/*/index.htm

# 修改版本为编译日期
date_version=$(date +"%y.%m.%d")
orig_version=$(cat "package/lean/default-settings/files/zzz-default-settings" | grep DISTRIB_REVISION= | awk -F "'" '{print $2}')
sed -i "s/${orig_version}/R${date_version} by OPPEN321/g" package/lean/default-settings/files/zzz-default-settings

# 修复 armv8 设备 xfsprogs 报错
sed -i 's/TARGET_CFLAGS.*/TARGET_CFLAGS += -DHAVE_MAP_SYNC -D_LARGEFILE64_SOURCE/g' feeds/packages/utils/xfsprogs/Makefile

# 临时
sed -i 's/6.1/6.6/g'  ./target/linux/x86/Makefile
sed -i 's/6.1/6.6/g'  ./target/linux/rockchip/Makefile

##更改主机名
sed -i "s/hostname='.*'/hostname='ZeroWrt'/g" package/base-files/luci2/bin/config_generate
sed -i "s/hostname='.*'/hostname='ZeroWrt'/g" package/base-files/files/bin/config_generate

# 修改 Makefile
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/..\/..\/luci.mk/$(TOPDIR)\/feeds\/luci\/luci.mk/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/..\/..\/lang\/golang\/golang-package.mk/$(TOPDIR)\/feeds\/packages\/lang\/golang\/golang-package.mk/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/PKG_SOURCE_URL:=@GHREPO/PKG_SOURCE_URL:=https:\/\/github.com/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/PKG_SOURCE_URL:=@GHCODELOAD/PKG_SOURCE_URL:=https:\/\/codeload.github.com/g' {}

# 个性化设置
echo -e "\nmsgid \"Control\"" >> feeds/luci/modules/luci-base/po/zh_Hans/base.po
echo -e "msgstr \"控制\"" >> feeds/luci/modules/luci-base/po/zh_Hans/base.po

echo -e "\nmsgid \"NAS\"" >> feeds/luci/modules/luci-base/po/zh_Hans/base.po
echo -e "msgstr \"网络存储\"" >> feeds/luci/modules/luci-base/po/zh_Hans/base.po

# 修改位置
sed -i 's/services/control/g' package/OpenAppFilter/luci-app-oaf/luasrc/controller/*.lua
sed -i 's/services/control/g' package/OpenAppFilter/luci-app-oaf/luasrc/model/cbi/appfilter/*.lua
sed -i 's/services/control/g' package/OpenAppFilter/luci-app-oaf/luasrc/view/admin_network/*.htm
sed -i 's/services/control/g' package/OpenAppFilter/luci-app-oaf/luasrc/cbi/*.htm

sed -i 's/services/control/g' feeds/luci/applications/luci-app-accesscontrol/luasrc/controller/*.lua
sed -i 's/services/control/g' feeds/luci/applications/luci-app-accesscontrol/luasrc/model/cbi/*.lua
sed -i 's/services/control/g' feeds/luci/applications/luci-app-accesscontrol/luasrc/view/mia/*.htm

# 取消主题默认设置
find package/luci-theme-*/* -type f -name '*luci-theme-*' -print -exec sed -i '/set luci.main.mediaurlbase/d' {} \;

sed -i 's/\("admin"\), *\("netwizard"\)/\1, "system", \2/g' package/luci-app-netwizard/luasrc/controller/*.lua

echo -n "$(date +'%Y%m%d')" > package/base-files/files/etc/openwrt_version
# sed -i 's/Variable1 = "*.*"/Variable1 = "oppen321"/g' package/lean/luci-app-gpsysupgrade/luasrc/model/cbi/gpsysupgrade/sysupgrade.lua
# sed -i 's/Variable2 = "*.*"/Variable2 = "Lede-update"/g' package/lean/luci-app-gpsysupgrade/luasrc/model/cbi/gpsysupgrade/sysupgrade.lua
# sed -i 's/Variable3 = "*.*"/Variable3 = "x86_64"/g' package/lean/luci-app-gpsysupgrade/luasrc/model/cbi/gpsysupgrade/sysupgrade.lua
# sed -i 's/Variable4 = "*.*"/Variable4 = "6.6"/g' package/lean/luci-app-gpsysupgrade/luasrc/model/cbi/gpsysupgrade/sysupgrade.lua
# sed -i 's/Variable1 = "*.*"/Variable1 = "oppen321"/g' package/lean/luci-app-gpsysupgrade/root/usr/bin/upgrade.lua
# sed -i 's/Variable2 = "*.*"/Variable2 = "Lede-update"/g' package/lean/luci-app-gpsysupgrade/root/usr/bin/upgrade.lua
# sed -i 's/Variable3 = "*.*"/Variable3 = "x86_64"/g' package/lean/luci-app-gpsysupgrade/root/usr/bin/upgrade.lua
# sed -i 's/Variable4 = "*.*"/Variable4 = "6.6"/g' package/lean/luci-app-gpsysupgrade/root/usr/bin/upgrade.lua

# 调整 V2ray服务器 到 VPN 菜单
# sed -i 's/services/vpn/g' feeds/luci/applications/luci-app-v2ray-server/luasrc/controller/*.lua
# sed -i 's/services/vpn/g' feeds/luci/applications/luci-app-v2ray-server/luasrc/model/cbi/v2ray_server/*.lua
# sed -i 's/services/vpn/g' feeds/luci/applications/luci-app-v2ray-server/luasrc/view/v2ray_server/*.htm

./scripts/feeds update -a
./scripts/feeds install -a
