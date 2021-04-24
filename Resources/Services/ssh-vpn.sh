#!/bin/bash
# Created by https://www.facebook.com/joash.singh.90
# Script by Dope~kid

# Initializing IP
export DEBIAN_FRONTEND=noninteractive
MYIP=$(wget -qO- ifconfig.co);
MYIP2="s/xxxxxxxxx/$MYIP/g";
NET=$(ip -o $ANU -4 route show to default | awk '{print $5}');
source /etc/os-release
ver=$VERSION_ID

# Stunnel Cert Info
country=ID
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

# Set Repo
sh -c 'echo "deb http://download.webmin.com/download/repository sarge contrib" > /etc/apt/sources.list.d/webmin.list'
apt install gnupg gnupg1 gnupg2 -y
wget http://www.webmin.com/jcameron-key.asc
apt-key add jcameron-key.asc

# Update
apt update -y
apt upgrade -y
apt dist-upgrade -y

# Install Wget And Curl
apt -y install wget curl

# Install Components
apt-get -y install libio-pty-perl libauthen-pam-perl apt-show-versions libnet-ssleay-perl

# Set System Time
ln -fs /usr/share/zoneinfo/Africa/Johannesburg /etc/localtime

# Set Sshd
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config

# NeoFetch
apt-get --reinstall --fix-missing install -y bzip2 gzip coreutils wget screen rsyslog iftop htop net-tools zip unzip wget net-tools curl nano sed screen gnupg gnupg1 bc apt-transport-https build-essential dirmngr libxml-parser-perl neofetch git
echo "clear" >> .profile
echo "neofetch" >> .profile
echo "echo Script By Dope-Kid" >> .profile
echo "echo Type 'menu' to list commands" >> .profile

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
cat > /etc/squid/squid.conf <<-END
acl manager proto cache_object
acl localhost src 127.0.0.1/32 ::1
acl to_localhost dst 127.0.0.0/8 0.0.0.0/32 ::1
acl SSL_ports port 442
acl Safe_ports port 80
acl Safe_ports port 21
acl Safe_ports port 443
acl Safe_ports port 70
acl Safe_ports port 210
acl Safe_ports port 1025-65535
acl Safe_ports port 280
acl Safe_ports port 488
acl Safe_ports port 591
acl Safe_ports port 777
acl CONNECT method CONNECT
acl SSH dst xxxxxxxxx
http_access allow SSH
http_access allow manager localhost
http_access deny manager
http_access allow localhost
http_access deny all
http_port 8080
http_port 3128
coredump_dir /var/spool/squid3
refresh_pattern ^ftp: 1440 20% 10080
refresh_pattern ^gopher: 1440 0% 1440
refresh_pattern -i (/cgi-bin/|\?) 0 0% 0
refresh_pattern . 0 20% 4320
visible_hostname Dopekid
END
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
apt -y install stunnel4
cat > /etc/stunnel/stunnel.conf <<-END
cert = /etc/stunnel/stunnel.pem
client = no
socket = a:SO_REUSEADDR=1
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1

[dropbear]
accept = 442
connect = 127.0.0.1:109

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
apt -y install openvpn iptables iptables-persistent -y
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

# Firewall Settings
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

# Install Fail2ban
apt -y install fail2ban

# SSH/Dropbear Banner
wget -O /etc/issue.net "https://raw.githubusercontent.com/dopekid30/AutoScriptDebian10/main/Resources/Other/banner"
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

# Clear Logs
echo "0 0 * * * root /usr/bin/clear-log" > /etc/cron.d/clear_logs

# Purge Unnecessary Files
apt -y autoclean
apt -y remove --purge unscd
apt-get -y --purge remove samba*;
apt-get -y --purge remove apache2*;
apt-get -y --purge remove bind9*;
apt-get -y remove sendmail*

# Stop Nginx Port 80
service nginx stop

# Install V2ray
wget https://raw.githubusercontent.com/dopekid30/AutoScriptDebian10/main/Resources/Services/ins-vt.sh && chmod +x ins-vt.sh && sed -i -e 's/\r$//' ins-vt.sh && screen -S v2ray ./ins-vt.sh

# Restarting Services
cd
chown -R www-data:www-data /home/vps/public_html
/etc/init.d/nginx start
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
