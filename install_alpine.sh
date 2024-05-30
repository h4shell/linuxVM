#!/bin/bash

pkg install wget
wget https://github.com/h4shell/termux_alpinelinux/raw/main/alpine.img

echo "qemu-system-x86_64 -hda alpine.img -boot c -m 1024 -netdev user,id=n1,hostfwd=tcp::20000-:22,hostfwd=tcp::20001-:20001,hostfwd=tcp::20002-:20002,hostfwd=tcp::20003-:20003,hostfwd=tcp::20004-:20004,hostfwd=tcp::20005-:20005,hostfwd=udp::20000-:20000,hostfwd=udp::20001-:20001,hostfwd=udp::20002-:20002,hostfwd=udp::20003-:20003,hostfwd=udp::20004-:20004,hostfwd=udp::20005-:20005 -device virtio-net,netdev=n1 -nographic -smp $(nproc) > /dev/null & echo alpine started on ssh port 20000" > start_alpine.sh
chmod +x start_alpine.sh
echo '
--------------------------------
'