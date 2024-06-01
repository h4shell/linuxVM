@echo off
set FILE="alpine.img"

IF EXIST %FILE% (
	echo file exist
	cls
) ELSE (
	curl -o alpine.img -L https://github.com/h4shell/termux_alpinelinux/raw/main/alpine.img
)

@echo off
echo VM started: SSH: 127.0.0.1:20000
cmd.exe /c "start /B qemu -hda alpine.img -boot c -m 1024 -netdev user,id=n1,hostfwd=tcp::20000-:22,hostfwd=tcp::20001-:20001,hostfwd=tcp::20002-:20002,hostfwd=tcp::20003-:20003,hostfwd=tcp::20004-:20004,hostfwd=tcp::20005-:20005,hostfwd=udp::20000-:20000,hostfwd=udp::20001-:20001,hostfwd=udp::20002-:20002,hostfwd=udp::20003-:20003,hostfwd=udp::20004-:20004,hostfwd=udp::20005-:20005 -device virtio-net,netdev=n1 -machine q35 -nographic -smp 8 -vga none -serial none -monitor none"