#!/usr/bin/env bash

# Source generated colors.
source "${HOME}/.wallpapers/current.sh"

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
    reload_dunst &
}

main
