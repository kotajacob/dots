export SVDIR="$HOME/.service"

if [ "$(tty)" = "/dev/tty1" ]; then
	exec dbus-run-session -- /home/kota/src/sircmpwn/sway/build/sway/sway
fi
