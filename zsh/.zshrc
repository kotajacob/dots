# basic settings
unsetopt beep nomatch menu_complete flowcontrol
setopt appendhistory autocd extendedglob auto_menu complete_in_word always_to_end notify
bindkey -v
zstyle :compinstall filename '/home/kota/.zshrc'
autoload -Uz compinit
compinit

# plugins
source /home/kota/.local/share/zsh/plugins/kota-prompt/kota-prompt.zsh
source /home/kota/.local/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

# zsh history substring search
setopt HIST_IGNORE_ALL_DUPS
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# initialize jump
eval "$(jump shell)"

## aliases
alias rsync='rsync -avP'
alias hist='cat .history|less -I'
alias ncm='ncmpcpp'
alias m='make all'
alias mc='make clean'
alias mixer='pulsemixer'
alias clip='xclip -selection clipboard'
alias c='clear'
alias vi='nvim'
alias vim='nvim'
alias ls='ls --color=auto'
alias la='ls -lAh --color=auto'
alias l='ls -1F --color=auto'
alias ip='ip -color=auto'
alias t='tmux'
alias tn='tmux new -s'
alias ta='tmux attach -t'
alias tls='tmux ls'
# alias xi='sudo xbps-install -S' // Use xi from xtools instead
alias xu='sudo xbps-install -Su'
alias xs='xbps-query -Rs'
alias xr='sudo xbps-pkgdb -m auto'
alias xrm='sudo xbps-remove -R'
alias xc='sudo xbps-remove -Oo && sudo vkpurge rm all'
alias xinfo='xbps-query -R -S'
alias todo='$EDITOR $HOME/TODO'
alias log='$EDITOR $HOME/LOG'
alias mnt='udisksctl mount -b'
alias umnt='udisksctl unmount -b'
alias tide='tide /home/kota/docs/Dunedin2021.csv'
alias mail='mbsync primary'
# https://github.com/jarun/advcpmv
alias cp='cpg -g'
alias mv='mvg -g'
alias neofetch='pfetch'
alias wiki="cd $HOME/docs/memex && nvim index.wiki"

## functions
readme() {
	if [ -f readme.md ]; then
		NAME="readme.md"
	else
		NAME="README.md"
	fi
	touch "$NAME" && "$EDITOR" "$NAME"
}

timer() {
	minitimer $1
	notify-send "timer finished"
	vol="$(pamixer --get-volume)"
	pamixer --set-volume 85
	ffplay -loglevel quiet -f lavfi -i "sine=frequency=900:duration=2" -autoexit -nodisp
	pamixer --set-volume "$vol"
}

of() {
	SELECTION=$(fd -H --type f | fzf)
	xdg-open "$SELECTION" >/dev/null 2>&1 &
}

vf() {
	SELECTION=$(fd -H --type f | fzf)
	cd "$(dirname "$SELECTION")" || exit
	"$EDITOR" "$(basename "$SELECTION")"
}

n ()
{
	# Block nesting of nnn in subshells
	if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
		echo "nnn is already running"
		return
	fi

	# The default behaviour is to cd on quit (nnn checks if NNN_TMPFILE is set)
	# To cd on quit only on ^G, remove the "export" as in:
	#     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
	export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

	# Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
	# stty start undef
	# stty stop undef
	# stty lwrap undef
	# stty lnext undef

	export TERMINAL="/bin/alacritty --class Alacritty-nofocus,Alacritty-nofocus"
	nnn "$@"

	if [ -f "$NNN_TMPFILE" ]; then
		. "$NNN_TMPFILE"
		rm -f "$NNN_TMPFILE" > /dev/null
	fi
}
