#!/bin/bash

# THIS IS A GENERAL HARDENING SCRIPT FOR DEBIAN BASE SYSTEMS
# More hardening rescourcess:
# https://vez.mrsk.me/linux-hardening.html
# https://tails.boum.org/blueprint/harden_AppArmor_profiles/
# https://www.linuxtopia.org/LinuxSecurity/ 
# Of course many things in here can kill your system BEAWARE

# THINGS TO DO
# Add SSH Tarpit
# Add Ufw rule for outgoing traffic over only one port and proxy
# Sandboxing
# Anti sudo and privelage escalations

cd ~

# Update the system
sudo apt-get update
sudo apt-get upgrade 

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
sudo apt-get install apparmor-profiles apparmor-utils
sudo aa-enforce /etc/apparmor.d/* # This should enforce all basic rules

# Setup sandboxing with firejail
# sudo apt-get install firejail

# Disable Webcam
sudo sh -c "echo 'blacklist uvcvideo' >> /etc/modprobe.d/blacklist.conf"
# Disable Microphone, this needs to be scripted a bit
# cat /proc/asound/modules to see sound modules
# sudo sh -c "echo 'blacklist Your_driver' >> /etc/modprobe.d/blacklist.conf" to disable that module
#https://linoxide.com/linux-how-to/disable-webcam-microphone-linux/
#https://thelinuxcode.com/disable-microphone-webcam-ubuntu/

# Disable listining for open Printers
sudo systemctl disable cups-browsed

# Disable apple device communication
sudo systemctl disable avahi-daemon

# Stop x11/xorg server listening on port 6000
cd ~
touch .xserverrc
sudo sh -c "echo 'exec X -nolisten tcp' >> .xserverrc"

# Inserting hosts blocklist into the hosts file and "activating"
mkdir hosts
cd hosts
wget https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn-social/hosts
sudo cat hosts >> /etc/hosts
sudo service network-manager restart
cd ~

echo "Basic hardening finished..."
echo "To further hardening encrypt the disk,"
echo "and dont forget to harden the BIOS"
echo "Restart the System for all settings to take effect!"
