export SVDIR="$HOME/.service"
export WOBSOCK=$XDG_RUNTIME_DIR/wob.sock

if [ "$(tty)" = "/dev/tty1" ]; then
	exec dbus-run-session -- sway
fi
