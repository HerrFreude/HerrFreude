#!/bin/bash

# This is a realy basic fetch script, I basically only made for myself

# Getting the Username
user=$(id -un)

# Getting the Distro name
distro=$(lsb_release -sd)

# Getting Kernel version
kernel=$(uname -r)

# Getting the Windowmanger's name
get_wm() {
	# This script uses xprop to Display the windowmanger name, cause it is one of the more simpler implementations.
	id=$(xprop -root -notype _NET_SUPPORTING_WM_CHECK)
        id=${id##* }

	wm=$(xprop -id "$id" -notype -len 25 -f _NET_WM_NAME 8t)
}

#gnu=$(echo " ＼(*^▽^*)/ Sweet freedom")

#systemd=$(echo " Looks like you use SystemD/Linux (つ﹏⊂)")

blue=$(tput setaf 187)
normal=$(tput setaf 253)

clear

#printf '%s\n' "
# ${normal}ᕬ⠀ᕬ
#（'-')
#.-U-U----------------------------------. 
 #${blue}os ${normal}~ ${distro}
 #${blue}wm ${normal}~ ${wm}
 #${blue}kr ${normal}~ ${kernel} ${blue}
 #"

printf '%s\n' " ${blue}
     _.-._	  
   .´ o   '. 
 .' o    ö  '.
 :___________* 
${blue}   ':|●.●|'     os ${normal}~ GNU/Ted KaczynskiOS 
${blue}     |   |=     wm ${normal}~ ${wm}cwm
${blue}     |,  |      kr ${normal}~ ${kernel} ${blue}
     |  :| 
"
#if [ ! -d /usr/bin/systemd ]; then
#	printf '%s\n' "${systemd}"
#	echo " "
#	else
#	printf '%s\n' "${gnu} ${user}!"
#	echo " "
#fi
