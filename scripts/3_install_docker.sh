#/bin/sh

echo "http://mirror1.hs-esslingen.de/pub/Mirrors/alpine/v3.10/main
http://mirror1.hs-esslingen.de/pub/Mirrors/alpine/v3.10/community
#http://mirror1.hs-esslingen.de/pub/Mirrors/alpine/edge/main
#http://mirror1.hs-esslingen.de/pub/Mirrors/alpine/edge/community
#http://mirror1.hs-esslingen.de/pub/Mirrors/alpine/edge/testing
" > /etc/apk/repositories &&

apk update &&
apk add docker openrc curl &&
rc-update add docker boot &&

curl -SL https://github.com/docker/compose/releases/download/v2.27.0/docker-compose-linux-x86_64 -o /usr/bin/docker-compose &&
chmod +x /usr/bin/docker-compose &&
clear &&
echo "
*******************************************
* Docker è stato installato correttamente *
*******************************************

N.B Per aggiungere un utente al gruppo docker
digitare:

$ adduser <username> docker

________________________________________________

"