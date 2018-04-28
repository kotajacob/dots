#!/usr/bin/env bash


# Source generated colors.
source "${HOME}/.cache/wal/colors.sh"

reload_dunst() {
    pkill dunst
    dunst \
        -lb "${color0:-#F0F0F0}" \
        -nb "${color0:-#F0F0F0}" \
        -cb "${color0:-#F0F0F0}" \
        -lf "${color15:=#000000}" \
        -bf "${color15:=#000000}" \
        -cf "${color15:=#000000}" \
        -nf "${color15:=#000000}" \
        -fn "${DUNST_FONT:-tewi 8}" \
        -geometry "${DUNST_SIZE:-300x30-40+70}" &
}

main() {
	# Run wal
	wal -i /home/kota/git/wallpapers/frozen_river.png

	# Run polybar
	polybar normal

	# Run dunst with new colors
    reload_dunst &
}

main
