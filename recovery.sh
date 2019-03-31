#!/bin/bash
#This is a recovery file to start the hotspot regardless of what you had previously set up
    ifconfig "$wifidev" down  #added
    ifconfig "$wifidev" up #added

    ip link set dev "$wifidev" down
    ip a add 192.168.4.1/24 brd + dev "$wifidev"
    ip link set dev "$wifidev" up
    dhcpcd -k "$wifidev" >/dev/null 2>&1
    iptables -t nat -A POSTROUTING -o "$ethdev" -j MASQUERADE
    iptables -A FORWARD -i "$ethdev" -o "$wifidev" -m state --state RELATED,ESTABLISHED -j ACCEPT
    iptables -A FORWARD -i "$wifidev" -o "$ethdev" -j ACCEPT
    systemctl start dnsmasq
    systemctl start hostapd
    echo 1 > /proc/sys/net/ipv4/ip_forward
