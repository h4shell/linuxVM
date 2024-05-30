#!/bin/bash

echo "auto lo
iface lo inet loopback
auto eth0
iface eth0 inet dhcp" > /etc/network/interfaces
/etc/init.d/networking restart
echo nameserver 8.8.8.8 > /etc/resolv.conf
setup-alpine
