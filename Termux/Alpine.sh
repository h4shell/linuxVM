#!/bin/sh
# exec > /dev/null 2>&1
LINUX_IMG="alpine.img"

mkdir ./qemu_tmp 2> /dev/null

# Funzione per installare pacchetti su Termux
install_termux() {
    pkg up -y
    pkg install unstable-repo -y
    pkg install curl -y
    pkg install x11-repo -y
    pkg install qemu-system-x86-64-headless -y
    pkg install qemu-utils -y
}

# Funzione per installare pacchetti su Ubuntu/Debian
install_ubuntu_debian() {
    sudo apt update -y
    sudo apt install -y qemu-system-x86 qemu-utils curl
}

# Funzione per installare pacchetti su Arch
install_arch() {
    sudo pacman -Syu --noconfirm
    sudo pacman -S --noconfirm qemu curl
}

# Funzione per installare pacchetti su Fedora
install_fedora() {
    sudo dnf upgrade --refresh -y
    sudo dnf install -y qemu-system-x86 qemu-img curl
}


if [ -e "/data/data/com.termux/files/usr/bin/pkg" ]; then
    if [ -e "/data/data/com.termux/files/usr/bin/qemu-system-x86" ]; then
        install_termux
    else
        echo
    fi
elif [ -e "/usr/bin/apt" ]; then
    if [ -e "/usr/bin/qemu-system-x86" ]; then
        install_ubuntu_debian
    else
        echo
    fi
elif [ -e "/usr/bin/pacman" ]; then
    if [ -e "/usr/bin/qemu-system-x86" ]; then
        install_arch
    else
        echo
    fi
elif [ -e "/usr/bin/dnf" ]; then
    if [ -e "/usr/bin/qemu-system-x86" ]; then
        install_fedora
    else
        echo
    fi
else
    echo "Sistema operativo non supportato."
    exit 1
fi

if [ -e "./$LINUX_IMG" ]; then
    echo
else
    curl -o $LINUX_IMG -L https://github.com/h4shell/termux_alpinelinux/raw/main/$LINUX_IMG
    # alpine.img non esiste
fi

qemu-system-x86_64 -hda alpine.img -boot c -m 1024 -netdev user,id=n1,hostfwd=tcp::20000-:22,hostfwd=tcp::20001-:20001,hostfwd=tcp::20002-:20002,hostfwd=tcp::20003-:20003,hostfwd=tcp::20004-:20004,hostfwd=tcp::20005-:20005,hostfwd=udp::20000-:20000,hostfwd=udp::20001-:20001,hostfwd=udp::20002-:20002,hostfwd=udp::20003-:20003,hostfwd=udp::20004-:20004,hostfwd=udp::20005-:20005 -device virtio-net,netdev=n1 -machine pc -nographic -smp 2 -vga none -monitor none > ./qemu_tmp/alpine.log &
PID_QEMU_ALPINE=$!
echo
clear

while true; do
    if grep -q "localhost login:" ./qemu_tmp/alpine.log; then
        echo "La VM è avviata!"
        break
    fi
    sleep 1
done

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
echo $PID_QEMU_ALPINE > ./qemu_tmp/PID_QEMU_ALPINE.pid
read -p "Press any key to stop Alpine VM..." qpid
kill -9 $PID_QEMU_ALPINE
rm -R ./qemu_tmp