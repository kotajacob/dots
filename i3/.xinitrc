#!/bin/sh

userresources=$HOME/.Xresources
if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

export ENV=$HOME/.kshrc

exec dbus-launch --exit-with-session /bin/i3
