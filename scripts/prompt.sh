#!/bin/bash
operation=$1
confirmation=$( echo -e "no\nyes" | rofi -theme maki  -dmenu -p "Are you sure you want to $operation?" )
if [ "$confirmation" = "no" ]
then 
    exit
elif [ "$confirmation" = "yes" ]
then
    case $operation in
        shutdown )
            systemctl poweroff
            ;;
        suspend )
            systemctl suspend
            ;;
        reboot )
            systemctl reboot
            ;;
        logout )
            i3 exit
            ;;
	lock )
            xset s activate
	    ;;
	hibernate )
	    systemctl hibernate
    esac
fi
