export SVDIR="$HOME/.service"

if [ "$(tty)" = "/dev/tty1" ]; then
	exec dbus-run-session -- sway
fi
