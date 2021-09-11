#!/bin/sh

userresources=$HOME/.Xresources
if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

# start pipewire and pipewire-pulse
exec pipewire &
exec pipewire-pulse &

# start mpd
exec mpd &

# start i3 with dbus so notifications and other things work correctly
exec dbus-launch --exit-with-session /bin/i3
