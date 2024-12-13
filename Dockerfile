# 使用官方 OpenWrt 根文件系统镜像作为基础镜像
FROM openwrt/rootfs:x86-64-23.05.5

# 暴露 HTTP 端口
EXPOSE 80

# 创建必要的目录，更新软件包列表，并安装 uhttpd 和 Lua 模块
RUN mkdir -p /var/lock && \
    opkg update && \
    opkg install uhttpd uhttpd-mod-lua kmod-macvlan && \
    uci set uhttpd.main.interpreter='.lua=/usr/bin/lua' && \
    uci commit uhttpd
USER root



CMD ["/sbin/init"]