#!/usr/bin/env bash

reload_dunst() {
    pkill dunst
    dunst \
        -lb "#3B4252" \
        -nb "#3B4252" \
        -cb "#3B4252" \
        -lf "#D8DEE9" \
        -bf "#D8DEE9" \
        -cf "#D8DEE9" \
        -nf "#D8DEE9" \
        -font "Source Code Pro 10" \
        -geometry "${DUNST_SIZE:-300x40-40+40}" &
}

main() {
	# Run dunst with new colors
    reload_dunst &
}

main
