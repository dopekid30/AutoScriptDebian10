# AutoScriptDebian10

# Command

1. apt-get update && apt-get upgrade -y && update-grub && sleep 2 && reboot

2. apt install -y screen wget && wget https://raw.githubusercontent.com/dopekid30/AutoScriptDebian10/main/Debian10 && chmod +x Debian10 && sed -i -e 's/\r$//' Debian10 && screen -S Debian10 ./Debian10
