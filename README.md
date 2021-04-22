# AutoScriptDebian10

# Command

1. apt-get update && apt-get upgrade -y && update-grub && sleep 2 && reboot

2. sysctl -w net.ipv6.conf.all.disable_ipv6=1 && sysctl -w net.ipv6.conf.default.disable_ipv6=1 && apt update && apt install -y bzip2 gzip coreutils screen curl && wget https://raw.githubusercontent.com/dopekid30/AutoScriptDebian10/main/setup.sh && chmod +x setup.sh && sed -i -e 's/\r$//' setup.sh && screen -S setup ./setup.sh
