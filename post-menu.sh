#!/bin/bash
#
# MENU FOR ARCH-INSTALLER
#
# i3-Arch
##############################

setfont Lat2-Terminus16
red="$(tput setaf 1)"
white="$(tput setaf 7)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"

# SETTING THINGS UP FIRST
clear
cd "$HOME"

DATCHOICE=3
until [ "$DATCHOICE" -eq 4 ]
do
	clear
	echo -e "\033[1m ${red} \n\n TAKE YOUR PICK \n\033[0m"
	echo -e "\033[1m ${green}\n\n  Make Sure You RUN Post-Install Before Installing 'ANOTHER' WM/DE\n\033[0m"
	echo -e " \033[1m ${red}1)${white}\033[1m VIEW Post-Install Script \033[0m"
	echo -e " \033[1m ${red}2)${white}\033[1m RUN Post-Install script \033[0m"
	echo -e " \033[1m ${red}3)${white}\033[1m VIEW another.sh \033[0m"
	echo -e " \033[1m ${red}4)${white}\033[1m Install Another WM/DE \033[0m"
	echo -e " \033[1m ${red}5)${white}\033[1m Exit\033[0m"
	read DATCHOICE

case "$DATCHOICE" in
	1) echo -e "\033[1m ${yellow} #${white}Paranoid\033[0m" && cat post-install.sh|less ;;
	2) echo -e "\033[1m ${yellow} #${white}Swag\033[0m" && source post-install.sh ;;
	3) echo -e "\033[1m ${yellow} #${white}Paranoid\033[0m" && cat another.sh|less ;;
	4) echo -e "\033[1m ${yello2} #${white}StillSwaggin\033[0m" && source another.sh ;;
	5) echo -e "\033[1m ${yellow} HOPE YOU ENJOY... Rebooting Now\033[0m" && rm post-install.sh another.sh post-menu.sh && $(reboot) ;;
	*) echo -e "\033[1m ${yellow} invalid option ${red} try again\033[0m"
esac

echo -e "\033[1m ${green}\n\nPress ${red}Enter${green} to Continue\033[0m"
read Enter
done
