#!/bin/bash

# Set default theme to luci-theme-aurora
uci set luci.main.mediaurlbase='/luci-static/aurora'
uci commit luci

# Disable IPV6 ula prefix
# sed -i 's/^[^#].*option ula/#&/' /etc/config/network

# Check file system during boot
# uci set fstab.@global[0].check_fs=1
# uci commit fstab

uci set network.@device[0].packet_steering=0
uci set network.@device[0].flow_offloading=0
uci set network.@device[0].flow_offloading_hw=0
uci commit network

exit 0
