# basic settings
export HISTFILE=$HOME/.history
export HISTSIZE=10000
export PS1='\w '
export TERM='xterm-256color'
export EDITOR='/usr/local/bin/nvim'
export VISUAL='/usr/local/bin/nvim'
export PAGER='/usr/bin/less'
export NNN_OPTS='cC'
export PATH=$HOME/bin:$PATH
set -o vi
set -o vi-tabcomplete

## aliases
alias sudo='doas'
alias rsync='rsync -avP'
alias hist='cat .history|less'
alias m='make all'
alias mc='make clean'
alias c='clear'
alias vi='nvim'
alias ls='ls'
alias la='ls -lAh'
alias l='ls -1F'
alias t='tmux'
alias tn='tmux new -s'
alias ta='tmux attach -t'
alias tls='tmux ls'
alias xi='doas pkg_add'
alias xu='doas pkg_add -u'
alias xs='pkg_info -Q'
alias xr='doas pkg_add -aa'
alias xrm='doas pkg_delete'
alias xc='doas pkg_delete -a'
alias xinfo='pkg_info'
alias xlist='pkg_info -m'
alias todo='$EDITOR $HOME/TODO'
log() {
	zcat /var/www/logs/access.log.*.gz | cat /var/www/logs/access.log - | grep -v syslog | goaccess --no-global-config
}

## functions
cf() {
	if [ "$PWD" = "$HOME" ]; then
		cd "$(fzf < "$HOME/.cache/search-cache-dirs")" || exit
	else
		cd "$(fd -H --type d | fzf)" || exit
	fi
}
cfh() {
        cd "$(fd -H --type d | fzf)" || exit
}
of() {
	if [ "$PWD" = "$HOME" ]; then
		SELECTION=$(fzf < "$HOME/.cache/search-cache-files")
	else
		SELECTION=$(fd --type f | fzf)
	fi
	xdg-open "$SELECTION" >/dev/null 2>&1 &
}
ofh() {
	SELECTION=$(fd --type f | fzf)
	xdg-open "$SELECTION" >/dev/null 2>&1 &
}
vf() {
        "$EDITOR" "$(fd -H --type f | fzf)"
}
vcf() {
        SELECTION=$(fd -H --type f | fzf)
	cd "$(dirname "$SELECTION")" || exit
	"$EDITOR" "$(basename "$SELECTION")"
}
n () {
	# Block nesting of nnn in subshells
	if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
		echo "nnn is already running"
		return
	fi

	# The default behaviour is to cd on quit (nnn checks if NNN_TMPFILE is set)
	# To cd on quit only on ^G, remove the "export" as in:
	#     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
	# NOTE: NNN_TMPFILE is fixed, should not be modified
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
