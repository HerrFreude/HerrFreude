# Set Wallpaper
~/.fehbg &

# Set lower screen brightness
xrandr --output DVI-I-1 --brightness 1

# Set Bluelight filter
redshift -O 3000 

# Load .Xresources
xrdb -merge ~/.Xresources

# Dwm statusbar script
while true 
do
	#reset bar
	unset DATE BATT
	
	DATE="$(date +"%A ｜ %d.%m.%Y ｜  %H:%M")" # Display the current date
	BATT="$( acpi -b | sed 's/.*[charging|unknown], \([0-9]*\)%.*/\1/gi' )" # Display Battery status
	xsetroot -name "[ ${DATE} ][ ${BATT} ]"


	sleep 1m
done &
# Execute the dwm windowmanager
exec dwm
