#!/bin/sh
if [ "${TERM:-none}" = "linux" ]; then
    printf "%b" "\\e]P03B4252"
    printf "%b" "\\e]P1BF616A"
    printf "%b" "\\e]P2A3BE8C"
    printf "%b" "\\e]P3EBCB8B"
    printf "%b" "\\e]P481A1C1"
    printf "%b" "\\e]P5B48EAD"
    printf "%b" "\\e]P688C0D0"
    printf "%b" "\\e]P7E5E9F0"
    printf "%b" "\\e]P84C566A"
    printf "%b" "\\e]P9BF616A"
    printf "%b" "\\e]PAA3BE8C"
    printf "%b" "\\e]PBEBCB8B"
    printf "%b" "\\e]PC81A1C1"
    printf "%b" "\\e]PDB48EAD"
    printf "%b" "\\e]PE8FBCBB"
    printf "%b" "\\e]PFECEFF4"

    # Fix artifacting.
    clear
fi
