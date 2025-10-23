#!/bin/bash

#=================================================
# OpenWrt DIY 脚本
#=================================================

# 1. 辅助函数
#-------------------------------------------------
# Git 稀疏克隆函数，只克隆指定目录
function git_sparse_clone() {
  branch="$1" repourl="$2" && shift 2
  git clone --depth=1 -b $branch --single-branch --filter=blob:none --sparse $repourl
  repodir=$(echo $repourl | awk -F '/' '{print $(NF)}')
  cd $repodir && git sparse-checkout set $@
  mv -f $@ ../package
  cd .. && rm -rf $repodir
}


# 2. 清理冲突的软件包
#-------------------------------------------------
echo '正在清理冲突的软件包...'
rm -rf feeds/packages/net/mosdns
rm -rf feeds/packages/net/msd_lite
rm -rf feeds/packages/net/smartdns
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/luci/themes/luci-theme-netgear
rm -rf feeds/luci/applications/luci-app-mosdns
rm -rf feeds/luci/applications/luci-app-netdata
rm -rf feeds/luci/applications/luci-app-serverchan
rm -rf feeds/packages/utils/domoticz
rm -rf feeds/packages/net/i2pd
rm -rf feeds/packages/net/kea


# 3. 添加额外的软件包
#-------------------------------------------------
echo '正在添加额外的软件包...'
# 插件
git clone --depth=1 https://github.com/NONGFAH/luci-app-athena-led package/luci-app-athena-led &
git clone --depth=1 https://github.com/kongfl888/luci-app-adguardhome package/luci-app-adguardhome &
git clone --depth=1 -b openwrt-18.06 https://github.com/tty228/luci-app-wechatpush package/luci-app-serverchan &
git clone --depth=1 https://github.com/ilxp/luci-app-ikoolproxy package/luci-app-ikoolproxy &
git clone --depth=1 https://github.com/esirplayground/luci-app-poweroff package/luci-app-poweroff &
git clone --depth=1 https://github.com/destan19/OpenAppFilter package/OpenAppFilter &
git clone --depth=1 https://github.com/Jason6111/luci-app-netdata package/luci-app-netdata &
git clone --depth=1 https://github.com/EasyTier/luci-app-easytier.git package/luci-app-easytier &
git_sparse_clone main https://github.com/Lienol/openwrt-package luci-app-filebrowser luci-app-ssr-mudb-server &
git_sparse_clone master https://github.com/immortalwrt/luci applications/luci-app-eqos &
# 科学上网插件
git clone --depth=1 https://github.com/gdy666/luci-app-lucky package/luci-app-lucky &
git clone --depth=1 https://github.com/VIKINGYFY/homeproxy package/luci-app-homeproxy &
git clone --depth=1 https://github.com/ximiTech/luci-app-msd_lite package/luci-app-msd_lite &
git clone --depth=1 https://github.com/ximiTech/msd_lite package/msd_lite &
git clone --depth=1 https://github.com/sbwml/luci-app-mosdns package/luci-app-mosdns &
# 主题
git clone --depth=1 https://github.com/kiddin9/luci-theme-edge package/luci-theme-edge &
git clone --depth=1 https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon &
git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config &
git clone --depth=1 https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom package/luci-theme-infinityfreedom &
git clone --depth=1 https://github.com/eamonxg/luci-theme-aurora.git package/luci-theme-aurora &
git_sparse_clone main https://github.com/haiibo/packages luci-app-onliner luci-theme-atmaterial luci-theme-opentomato luci-theme-netgear &

echo '等待软件包下载完成...'
wait


# 4. 应用补丁和修复
#-------------------------------------------------
echo '正在更新和安装 Feeds...'
./scripts/feeds update -a
./scripts/feeds install -a

echo '正在应用补丁和修复...'
# 修改 Argon 主题背景
# cp -f $GITHUB_WORKSPACE/images/bg1.jpg package/luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg

# 修复 hostapd 编译问题
mkdir -p package/network/services/hostapd/patches
cp -f $GITHUB_WORKSPACE/scripts/011-fix-mbo-modules-build.patch package/network/services/hostapd/patches/011-fix-mbo-modules-build.patch

# 修复 armv8 设备 xfsprogs 编译问题
sed -i 's/TARGET_CFLAGS.*/TARGET_CFLAGS += -DHAVE_MAP_SYNC -D_LARGEFILE64_SOURCE/g' feeds/packages/utils/xfsprogs/Makefile

# 修改 LuCI 界面本地时间格式
sed -i 's/os.date()/os.date("%a %Y-%m-%d %H:%M:%S")/g' package/lean/autocore/files/*/index.htm

# 修改 x86 型号名称显示
sed -i 's/${g}.*/${a}${b}${c}${d}${e}${f}${hydrid}/g' package/lean/autocore/files/x86/autocore

# 更新固件版本号
date_version=$(date +"%y.%m.%d")
sed -i "s/DISTRIB_REVISION='.*'/DISTRIB_REVISION='R${date_version} by Haiibo'/" package/lean/default-settings/files/zzz-default-settings

# 修正软件包的 Makefile
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/..\/..\/luci.mk/$(TOPDIR)\/feeds\/luci\/luci.mk/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/..\/..\/lang\/golang\/golang-package.mk/$(TOPDIR)\/feeds\/packages\/lang\/golang\/golang-package.mk/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/PKG_SOURCE_URL:=@GHREPO/PKG_SOURCE_URL:=https:\/\/github.com/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/PKG_SOURCE_URL:=@GHCODELOAD/PKG_SOURCE_URL:=https:\/\/codeload.github.com/g' {}


# 5. 设置系统默认值 (uci-defaults)
#-------------------------------------------------
echo '正在设置系统默认值...'
# 设置不同设备的 LAN 口 IP
# RE-CS-02 (02) -> 10.0.0.1
mkdir -p files/jdcloud_re-cs-02/etc/uci-defaults
cat > files/jdcloud_re-cs-02/etc/uci-defaults/99-set-lan-ip <<EOF
#!/bin/sh
uci set network.lan.ipaddr='10.0.0.1'
uci commit network
exit 0
EOF
chmod +x files/jdcloud_re-cs-02/etc/uci-defaults/99-set-lan-ip

# RE-SS-01 (01) -> 10.0.1.1
mkdir -p files/jdcloud_re-ss-01/etc/uci-defaults
cat > files/jdcloud_re-ss-01/etc/uci-defaults/99-set-lan-ip <<EOF
#!/bin/sh
uci set network.lan.ipaddr='10.0.1.1'
uci commit network
exit 0
EOF
chmod +x files/jdcloud_re-ss-01/etc/uci-defaults/99-set-lan-ip

# 设置默认主题和暗黑模式
mkdir -p files/etc/uci-defaults
cat > files/etc/uci-defaults/98-set-theme <<EOF
#!/bin/sh
uci set luci.main.mediaurlbase='/luci-static/argon'
uci set argon_config.@global[0].mode='dark'
uci commit luci
uci commit argon_config
exit 0
EOF
chmod +x files/etc/uci-defaults/98-set-theme

# 设置 nlbwmon 刷新间隔
cat > files/etc/uci-defaults/97-set-nlbwmon <<EOF
#!/bin/sh
uci set nlbwmon.@nlbwmon[0].refresh_interval='2s'
uci commit nlbwmon
exit 0
EOF
chmod +x files/etc/uci-defaults/97-set-nlbwmon

# 启用 nlbwmon 的脚本
chmod 755 package/luci-app-onliner/root/usr/share/onliner/setnlbw.sh


# 6. 完成
#-------------------------------------------------
