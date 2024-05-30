#!/bin/bash

pkg up
pkg install unstable-repo -y
pkg install curl -y
pkg install x11-repo -y
pkg install qemu-system-x86-64-headless -y
pkg install qemu-utils -y
curl http://dl-cdn.alpinelinux.org/alpine/v3.10/releases/x86_64/alpine-virt-3.10.9-x86_64.iso -o alpine.iso
qemu-img create -f qcow2 alpine.img 5g
qemu-system-x86_64 -hda alpine.img -cdrom alpine.iso -boot d -m 1024 -netdev user,id=n1,hostfwd=tcp::20000-:22 -device virtio-net,netdev=n1 -nographic -smp $(nproc)
