#!/bin/bash
#
#
# 	Authors  ::->>  i3-Arch,  trewchainz, t60r  <<-::
#
#		Made to install archlinux
#
#
############################################

# Grab var values
# Which are: yourdrive, rewtpart, swappart, homepart, bootpart, thechoiceman
source config.sh

# COLORS
red=$(tput setaf 1)
white=$(tput setaf 7)
green=$(tput setaf 2)
yellow=$(tput setaf 3)

# Set Your Hostname
hostname() {
	clear
	printf "\033[1m \n ${yellow}Choose your hostname: ${white} \033[0m"
	read hostresponse
	echo "$hostresponse" > /etc/hostname
}

# Set Time Zone
timelocale() {
	clear
	printf "\033[1m \n ${yellow}     Enter your Time Zone ${white}\n \033[0m"
	printf "\033[1m \n ${red}CHOICES ARE: ${white}New York ${green}or ${white}Athens \n \033[0m"
	printf "\033[1m \n ${yellow}Sorry I didnt do all timezones yet\n \n \033[0m"
	printf "\033[1m \n ${white}ENTER ${green}(1)${red}for Eastern \n \033[0m"
	printf "\033[1m${white}ENTER ${green}(2)${red}for Central \n \033[0m"
	printf "\033[1m${white}ENTER ${green}(3)${red}for Pacific\n \033[0m"
	printf "\033[1m \n ${white} Choice: \033[0m"
	read timezoneresponse
	if [  "$timezoneresponse" -eq 1 ]
		then
			$(ln -s /usr/share/zoneinfo/US/Eastern /etc/localtime) ;
	elif [ "$timezoneresponse" -eq 2 ]
		then
			$(ln -s /usr/share/zoneinfo/US/Central /etc/localtime) ;
	elif	[ "$timezoneresponse" -eq 3 ]
		then
			$( ln -s /usr/share/zoneinfo/US/Pacific /etc/localtime) ;
	else
		printf "\033[1m ${red}Not Understood | do it yourself |  with 'ln -s'\n\033[0m"
	fi
	clear
	printf "\033[1m \n\n${white}YOU NOW NEED TO UNCOMMENT A LOCALE\n \033[0m"
	printf "\033[1m \n${green}Would you like to use default locale or choose your own? \n\n \033[0m"
	printf "\033[1m ${white}Default locale is ${red}en_US.UTF-8 UTF-8 \n\n \033[0m"
	printf "\033[1m \n${yellow}(Y)${green} for default locale \n${yellow}(N) ${green}for choose your own \n \033[0m"
	printf "\033[1m \n ${white}Choice: \033[0m"
	read inputscuzlocale
	if [ "$inputscuzlocale" == y -o "$inputscuzlocale" == Y ]
		then
			echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
	else
		nano /etc/locale.gen
	fi
	printf "\033[1m ${green}NOW GENERATING LOCALES...\n \033[0m"
	locale-gen
}

# Install Grub
grubinst() {										
	grub-install --target=i386-pc $yourdrive
	grub-mkconfig -o /boot/grub/grub.cfg
	sed -i '112,147d' /boot/grub/grub.cfg
}

# Install Syslinux
syslinuxinst() {
	pacman -Syy syslinux --noconfirm
	syslinux-install_update -i -a -m
	sed -i '54s@.*@    APPEND root='"$rewtpart"' rw @' /boot/syslinux/syslinux.cfg
	sed -i '57,61d' /boot/syslinux/syslinux.cfg
}

# Choose Your Bootloader
BOOTload() {
	printf "\033[1m \n ${white} CHOOSE YOUR BOOTLOADER \n \033[0m"
	printf "\033[1m \n ${white}(1) ${red}For Grub \n \033[0m"
	printf "\033[1m \n ${white}(2) ${red}For SysLinux \n \033[0m"
	printf "\033[1m \n ${yellow}CHOICE: ${white}\033[0m"
	read bootloadchoice
	if [ "$bootloadchoice" -eq 1 ]
		then
			grubinst
	elif [ "$bootloadchoice" -eq 2 ]
		then
			syslinuxinst
	else
		printf "\033[1m ${red}Not Understood ${white}|${red} Setting up grub by default \033[0m"
		grubinst
	fi
}	

localeStuff() {
	locale > /etc/locale.conf  # set systemwide locale's
}

setLUKSmkinitcpio() {
	sed -e "52s/keyboard//" /etc/mkinitcpio.conf
	sed -e "52s/filesystems/keyboard encrypt filesystems/" /etc/mkinitcpio.conf
}

setLUKSgrub() {
	echo 'crypdevice=$rewtpart:cryptroot' >> /boot/grub/grub.cfg
}

setCrypttab() {
	echo 'home $homepart none luks' >> /etc/crypttab
	if [ leetchoice = true ]
		then
		echo 'cryptswap			/dev/sda4			/dev/urandom		swap,cipher=aes-cbc-essiv:sha256,size=256' >> /etc/crpyttab
	fi
}

# Main Function
main() {
	hostname
	timelocale
	BOOTload
	localeStuff
	rm chrootnset.sh config.sh #cleanup
	exit
}

main

#EOF
