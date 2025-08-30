#!/bin/sh
mkdir -p ~/.local/state/foot/
echo "initial-color-theme=2" > ~/.local/state/foot/colorscheme.ini
killall -SIGUSR2 foot
