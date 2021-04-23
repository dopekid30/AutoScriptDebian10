#!/bin/bash

clear
echo -e ""
echo -e "======================================"
echo -e "     [1]  AutoKill After 1 Minutes    "
echo -e "     [2]  AutoKill After 15 Minutes   "
echo -e "     [3]  AutoKill After 30 Minutes   "
echo -e "     [4]  Turn Off AutoKill/MultiLogin"
echo -e "     [x]  Exit                        "
echo -e "======================================"                                                                                                          
echo -e ""
read -p "     Select From Options [1-4 or x] :  " AutoKill
echo -e ""
case $AutoKill in
                1)
                echo -e ""
                sleep 1
                clear
                rm -f /etc/cron.d/tendang
                echo "*/1 * * * *  root /usr/bin/tendang" > /etc/cron.d/tendang
                echo -e ""
                echo -e "======================================"
                echo -e "      Allowed MultiLogin : 2          "
                echo -e "      AutoKill Every     : 1 Minutes  "     
                echo -e "======================================"                                                                                                                                 
                exit                                                                  
                ;;
                2)
                echo -e ""
                sleep 1
                clear
                rm -f /etc/cron.d/tendang
                echo "*/5 * * * *  root /usr/bin/tendang" > /etc/cron.d/tendang
                echo -e ""
                echo -e "======================================"
                echo -e "      Allowed MultiLogin : 2          "
                echo -e "      AutoKill Every     : 15 Minutes "
                echo -e "======================================"
                exit
                ;;
                3)
                echo -e ""
                sleep 1
                clear
                rm -f /etc/cron.d/tendang
                echo "*/5 * * * *  root /usr/bin/tendang" > /etc/cron.d/tendang
                echo -e ""
                echo -e "======================================"
                echo -e "      Allowed MultiLogin : 2          "
                echo -e "      AutoKill Every     : 30 Minutes "
                echo -e "======================================"
                ;;
                4)
                clear
                rm -f /etc/cron.d/tendang
                echo -e ""
                echo -e "======================================"
                echo -e "      AutoKill MultiLogin Turned Off  "
                echo -e "======================================"
                exit
                ;;
                x)
                clear
                exit
                ;;
        esac
