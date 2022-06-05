#!/bin/sh

INT="hci0"

function toggle_power {

    state=$( dbus-send --system --reply-timeout=2000 --type=method_call --print-reply=literal --dest=org.bluez /org/bluez/$INT org.freedesktop.DBus.Properties.Get string:org.bluez.Adapter1 string:Powered | grep -oE 'true|false' )

    if [ "$state" == "true" ]; then
        dbus-send --system --type=method_call --dest=org.bluez /org/bluez/$INT org.freedesktop.DBus.Properties.Set string:org.bluez.Adapter1 string:"Powered" variant:boolean:false
    elif [ "$state" == "false" ]; then
        dbus-send --system --type=method_call --dest=org.bluez /org/bluez/$INT org.freedesktop.DBus.Properties.Set string:org.bluez.Adapter1 string:"Powered" variant:boolean:true
    fi
}

function update_power() {
    state=$( dbus-send --system --reply-timeout=2000 --type=method_call --print-reply=literal --dest=org.bluez /org/bluez/$INT org.freedesktop.DBus.Properties.Get string:org.bluez.Adapter1 string:Powered | grep -oE 'true|false' )
    
    #Detect if a power state change took place.
    if [ "$powered" != "$state" ]; then
        powered=$state
        if [ $powered == true ]; then
        echo 
        else
        echo 
        fi
    fi
}

case $1 in

    "--toggle"|"-tp")
        toggle_power
        exit
        ;;
esac

#Get the initial power state.
update_power

#sig	1611029500.845682	916	:1.7	<none>	/org/bluez/hci0/dev_28_11_A5_70_A3_F1	org.freedesktop.DBus.Properties	PropertiesChanged
dbus-monitor --profile --address unix:path=/var/run/dbus/system_bus_socket "type='signal',interface='org.freedesktop.DBus.Properties',member='PropertiesChanged',sender='org.bluez'" 2> /dev/null | while read -r type timestamp serial sender destination path interface member
do
    #This type of path indicates a power state change.
    if [ "$path" == "/org/bluez/$INT" ]; then
    update_power

    #This would indicate a device connecting/disconnecting.
    elif [[ $path =~ /org/bluez/$INT/dev[_A-Z0-9]{18}$ ]]; then
    dev=$( echo $path | grep -Po dev[_A-Z0-9]{18}$ )
    devname=$( dbus-send --system --reply-timeout=2000 --type=method_call --print-reply=literal --dest=org.bluez /org/bluez/$INT/$dev org.freedesktop.DBus.Properties.Get string:org.bluez.Device1 string:Name | sed 's/variant//')
    varname=${dev}_state
    current_state=$( dbus-send --system --reply-timeout=2000 --type=method_call --print-reply=literal --dest=org.bluez /org/bluez/$INT/$dev org.freedesktop.DBus.Properties.Get string:org.bluez.Device1 string:Connected | grep -oE 'true|false' )
    
    if [[ -z ${!varname} || ${!varname} != $current_state ]]; then
    declare ${dev}_state=$current_state
    if [ ${!varname} == true ]; then
    echo  $devname
    else
    echo 
    fi
    fi
    fi

done
