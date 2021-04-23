#!/bin/bash

read -p "Username : " Login
read -p "Password : " Pass
read -p "How many days?: " masaaktif

IP=$(wget -qO- icanhazip.com);
echo Script AutoCreate SSH and OpenVPN Account by Dope~Kid
sleep 1
echo Ping Host
echo Checking Access...
sleep 0.5
echo Permission Accepted
clear
sleep 0.5
echo Create an Account: $Login
sleep 0.5
echo Setting Password: $Pass
sleep 0.5
clear
useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
echo -e ""
echo -e "==============================="
echo -e "  ACCOUNT INFO SSH & OPENVPN"
echo -e "==============================="
echo -e "Username       : $Login "
echo -e "Password       : $Pass"
echo -e "==============================="
echo -e "IP Server      : $IP"
echo -e "OpenSSH        : 22"
echo -e "Dropbear       : 143, 109"
echo -e "SSL/TLS        : 442"
echo -e "Port Squid     : 3128, 8080 (limit to IP SSH)" 
echo -e "OpenVPN        : TCP 1194 http://$IP/Dopekid.ovpn"
echo -e "OpenVPN        : SSL 992 http://$IP/Dopekid-SSL.ovpn"
echo -e "badvpn         : 7100, 7200, 7300"
echo -e "==============================="
echo -e "Account Expiry : $exp"
echo -e "==============================="
