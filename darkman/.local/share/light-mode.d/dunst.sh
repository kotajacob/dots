#!/bin/sh
mkdir -p ~/.config/dunst/dunstrc.d/
echo "[global]" > ~/.config/dunst/dunstrc.d/00-colors.conf
echo "    background = \"#ffffff\"" >> ~/.config/dunst/dunstrc.d/00-colors.conf
echo "    foreground = \"#575279\"" >> ~/.config/dunst/dunstrc.d/00-colors.conf
pkill dunst
