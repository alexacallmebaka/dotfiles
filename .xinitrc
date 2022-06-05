#load Xresources
xrdb -load ~/.config/X11/xresources

#start udiskie automount daemon
udiskie &

#XSecureLock
export XSECURELOCK_SAVER="$XDG_CONFIG_HOME/xsecurelock/custom_saver"
export XSECURELOCK_PASSWORD_PROMPT="time"
xss-lock -n /usr/lib/xsecurelock/dimmer -l -- xsecurelock &

#clean up home directory
export ERRFILE="$XDG_CACHE_HOME/X11/xsession-errors"

exec i3
