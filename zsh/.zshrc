# basic settings
unsetopt beep nomatch menu_complete flowcontrol
setopt appendhistory autocd extendedglob auto_menu complete_in_word always_to_end notify auto_continue
bindkey -v
zstyle :compinstall filename '/home/kota/.zshrc'
autoload -Uz compinit
compinit

# plugins
source /home/kota/.local/share/zsh/plugins/kota-prompt/kota-prompt.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source /home/kota/.local/share/zsh/plugins/zsh-autoenv/autoenv.zsh

# zsh history substring search
setopt HIST_IGNORE_ALL_DUPS
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# initialize jump
eval "$(/home/kota/.local/bin/jump shell)"

## aliases
alias xi='doas apk add'
alias xu='doas apk update && doas apk upgrade && flatpak update'
alias xs='apk search'
alias xr='doas apk del'
alias xls='apk info -L'
alias xinfo='apk info'
alias xlist='doas nvim /etc/apk/world'
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias nvim='nvim'
alias todo='nvim TODO'
alias g='git'
alias gst='git status'
alias k='kubectl'
alias mc='make clean'
alias clip='wl-copy'
alias c='clear'
alias cdc='cd; clear'
alias ls='ls --color=auto --group-directories-first'
alias la='ls -lAh --color=auto --group-directories-first'
alias l='ls -1F --color=auto --group-directories-first'
alias ip='ip -color=auto'
alias t='tmux'
alias tn='tmux new -s'
alias ta='tmux attach -t'
alias tls='tmux ls'
alias dmesg='sudo dmesg -wH'
alias mnt='udiskie-mount'
alias umnt='udiskie-umount'
alias tide='tide /home/kota/docs/Dunedin2024.csv'
alias mail='mbsync primary'
alias weather='metweather forecast | column -t -l3'
alias music='ncmpcpp'
alias mixer='pulsemixer'
alias alert='notify-send "command finished"'

## functions
go() {
    if [[ $1 == "doc" ]]; then
        command go "$@" | less -FRX
    else
        command go "$@"
    fi
}

of()
{
	SELECTION=$(fd -H --type f | fzf)
	xdg-open "$SELECTION" >/dev/null 2>&1 &
}

vf()
{
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

	nnn "$@"

	if [ -f "$NNN_TMPFILE" ]; then
		. "$NNN_TMPFILE"
		rm -f "$NNN_TMPFILE" > /dev/null
	fi
}

# Emit terminal CWD for foot
function osc7 {
    local LC_ALL=C
    export LC_ALL

    setopt localoptions extendedglob
    input=( ${(s::)PWD} )
    uri=${(j::)input/(#b)([^A-Za-z0-9_.\!~*\'\(\)-\/])/%${(l:2::0:)$(([##16]#match))}}
    print -n "\e]7;file://${HOSTNAME}${uri}\e\\"
}
add-zsh-hook -Uz chpwd osc7

# add secrets
source $HOME/.zshenv-secrets
