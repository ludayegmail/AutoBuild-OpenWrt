# 增加 lienol passwall
echo "src-git lienol https://github.com/chenshuo890/lienol-openwrt-package.git" >> feeds.conf.default
# 增加 helloworld
echo "src-git helloworld https://github.com/fw876/helloworld" >> feeds.conf.default
# 增加 lede
echo "src-git lede https://github.com/coolsnowwolf/lede.git" >> feeds.conf.default
# 修正内核
rm -rf target/linux/generic
svn co https://github.com/project-openwrt/openwrt/branches/master/target/linux/generic target/linux/generic
# 增加ll命令
sed -i '/PATH/i\alias ll="ls -alF --color=auto"\n' package/base-files/files/etc/profile
# 增加 luci-theme-argon
git clone https://github.com/jerrykuku/luci-theme-argon package/danxiaonuo/luci-theme-argon
# smartdns
svn co https://github.com/pymumu/smartdns/trunk/package/openwrt package/danxiaonuo/smartdns
svn co https://github.com/project-openwrt/openwrt/trunk/package/ntlf9t/luci-app-smartdns package/danxiaonuo/luci-app-smartdns
# 复杂的AdGuardHome的openwrt的luci界面
git clone https://github.com/rufengsuixing/luci-app-adguardhome.git package/danxiaonuo/luci-app-adguardhome
# Server酱
git clone https://github.com/tty228/luci-app-serverchan.git package/danxiaonuo/luci-app-serverchan
# 磁盘管理
git clone https://github.com/lisaac/luci-app-diskman package/danxiaonuo/luci-app-diskman
# k3设置
git clone https://github.com/lwz322/luci-app-k3screenctrl.git package/k3/luci-app-k3screenctrl
git clone https://github.com/lwz322/k3screenctrl.git package/k3/k3screenctrl
git clone https://github.com/lwz322/k3screenctrl_build.git package/k3/k3screenctrl_build
# 修改 dnsmasq 为 dnsmasq-full
sed -i 's/dnsmasq i/dnsmasq-full i/g' include/target.mk
# 增加 ucl upx
svn co https://github.com/coolsnowwolf/lede/trunk/tools/ucl tools/ucl
svn co https://github.com/coolsnowwolf/lede/trunk/tools/upx tools/upx
sed -i '/CONFIG_TARGET_tegra/a\tools-y += ucl upx' tools/Makefile
sed -i '/dependencies/a\$(curdir)/upx/compile := $(curdir)/ucl/compile' tools/Makefile
# 增加自定义配置
sed -i 's/base-files.*/default-settings &/' include/target.mk
sed -i 's/default-settings.*/& luci-app-samba autosamba/' include/target.mk
# 修改文件句柄数
sed -i 's/net.netfilter.nf_conntrack_max=.*/net.netfilter.nf_conntrack_max=65535/g' package/kernel/linux/files/sysctl-nf-conntrack.conf
