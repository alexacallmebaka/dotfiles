#!/bin/bash

#terminate already running bar instances
killall -q polybar

#wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

#launch Polybar, using default config location ~/.config/polybar/config
polybar -c ~/.config/polybar/config.ini top >>/tmp/polybar1.log 2>&1 & disown 
polybar -c ~/.config/polybar/config.ini bottom >>/tmp/polybar2.log 2>&1 & disown

echo "Polybar launched..."
