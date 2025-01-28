#!/bin/bash

# ZeroWrt选项菜单
mkdir -p files/bin
curl -L -o files/bin/ZeroWrt https://git.kejizero.online/zhao/files/raw/branch/main/bin/ZeroWrt
chmod +x files/bin/ZeroWrt
mkdir -p files/root
curl -L -o files/root/version.txt https://git.kejizero.online/zhao/files/raw/branch/main/bin/version.txt
chmod +x files/root/version.txt

# default_set
mkdir -p files/etc/config
curl -L -o files/etc/config/default_dhcp.conf https://raw.githubusercontent.com/oppen321/ZeroWrt/refs/heads/master/files/default_dhcp.conf
chmod +x files/etc/config/default_dhcp.conf

# 更新default-settings
curl -L -o package/lean/default-settings/files/zzz-default-settings https://raw.githubusercontent.com/yndzm/ZeroWrt/refs/heads/master/files/zzz-default-settings
