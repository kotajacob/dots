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
source /home/kota/.local/share/zsh/plugins/zsh-autoenv/autoenv.zsh

# zsh history substring search
setopt HIST_IGNORE_ALL_DUPS
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# initialize jump
eval "$(jump shell)"

# setup dircolors for ls
eval $(dircolors -p | perl -pe 's/^((CAP|S[ET]|O[TR]|M|E)\w+).*/$1 00/' | dircolors -)

## aliases
alias mntkoi='sshfs -o allow_other,default_permissions kota@koi:/home/kota /mnt/koi'
alias mntsietch='sshfs -o allow_other,default_permissions kota@koi:/mnt/sietch /mnt/sietch'
alias hist='cat .history|less -I'
alias ncm='ncmpcpp'
alias m='make all'
alias mc='make clean'
alias mixer='pulsemixer'
alias clip='xclip -selection clipboard'
alias c='clear'
alias cdc='cd; clear'
alias v='nvim'
alias vim='nvim'
alias ls='ls --color=auto --group-directories-first'
alias la='ls -lAh --color=auto --group-directories-first'
alias l='ls -1F --color=auto --group-directories-first'
alias ip='ip -color=auto'
alias t='tmux'
alias tn='tmux new -s'
alias ta='tmux attach -t'
alias tls='tmux ls'
alias dmesg='sudo dmesg -wH'
# alias xi='sudo xbps-install -S' // Use xi from xtools instead
alias xu='sudo xbps-install -Su'
alias xs='xbps-query -Rs'
alias xr='sudo xbps-pkgdb -m auto'
alias xrm='sudo xbps-remove -R'
alias xc='sudo xbps-remove -Oo && sudo vkpurge rm all'
alias xinfo='xbps-query -R -S'
alias xlist='xpkg -m'
alias todo='$EDITOR $HOME/TODO'
alias mnt='udisksctl mount -b'
alias umnt='udisksctl unmount -b'
alias tide='tide /home/kota/docs/Dunedin2022.csv'
alias mail='mbsync primary'
alias neofetch='pfetch'
alias wiki="cd $HOME/docs/memex && nvim index.md"

## functions
readme() {
	if [ -f readme.md ]; then
		NAME="readme.md"
	else
		NAME="README.md"
	fi
	touch "$NAME" && "$EDITOR" "$NAME"
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

	# export TERMINAL="/bin/alacritty --class Alacritty-nofocus,Alacritty-nofocus"
	nnn "$@"

	if [ -f "$NNN_TMPFILE" ]; then
		. "$NNN_TMPFILE"
		rm -f "$NNN_TMPFILE" > /dev/null
	fi
}
