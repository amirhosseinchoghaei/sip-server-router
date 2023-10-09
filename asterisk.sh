#!/bin/sh
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
GRAY='\033[0;37m'
NC='\033[0m' # No Color



echo "Running as root..."
sleep 2
clear


opkg update

opkg install asterisk asterisk-pjsip asterisk-bridge-simple asterisk-codec-alaw asterisk-codec-ulaw asterisk-res-rtp-asterisk

rm /etc/asterisk/extensions.conf
>/etc/asterisk/pjsip.conf

cd /etc/asterisk/

wget https://raw.githubusercontent.com/amirhosseinchoghaei/sip-server-router/main/extensions.conf

echo "[simpletrans]
type=transport
protocol=udp
bind=0.0.0.0

" >> /etc/asterisk/pjsip.conf

uci set asterisk.general.enabled='1'

service asterisk restart

sleep 1

service asterisk restart

sleep 1

service asterisk restart

cd

rm -f gip.sh && wget https://raw.githubusercontent.com/amirhosseinchoghaei/sip-server-router/main/gip.sh && chmod 777 gip.sh

cp gip.sh /sbin/gip

echo -e "${GREEN} Made With Love By : AmirHossein Choghaei ${NC}"
