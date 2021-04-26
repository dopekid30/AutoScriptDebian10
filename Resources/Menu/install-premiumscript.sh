#!/bin/bash
# Created by https://www.facebook.com/joash.singh.90
# Script by Dope~kid

cd
echo "0 0 * * * root /usr/local/bin/user-expire" > /etc/cron.d/user_expire
echo "0 0 * * * root /usr/local/bin/delete-expired" > /etc/cron.d/delete_expired
echo "0 0 * * * root /usr/local/bin/reset-panel" > /etc/cron.d/reset_panel
echo "0 0 * * * root /usr/local/bin/xp-ws" > /etc/cron.d/expire_vmess
echo "0 0 * * * root /usr/local/bin/xp-vless" > /etc/cron.d/expire_vless

cd /usr/local/bin
wget -O premium-script.tar.gz "https://raw.githubusercontent.com/dopekid30/AutoScriptDebian10/main/Resources/Menu/premium-script.tar.gz"
tar -xvf premium-script.tar.gz
rm -f premium-script.tar.gz

cp /usr/local/bin/menu /usr/bin/menu
cp /usr/local/bin/menu /usr/bin/Menu

chmod +x /usr/local/bin/user-add
chmod +x /usr/local/bin/user-generate
chmod +x /usr/local/bin/trail
chmod +x /usr/local/bin/user-active
chmod +x /usr/local/bin/user-password
chmod +x /usr/local/bin/user-delete
chmod +x /usr/local/bin/user-detail
chmod +x /usr/local/bin/user-list
chmod +x /usr/local/bin/user-login
chmod +x /usr/local/bin/autokill
chmod +x /usr/local/bin/add-ws
chmod +x /usr/local/bin/del-ws
chmod +x /usr/local/bin/renew-ws
chmod +x /usr/local/bin/check-ws
chmod +x /usr/local/bin/add-vless
chmod +x /usr/local/bin/del-vless
chmod +x /usr/local/bin/renew-vless
chmod +x /usr/local/bin/check-vless
chmod +x /usr/local/bin/speedtest
chmod +x /usr/local/bin/ram
chmod +x /usr/local/bin/edit-port
chmod +x /usr/local/bin/auto-reboot
chmod +x /usr/local/bin/log-install
chmod +x /usr/local/bin/simple-panel
chmod +x /usr/local/bin/v2ray-cert
chmod +x /usr/local/bin/about
chmod +x /usr/local/bin/diagnosis
chmod +x /usr/local/bin/autokillssh
chmod +x /usr/local/bin/edit-port-dropbear
chmod +x /usr/local/bin/edit-port-openssh
chmod +x /usr/local/bin/edit-port-openvpn
chmod +x /usr/local/bin/edit-port-squid
chmod +x /usr/local/bin/delete-expired
chmod +x /usr/local/bin/reset-panel
chmod +x /usr/local/bin/xp-vless
chmod +x /usr/local/bin/xp-ws
chmod +x /usr/local/bin/user-expire
chmod +x /usr/local/bin/menu
chmod +x /usr/bin/Menu
chmod +x /usr/bin/menu
clear
cd
echo " "
echo " "
echo "PREMIUM SCRIPT SUCCESSFULLY INSTALLED!"
echo "SCRIPT BY DOPE~KID"
echo "PLEASE WAIT..."
echo " "
