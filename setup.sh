#!/bin/bash
#TEST SCRIPT

# Check Root
if [ "${EUID}" -ne 0 ]; then
echo "You need to run this script as root"
exit 1
fi

# Check System
if [ "$(systemd-detect-virt)" == "openvz" ]; then
echo "OpenVZ is not supported"
exit 1
fi

# Colours
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'

# Requirement
apt update -y
apt upgrade -y
apt dist-upgrade -y

# Install Curl
apt -y install curl

# Script Access 
MYIP=$(wget -qO- icanhazip.com);
echo -e "${green}CHECKING SCRIPT ACCESS${NC}"
IZIN=$( curl https://raw.githubusercontent.com/dopekid30/AutoScriptDebian10/main/Resources/Users/ipvps | grep $MYIP )
if [ $MYIP = $IZIN ]; then
echo -e "${green}ACCESS GRANTED...${NC}"
else
echo -e "${green}ACCESS DENIED...${NC}"
exit 1
fi

# Subdomain Settings
mkdir /var/lib/premium-script;
echo -e "${green}ENTER THE VPS SUBDOMAIN/HOSTNAME, IF NOT AVAILABLE, PLEASE CLICK ENTER${NC}"
read -p "Hostname / Domain: " host
echo "IP=$host" >> /var/lib/premium-script/ipvps.conf
echo "$host" >> /root/domain

# Install SSH/OVPN
wget https://raw.githubusercontent.com/dopekid30/AutoScriptDebian10/main/Resources/Services/ssh-vpn.sh && chmod +x ssh-vpn.sh && screen -S ssh-vpn ./ssh-vpn.sh

# Install V2ray
wget https://raw.githubusercontent.com/dopekid30/AutoScriptDebian10/main/Resources/Services/ins-vt.sh && chmod +x ins-vt.sh && sed -i -e 's/\r$//' ins-vt.sh && screen -S v2ray ./ins-vt.sh

# Remove Installation Files
rm -f /root/ssh-vpn.sh
rm -f /root/ins-vt.sh
history -c

# Script Information
echo "1.1" > /home/ver
clear
echo " "
echo "INSTALLATION HAS BEEN COMPLETED!!"
echo " "
echo "=================================-Autoscript Premium-===========================" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "--------------------------------------------------------------------------------" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Service & Port"  | tee -a log-install.txt
echo "   - OpenSSH                 : 22"  | tee -a log-install.txt
echo "   - OpenVPN                 : TCP 1194, UDP 2200, SSL 992"  | tee -a log-install.txt
echo "   - Stunnel4                : 443"  | tee -a log-install.txt
echo "   - Dropbear                : 143, 109"  | tee -a log-install.txt
echo "   - Squid Proxy             : 3128, 8080 (limit to IP Server)"  | tee -a log-install.txt
echo "   - Badvpn                  : 7100, 7200, 7300"  | tee -a log-install.txt
echo "   - Nginx                   : 81"  | tee -a log-install.txt
echo "   - Wireguard               : 7070"  | tee -a log-install.txt
echo "   - L2TP/IPSEC VPN          : 1701"  | tee -a log-install.txt
echo "   - PPTP VPN                : 1732"  | tee -a log-install.txt
echo "   - SSTP VPN                : 5555"  | tee -a log-install.txt
echo "   - Shadowsocks-R           : 1443-1543"  | tee -a log-install.txt
echo "   - SS-OBFS TLS             : 2443-2543"  | tee -a log-install.txt
echo "   - SS-OBFS HTTP            : 3443-3453"  | tee -a log-install.txt
echo "   - V2RAY Vmess TLS         : 4443"  | tee -a log-install.txt
echo "   - V2RAY Vmess None TLS    : 80"  | tee -a log-install.txt
echo "   - V2RAY Vless TLS         : 5443"  | tee -a log-install.txt
echo "   - V2RAY Vless None TLS    : 880"  | tee -a log-install.txt
echo "   - Trojan                  : 6443"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Server Information & Other Features"  | tee -a log-install.txt
echo "   - Timezone                : Asia/Jakarta (GMT +7)"  | tee -a log-install.txt
echo "   - Fail2Ban                : [ON]"  | tee -a log-install.txt
echo "   - Dflate                  : [ON]"  | tee -a log-install.txt
echo "   - IPtables                : [ON]"  | tee -a log-install.txt
echo "   - Auto-Reboot             : [ON]"  | tee -a log-install.txt
echo "   - IPv6                    : [OFF]"  | tee -a log-install.txt
echo "   - Autoreboot On 00.00 GMT +7" | tee -a log-install.txt
echo "   - Autobackup Data" | tee -a log-install.txt
echo "   - Restore Data" | tee -a log-install.txt
echo "   - Auto Delete Expired Account" | tee -a log-install.txt
echo "   - White Label" | tee -a log-install.txt
echo "   - Installation Log --> /root/log-install.txt"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   - Dev/Main                : Horas Marolop Amsal Siregar"  | tee -a log-install.txt
echo "   - Telegram                : T.me/Horasss"  | tee -a log-install.txt
echo "   - Instagram               : @horas_96"  | tee -a log-install.txt
echo "   - Whatsapp                : 082386143124"  | tee -a log-install.txt
echo "   - Facebook                : https://www.facebook.com/Marlosirega" | tee -a log-install.txt
echo "--------------------------------------------------------------------------------" | tee -a log-install.txt
echo ""
echo " REBOOT SYSTEM 10 SECONDS"
sleep 10
rm -f setup.sh
reboot
