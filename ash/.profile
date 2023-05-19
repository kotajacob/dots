ENV=$HOME/.ashrc; export ENV
. $ENV

if [ "$(tty)" = "/dev/tty1" ]; then
	exec startx
fi
