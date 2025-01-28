#!/bin/sh

. /etc/os-release
. /lib/functions/uci-defaults.sh

# 设置默认密码
sed -i 's/root::0:0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/g' /etc/shadow
sed -i 's/root:::0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/g' /etc/shadow

# 设置默认主题为argon
uci set luci.main.mediaurlbase='/luci-static/argon'
uci commit luci

# 切换opkg源
sed -i 's,downloads.openwrt.org,mirrors.pku.edu.cn/openwrt,g' /etc/opkg/distfeeds.conf

# 设置LAN口DNS
uci set network.lan.dns='127.0.0.1'
uci commit network
/etc/init.d/network restart

# 默认wan口防火墙打开
uci set firewall.@zone[1].input='ACCEPT'
uci commit firewall

# 设置主机名映射，解决安卓原生TV首次连不上网的问题
uci add dhcp domain
uci set "dhcp.@domain[-1].name=time.android.com"
uci set "dhcp.@domain[-1].ip=203.107.6.88"
uci commit dhcp

# 设置所有网口可访问网页终端
uci delete ttyd.@ttyd[0].interface

# 设置所有网口可连接 SSH
uci set dropbear.@dropbear[0].Interface=''
uci commit

# Docker换源
uci add_list dockerd.globals.registry_mirrors="https://docker.m.daocloud.io"
uci commit dockerd

# 自动设置 Dnsmasq
# uci set smartdns.@smartdns[0].auto_set_dnsmasq='1'
# /etc/init.d/smartdns restart

# Dnsmasq设置
uci set dhcp.@dnsmasq[0].cachesize='0'
uci commit dhcp
/etc/init.d/dnsmasq restart

# 提交更改并应用
uci commit wireless

exit 0
