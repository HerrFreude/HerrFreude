#!/bin/bash

# THIS IS A GENERAL HARDENING SCRIPT FOR DEBIAN BASE SYSTEMS
# More hardening rescourcess:
# https://vez.mrsk.me/linux-hardening.html
# https://tails.boum.org/blueprint/harden_AppArmor_profiles/
# https://www.linuxtopia.org/LinuxSecurity/ 
# Of course many things in here can kill your system BEAWARE

# https://wiki.archlinux.org/index.php/Xephyr can be used for nested xwindows.

# THINGS TO DO
# Add Rootles x-server/xorg
# Add Ufw rule for outgoing traffic over only one port and proxy
# Sandboxing w. firejail
# Anti sudo and privelage escalations
# Safer default priveleges
# Kernel hardening
# Enabeling apparmour with firejail
# USBGuard for better usb sec

echo "This is a generall hardening script for Debian."
echo "It will install software and insure basic security."
echo "This could harm your System, and it is advised to only run this if you are familare with the System."

function askYesNo {
        QUESTION=$1
        DEFAULT=$2
        if [ "$DEFAULT" = true ]; then
                OPTIONS="[Y/n]"
                DEFAULT="y"
            else
                OPTIONS="[y/N]"
                DEFAULT="n"
        fi
        read -p "$QUESTION $OPTIONS " -n 1 -s -r INPUT
        INPUT=${INPUT:-${DEFAULT}}
        echo ${INPUT}
        if [[ "$INPUT" =~ ^[yY]$ ]]; then
            ANSWER=true
        else
            ANSWER=false
        fi
}

askYesNo "Are you sure you want to run the security script? [Y/N]" true
DOIT=$ANSWER

if [ "$DOIT" = true ]; then

cd ~

# Update the system
sudo apt-get update
sudo apt-get upgrade 
# sudo apt-get dist-upgrade Upgrades the distribution

# Disable all wireless devices via  software(not hardware blocked)
sudo rfkill block all # rfkill list shows if everything is blocked

# Setup basic ufw firwall
# It could be hardened more by only allowing output to the DNS server for browsing
sudo apt-get install ufw
ufw logging off # Turns of logging cause I never read them anyway
sudo ufw default deny incoming # Disables all incoming connections, even SSH
sudo ufw default deny forwarding  # Disables forwarding, cause this is not a router
sudo ufw default allow outgoing 
sudo systemctl enable ufw
sudo ufw enable

# Enable apparmor and securing
sudo apt-get install apparmor apparmor-profiles apparmor-utils
sudo aa-enforce /etc/apparmor.d/* # This should enforce the rules for all currently installed programs

# Setup sandboxing with firejail 
# Verify if firejail is beeing used "firejail --list"
sudo apt-get -yy install firejail
sudo firecfg # This will setup all firejail profiles for programms on the Computer

# Loads the firejail apparmour profile into the kernel
sudo aa-enforce firejail-default 

# Disable Webcam/Videorecording devices
sudo sh -c "echo 'blacklist uvcvideo' >> /etc/modprobe.d/blacklist.conf"
# Disable Microphone, this needs to be scripted a bit
# cat /proc/asound/modules to see sound modules
# sudo sh -c "echo 'blacklist Your_driver' >> /etc/modprobe.d/blacklist.conf" to disable that module
#https://linoxide.com/linux-how-to/disable-webcam-microphone-linux/

# Disable listining for open Printers
sudo systemctl disable cups-browsed

# Disable apple device communication
sudo systemctl disable avahi-daemon

# Stop x11/xorg server listening on port 6000
cd ~
touch .xserverrc
sudo sh -c "echo 'exec X -nolisten tcp' >> .xserverrc"

# Xephyr is an aplication that allowes neseted xservers(Isolated xserver instances)
# A Xserver container can be created in firejail with:"$ firejail --x11=xephyr --net=none openbox&"
# This creates a container without web accesebility 
# For net acces run --net=eth0
# sudo apt install Xephyr


# Inserting hosts blocklist into the hosts file and "activating"
mkdir hosts
cd hosts
wget https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts
sudo cat hosts >> /etc/hosts
sudo service network-manager restart
cd ~

# Set stricter unmask permissions needs to be put in /etc/profiles
unmask 077

echo "Basic hardening finished..."
echo "To further hardening encrypt the disk,"
echo "and dont forget to harden the BIOS"
echo "Restart the System for all settings to take effect!"

fi
