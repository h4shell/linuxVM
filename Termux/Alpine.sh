#!/bin/sh
# exec > /dev/null 2>&1
LINUX_IMG="alpine.img"

if [ -e "/data/data/com.termux/files/usr/bin/qemu-system-x86_64" ]; then
    # QEMU installato
    echo
else
    # QEMU non installato
    pkg up
    pkg install unstable-repo -y
    pkg install curl -y
    pkg install x11-repo -y
    pkg install qemu-system-x86-64-headless -y
    pkg install qemu-utils -y
fi

if [ -e "./$LINUX_IMG" ]; then
    # alpine.img esiste
    echo
else
    curl -o $LINUX_IMG -L https://github.com/h4shell/termux_alpinelinux/raw/main/$LINUX_IMG
    # alpine.img non esiste
fi

qemu-system-x86_64 -hda alpine.img -boot c -m 1024 -netdev user,id=n1,hostfwd=tcp::20000-:22,hostfwd=tcp::20001-:20001,hostfwd=tcp::20002-:20002,hostfwd=tcp::20003-:20003,hostfwd=tcp::20004-:20004,hostfwd=tcp::20005-:20005,hostfwd=udp::20000-:20000,hostfwd=udp::20001-:20001,hostfwd=udp::20002-:20002,hostfwd=udp::20003-:20003,hostfwd=udp::20004-:20004,hostfwd=udp::20005-:20005 -device virtio-net,netdev=n1 -machine q35 -nographic -smp $(nproc) -vga none -monitor none > /dev/null &
PID_QEMU_ALPINE=$!
echo
cat << 'EOF'
                                                             
       | |     (_)            | |    (_)                   
   __ _| |_ __  _ _ __   ___  | |     _ _ __  _   ___  __  
  / _` | | '_ \| | '_ \ / _ \ | |    | | '_ \| | | \ \/ /  
 | (_| | | |_) | | | | |  __/ | |____| | | | | |_| |>  <   
  \__,_|_| .__/|_|_| |_|\___| |______|_|_| |_|\__,_/_/\_\  
          | |                                            
          |_|                                             

  ---------------------------------
^|                                 ^|
^|   SSH: 127.0.0.1: 20000         ^|
^|   Username: user                ^|
^|   Password: password            ^|
^|                                 ^|
  ---------------------------------

EOF
echo
mkdir ./qemu_tmp > /dev/null
echo $PID_QEMU_ALPINE > ./qemu_tmp/PID_QEMU_ALPINE.pid
read -p "Press any key to stop Alpine VM..." qpid
kill -9 $PID_QEMU_ALPINE
rm ./qemu_tmp/PID_QEMU_ALPINE.pid
rm -R ./qemu_tmp