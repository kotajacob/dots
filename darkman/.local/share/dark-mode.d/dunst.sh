#!/bin/sh
mkdir -p ~/.config/dunst/dunstrc.d/
echo "[global]" > ~/.config/dunst/dunstrc.d/00-colors.conf
echo "    background = \"#26233a\"" >> ~/.config/dunst/dunstrc.d/00-colors.conf
echo "    foreground = \"#e0def4\"" >> ~/.config/dunst/dunstrc.d/00-colors.conf
pkill dunst
