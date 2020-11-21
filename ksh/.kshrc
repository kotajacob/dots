# basic settings
export HISTFILE=$HOME/.history
export HISTSIZE=10000
export PS1='\w '
export TERM='xterm-256color'
export EDITOR='/bin/nvim'
export VISUAL='/bin/nvim'
export PAGER='/bin/less'
export NNN_OPTS='cC'
export GOPATH="$HOME/go"
export PATH=$GOPATH/bin:$HOME/.yarn/bin:$HOME/bin:$PATH
set -o vi
set -o vi-tabcomplete

## aliases
alias rsync='rsync -avP'
alias hist='cat .history|less'
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
alias t='tmux'
alias tn='tmux new -s'
alias ta='tmux attach -t'
alias tls='tmux ls'
alias xi='sudo xbps-install -S'
alias xu='sudo xbps-install -Su'
alias xs='xbps-query -Rs'
alias xr='sudo xbps-pkgdb -m auto'
alias xrm='sudo xbps-remove -R'
alias xc='sudo xbps-remove -Oo && sudo vkpurge rm all'
alias xfs='xbps-query -R -f'
alias xinfo='xbps-query -R -S'
alias xlist='xbps-query -m'
alias todo='$EDITOR $HOME/TODO'
alias log='$EDITOR $HOME/LOG'
record() {
	ffmpeg -f x11grab -video_size 2560x1440 -r 30 -i "$DISPLAY" -f alsa -i default -c:v ffvhuff -an ~/tmp/record.mkv
}
cf() {
        cd "$(fd -H --type d | fzf)" || exit
}
of() {
	SELECTION=$(fd --type f | fzf)
	xdg-open "$SELECTION" >/dev/null 2>&1 &
}
vf() {
        "$EDITOR" "$(fd -H --type f | fzf)"
}
vff() {
        SELECTION=$(fd -H --type f | fzf)
	cd "$(dirname "$SELECTION")" || exit
	"$EDITOR" "$(basename "$SELECTION")"
}
d () {
	PWD=$(pwd)
	st -e "$SHELL" -c "cd $PWD; $SHELL" > /dev/null &
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
