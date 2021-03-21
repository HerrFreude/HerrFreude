#!/bin/bash

# Fast setup script for my basic utensils
# wget https://raw.githubusercontent.com/HerrFreude/HerrFreude/main/scripts/setup.sh
# chmod u+x setup.sh && ./setup.sh

# Making the system ready for install 
cd ~
sudo apt-get update -qq
sudo apt-get upgrade -qq

# Installing basic software utilities
sudo apt-get install -yy neovim
sudo apt-get install -yy acpi
sudo apt-get install -yy alsa-utlis
sudo apt-get install -yy htop
sudo apt-get install -yy git

# Installing media utilities
sudo apt-get install -yy zathura
sudo apt-get install -yy newsboat
sudo apt-get install -yy feh
sudo apt-get install -yy mpv
sudo apt-get install -yy cmus

# Installing LaTeX utils (for pdf document just "pdflatex" the filename)
# sudo apt-get install -yy texlive

# Instaling build and other dependencies
sudo apt-get install -yy xorg
sudo apt-get install -yy build-essentials
sudo apt-get install -yy suckless-tools libx11-dev libxinerama-dev libxft-dev # dwm dependencies
#sudo apt-get install -yy libwebkit2gtk-4.0-dev # Surf dependencies

# Download my configs n stuff
git clone https://github.com/HerrFreude/HerrFreude.git

# Put configs where they belong
cd ~/HerrFreude/dotfiles 
mv -f .xinitrc ~
mv -f .bashrc ~
mv -f .Xresources ~
mv -f .cwmrc ~

cd ~

# Install the calm windowmanager
#sudo apt-get install -yy cwm

# Get dwm and build dwm
#git clone https://git.suckless.org/dwm
#cd dwm
#sudo make clean install
#cd ~

#mv -f ~/HerrFreude/dotfiles/dwm/config.h ~/dwm/

#cd dwm
#sudo make clean install
#cd ~

# Install a screenlocker
git clone https://git.suckless.org/slock
cd slock
sudo make clean install
cd ~

# Install dmenu
#git clone https://git.suckless.org/dmenu
#cd dmenu 
#sudo make clean install
#cd ~ 

# Install surf-browser
#git clone https://git.suckless.org/surf
#cd surf
#sudo make clean install
#cd ~

# Show me that the Work is done
echo "System is ready, you lazy rectum."

# Restart the system 

sudo shutdown -r

