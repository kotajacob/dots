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
eval "$(jump shell)"

## aliases
alias xu='sudo xbps-install -Su'
alias xs='xbps-query -Rs'
alias xr='sudo xbps-pkgdb -m auto'
alias xrm='sudo xbps-remove -R'
alias xc='sudo xbps-remove -Oo && sudo vkpurge rm all'
alias xinfo='xbps-query -R -S'
alias xlist='xpkg -m'
alias doas='sudo' # why the hell is sudo part of base on void ugggg
alias v='nice -n -10 nvim'
alias vi='nice -n -10 nvim'
alias vim='nice -n -10 nvim'
alias nvim='nice -n -10 nvim'
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
alias mnt='udevil mount'
alias umnt='udevil umount'
alias tide='tide /home/kota/docs/Dunedin2024.csv'
alias mail='mbsync primary'
# alias mm="cd $HOME/docs/memex && nvim index.md"
alias mntfog='sshfs -o allow_other,default_permissions kota@yepun:/var/fog /mnt/fog'
alias weather='metweather forecast | column -t -l3'
alias music='ncmpcpp'
alias mixer='pulsemixer'
alias alert='notify-send "command finished"'
alias json-to-go='go-jsonschema -p main'

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

phone ()
{
	command ntfy publish "$NTFY_SECRET" "$@"
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
