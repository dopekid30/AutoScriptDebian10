#!/bin/bash
# Created by https://www.facebook.com/joash.singh.90
# Script by Dope~kid

# Requirement
apt-get -y update && apt-get -y upgrade
apt-get -y install curl

# Initializing IP
export DEBIAN_FRONTEND=noninteractive
MYIP=$(wget -qO- ifconfig.co);
MYIP2="s/xxxxxxxxx/$MYIP/g";
NET=$(ip -o $ANU -4 route show to default | awk '{print $5}');
source /etc/os-release
ver=$VERSION_ID

# Stunnel Cert Info
country=South Africa
state=Africa
locality=Durban
organization=DopekidVPN
organizationalunit=DopekidVPN
commonname=DopekidVPN
email=joashsingh14@gmail.com

# Password Setup
wget -O /etc/pam.d/common-password "https://raw.githubusercontent.com/dopekid30/AutoScriptDebian10/main/Resources/Other/password"
chmod +x /etc/pam.d/common-password

# Goto Root
cd

# System Setup
cat > /etc/systemd/system/rc-local.service <<-END
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
[Install]
WantedBy=multi-user.target
END

# Reboot Settings
cat > /etc/rc.local <<-END
#!/bin/sh -e
# rc.local
# By default this script does nothing.
exit 0
END

# Set Permissions
chmod +x /etc/rc.local

# Enable On Reboot
systemctl enable rc-local
systemctl start rc-local.service

# Disable IPV6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local

# Install Components
apt-get --reinstall --fix-missing install -y bzip2 gzip coreutils rsyslog iftop htop net-tools zip unzip nano sed screen gnupg gnupg1 gnupg2 bc apt-transport-https build-essential dirmngr libxml-parser-perl neofetch git
apt-get -y install libio-pty-perl libauthen-pam-perl apt-show-versions libnet-ssleay-perl

# Set System Time
ln -fs /usr/share/zoneinfo/Africa/Johannesburg /etc/localtime

# Set Sshd
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config

# NeoFetch
echo "clear" >> .profile
echo "neofetch" >> .profile
echo "echo by LostServer" >> .profile

# Install Webserver
apt -y install nginx
cd
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
wget -O /etc/nginx/nginx.conf "https://raw.githubusercontent.com/dopekid30/AutoScriptDebian10/main/Resources/Other/nginx.conf"
mkdir -p /home/vps/public_html
echo "<pre>SETUP BY DOPEKID</pre>" > /home/vps/public_html/index.html
wget -O /etc/nginx/conf.d/vps.conf "https://raw.githubusercontent.com/dopekid30/AutoScriptDebian10/main/Resources/Other/vps.conf"
/etc/init.d/nginx restart

# Install Badvpn
cd
wget -O /usr/bin/badvpn-udpgw "https://raw.githubusercontent.com/dopekid30/AutoScriptDebian10/main/Resources/Other/badvpn-udpgw64"
chmod +x /usr/bin/badvpn-udpgw
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500' /etc/rc.local
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500

# Setup SSH
sed -i 's/Port 22/Port 22/g' /etc/ssh/sshd_config

# Install Dropbear
apt -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=143/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 109"/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
/etc/init.d/dropbear restart

# Install Squid Proxy
cd
apt -y install squid3
wget -O /etc/squid/squid.conf "https://raw.githubusercontent.com/dopekid30/AutoScriptDebian10/main/Resources/Other/squid3.conf"
sed -i $MYIP2 /etc/squid/squid.conf

# Install Webmin
wget "https://raw.githubusercontent.com/dopekid30/AutoScriptDebian10/main/Resources/Other/webmin_1.801_all.deb"
dpkg --install webmin_1.801_all.deb;
apt-get -y -f install;
sed -i 's/ssl=1/ssl=0/g' /etc/webmin/miniserv.conf
rm /root/webmin_1.801_all.deb
/etc/init.d/webmin restart

# Webmin Configuration
sed -i '$ i\dope: acl adsl-client ajaxterm apache at backup-config bacula-backup bandwidth bind8 burner change-user cluster-copy cluster-cron cluster-passwd cluster-shell cluster-software cluster-useradmin cluster-usermin cluster-webmin cpan cron custom dfsadmin dhcpd dovecot exim exports fail2ban fdisk fetchmail file filemin filter firewall firewalld fsdump grub heartbeat htaccess-htpasswd idmapd inetd init inittab ipfilter ipfw ipsec iscsi-client iscsi-server iscsi-target iscsi-tgtd jabber krb5 ldap-client ldap-server ldap-useradmin logrotate lpadmin lvm mailboxes mailcap man mon mount mysql net nis openslp package-updates pam pap passwd phpini postfix postgresql ppp-client pptp-client pptp-server proc procmail proftpd qmailadmin quota raid samba sarg sendmail servers shell shorewall shorewall6 smart-status smf software spam squid sshd status stunnel syslog-ng syslog system-status tcpwrappers telnet time tunnel updown useradmin usermin vgetty webalizer webmin webmincron webminlog wuftpd xinetd' /etc/webmin/webmin.acl
sed -i '$ i\dope:x:0' /etc/webmin/miniserv.users
/usr/share/webmin/changepass.pl /etc/webmin dope 12345

# Install Stunnel
apt install stunnel4 -y
cat > /etc/stunnel/stunnel.conf <<-END
cert = /etc/stunnel/stunnel.pem
client = no
socket = a:SO_REUSEADDR=1
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1

[dropbear]
accept = 442
connect = 127.0.0.1:109

[openvpn]
accept = 992
connect = 127.0.0.1:1194

END

# Make Stunnel Certificate 
openssl genrsa -out key.pem 2048
openssl req -new -x509 -key key.pem -out cert.pem -days 1095 \
-subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$commonname/emailAddress=$email"
cat key.pem cert.pem >> /etc/stunnel/stunnel.pem

# Configuration Stunnel
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
/etc/init.d/stunnel4 restart

# Install OpenVPN
apt install openssl iptables iptables-persistent -y
wget -O /etc/openvpn/vpn.zip "https://raw.githubusercontent.com/dopekid30/AutoScriptDebian10/main/Resources/Other/vpn.zip"
cd /etc/openvpn/
unzip vpn.zip
rm -f vpn.zip
cd
mkdir -p /usr/lib/openvpn/
cp /usr/lib/x86_64-linux-gnu/openvpn/plugins/openvpn-plugin-auth-pam.so /usr/lib/openvpn/openvpn-plugin-auth-pam.so

# OpenVPN IPV4 Fowarding
echo 1 > /proc/sys/net/ipv4/ip_forward
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf

# OpenVPN Firewall Settings
iptables -t nat -I POSTROUTING -s 10.6.0.0/24 -o $ANU -j MASQUERADE
iptables -t nat -I POSTROUTING -s 10.7.0.0/24 -o $ANU -j MASQUERADE
iptables-save > /etc/iptables.up.rules
chmod +x /etc/iptables.up.rules

iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload

# Iptables Settings
cat > /etc/network/if-up.d/iptables <<-END
iptables-restore < /etc/iptables.up.rules
iptables -t nat -A POSTROUTING -s 10.6.0.0/24 -o $ANU -j SNAT --to xxxxxxxxx
iptables -t nat -A POSTROUTING -s 10.7.0.0/24 -o $ANU -j SNAT --to xxxxxxxxx
END
sed -i $MYIP2 /etc/network/if-up.d/iptables
chmod +x /etc/network/if-up.d/iptables

# Restart OpenVPN
systemctl enable openvpn
systemctl start openvpn
/etc/init.d/openvpn restart
/etc/init.d/openvpn status

# Openvpn Config
cat > /home/vps/public_html/Dopekid.ovpn <<-END
# OpenVPN Configuration By Dopekid

client
dev tun
proto tcp
remote $MYIP 1194
http-proxy $MYIP 8080
remote-cert-tls server
resolv-retry infinite
nobind
tun-mtu 1500
mssfix 1500
persist-key
persist-tun
ping-restart 0
ping-timer-rem
reneg-sec 0
comp-lzo
auth SHA512
auth-user-pass
auth-nocache
cipher AES-256-CBC
verb 3
pull

END
echo '<ca>' >> /home/vps/public_html/Dopekid.ovpn
cat /etc/openvpn/keys/ca.crt >> /home/vps/public_html/Dopekid.ovpn
echo '</ca>' >> /home/vps/public_html/Dopekid.ovpn

# Openvpn SSL Config
cat > /home/vps/public_html/Dopekid SSL.ovpn <<-END
# OpenVPN SSL Configuration By Dopekid

client
dev tun
proto tcp
remote $MYIP 992
remote-cert-tls server
resolv-retry infinite
nobind
tun-mtu 1500
mssfix 1500
persist-key
persist-tun
ping-restart 0
ping-timer-rem
reneg-sec 0
comp-lzo
auth SHA512
auth-user-pass
auth-nocache
cipher AES-256-CBC
verb 3
pull

END
echo '<ca>' >> /home/vps/public_html/Dopekid SSL.ovpn
cat /etc/openvpn/keys/ca.crt >> /home/vps/public_html/Dopekid SSL.ovpn
echo '</ca>' >> /home/vps/public_html/Dopekid SSL.ovpn

# Install Fail2ban
apt -y install fail2ban

# SSH/Dropbear Banner
wget -O /etc/issue.net "https://raw.githubusercontent.com/dopekid30/AutoScriptDebian10/main/Resources/Other/bannerssh.conf"
echo "Banner /etc/issue.net" >>/etc/ssh/sshd_config
sed -i 's@DROPBEAR_BANNER=""@DROPBEAR_BANNER="/etc/issue.net"@g' /etc/default/dropbear

# Update BBR
wget https://raw.githubusercontent.com/dopekid30/AutoScriptDebian10/main/Resources/Other/bbr.sh && chmod +x bbr.sh && ./bbr.sh
wget https://raw.githubusercontent.com/dopekid30/AutoScriptDebian10/main/Resources/Other/set-br.sh && chmod +x set-br.sh && ./set-br.sh

# Block Torrents
iptables -A FORWARD -m string --string "get_peers" --algo bm -j DROP
iptables -A FORWARD -m string --string "announce_peer" --algo bm -j DROP
iptables -A FORWARD -m string --string "find_node" --algo bm -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
iptables -A FORWARD -m string --algo bm --string "peer_id=" -j DROP
iptables -A FORWARD -m string --algo bm --string ".torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
iptables -A FORWARD -m string --algo bm --string "torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce" -j DROP
iptables -A FORWARD -m string --algo bm --string "info_hash" -j DROP
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload

# Download Script
cd /usr/bin
wget -O addhost "https://raw.githubusercontent.com/dopekid30/AutoScriptDebian10/main/Resources/Menu/addhost.sh"
wget -O about "https://raw.githubusercontent.com/dopekid30/AutoScriptDebian10/main/Resources/Menu/about.sh"
wget -O menu "https://raw.githubusercontent.com/dopekid30/AutoScriptDebian10/main/Resources/Menu/menu.sh"
wget -O usernew "https://raw.githubusercontent.com/dopekid30/AutoScriptDebian10/main/Resources/Menu/usernew.sh"
wget -O trial "https://raw.githubusercontent.com/dopekid30/AutoScriptDebian10/main/Resources/Menu/trial.sh"
wget -O deluser "https://raw.githubusercontent.com/dopekid30/AutoScriptDebian10/main/Resources/Menu/deluser.sh"
wget -O users "https://raw.githubusercontent.com/dopekid30/AutoScriptDebian10/main/Resources/Menu/users.sh"
wget -o webmin "https://raw.githubusercontent.com/dopekid30/AutoScriptDebian10/main/Resources/Menu/webmin.sh"
wget -O delete "https://raw.githubusercontent.com/dopekid30/AutoScriptDebian10/main/Resources/Menu/delete.sh"
wget -O cek "https://raw.githubusercontent.com/dopekid30/AutoScriptDebian10/main/Resources/Menu/cek.sh"
wget -O restart "https://raw.githubusercontent.com/dopekid30/AutoScriptDebian10/main/Resources/Menu/restart.sh"
wget -O speedtest "https://raw.githubusercontent.com/dopekid30/AutoScriptDebian10/main/Resources/Menu/speedtest_cli.py"
wget -O info "https://raw.githubusercontent.com/dopekid30/AutoScriptDebian10/main/Resources/Menu/info.sh"
wget -O ram "https://raw.githubusercontent.com/dopekid30/AutoScriptDebian10/main/Resources/Menu/ram.sh"
wget -O renew "https://raw.githubusercontent.com/dopekid30/AutoScriptDebian10/main/Resources/Menu/renew.sh"
wget -O autokill "https://raw.githubusercontent.com/dopekid30/AutoScriptDebian10/main/Resources/Menu/autokill.sh"
wget -O ceklim "https://raw.githubusercontent.com/dopekid30/AutoScriptDebian10/main/Resources/Menu/ceklim.sh"
wget -O tendang "https://raw.githubusercontent.com/dopekid30/AutoScriptDebian10/main/Resources/Menu/tendang.sh"
wget -O clear-log "https://raw.githubusercontent.com/dopekid30/AutoScriptDebian10/main/Resources/Menu/clear-log.sh"

# Clear Logs
echo "0 0 * * * root clear-log" >> /etc/crontab

# Script Permissions
chmod +x addhost
chmod +x menu
chmod +x usernew
chmod +x trial
chmod +x deluser
chmod +x users
chmod +x delete
chmod +x webmin
chmod +x cek
chmod +x restart
chmod +x speedtest
chmod +x info
chmod +x about
chmod +x autokill
chmod +x tendang
chmod +x ceklim
chmod +x ram
chmod +x renew
chmod +x clear-log

# Purge Unnecessary Files
apt -y autoclean
apt -y remove --purge unscd
apt-get -y --purge remove samba*;
apt-get -y --purge remove apache2*;
apt-get -y --purge remove bind9*;
apt-get -y remove sendmail*
apt -y autoremove

# Restarting Services
cd
chown -R www-data:www-data /home/vps/public_html
/etc/init.d/nginx restart
/etc/init.d/openvpn restart
/etc/init.d/cron restart
/etc/init.d/ssh restart
/etc/init.d/dropbear restart
/etc/init.d/fail2ban restart
/etc/init.d/webmin restart
/etc/init.d/stunnel4 restart
/etc/init.d/squid restart
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500

# Finishing
history -c
echo "unset HISTFILE" >> /etc/profile
cd
rm -f /root/ssh-vpn.sh
