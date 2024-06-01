@echo off
set FILE="alpine.img"

IF EXIST %FILE% (
	echo file exist... -> SKIP
	cls
) ELSE (
	curl -o %FILE% -L https://github.com/h4shell/termux_alpinelinux/raw/main/alpine.img
)


echo Alpine-VM started: SSH: 127.0.0.1:20000
echo.
echo "                                                               "
echo "       | |     (_)            | |    (_)                 	"
echo "   __ _| |_ __  _ _ __   ___  | |     _ _ __  _   ___  __	"
echo "  / _` | | '_ \| | '_ \ / _ \ | |    | | '_ \| | | \ \/ /	"
echo " | (_| | | |_) | | | | |  __/ | |____| | | | | |_| |>  < 	"
echo "  \__,_|_| .__/|_|_| |_|\___| |______|_|_| |_|\__,_/_/\_\	"
echo "         | |                                             	"
echo "         |_|                                             	"
echo.
echo.
echo  ---------------------------------
echo ^|                                 ^|
echo ^|   SSH: 127.0.0.1: 20000         ^|
echo ^|   Username: user                ^|
echo ^|   Password: password            ^|
echo ^|                                 ^|
echo  ---------------------------------
echo.
cmd.exe /c "start /B qemu -hda %FILE& -boot c -m 1024 -netdev user,id=n1,hostfwd=tcp::20000-:22,hostfwd=tcp::20001-:20001,hostfwd=tcp::20002-:20002,hostfwd=tcp::20003-:20003,hostfwd=tcp::20004-:20004,hostfwd=tcp::20005-:20005,hostfwd=udp::20000-:20000,hostfwd=udp::20001-:20001,hostfwd=udp::20002-:20002,hostfwd=udp::20003-:20003,hostfwd=udp::20004-:20004,hostfwd=udp::20005-:20005 -device virtio-net,netdev=n1 -machine q35 -nographic -smp 6 -serial none -monitor none"
