#!/bin/sh
mkdir -p ~/.local/state/foot/
echo "initial-color-theme=1" > ~/.local/state/foot/colorscheme.ini
killall -SIGUSR1 foot
