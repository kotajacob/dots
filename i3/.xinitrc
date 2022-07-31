#!/bin/zsh
if test -z "${XDG_RUNTIME_DIR}"; then
	export XDG_RUNTIME_DIR=/tmp/${UID}-runtime-dir
	if ! test -d "${XDG_RUNTIME_DIR}"; then
		mkdir "${XDG_RUNTIME_DIR}"
		chmod 0700 "${XDG_RUNTIME_DIR}"
	fi
fi

userresources=$HOME/.Xresources
if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

# setup named pipe for xob
export XOBSOCK="$XDG_RUNTIME_DIR"/xob.sock
exec mkfifo $XOBSOCK &

# start pipewire and pipewire-pulse
exec pipewire &
exec pipewire-pulse &

# increase key repeat speed
exec xset r rate 350 40 &

# run mbsync once on login
# normally, it's only run when new mail arrives, but if it arrived while the
# computer was offline it wont get detected until a new email arrives.
exec mbsync primary &

# start i3 with dbus so notifications and other things work correctly
[ "$(tty)" = "/dev/tty1" ] && exec dbus-launch --exit-with-session /bin/i3
