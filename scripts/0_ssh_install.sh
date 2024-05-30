#!/bin/bash

USER=$(whoami)
PASS=password


pkg up -y
pkg install openssh termux-auth -y

echo "Insert password per l'utente ${USER}"
passwd
sshd
echo "Login as ${USER}
$ ssh ${USER}@server -p 2022"
