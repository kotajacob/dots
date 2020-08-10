# basic settings
PS1='\w '
PATH=$HOME/bin:$PATH
EDITOR='nvim'
VISUAL='nvim'
TERM='xterm-256color'
set -o vi
set -o vi-tabcomplete

## aliases
alias rsync='rsync -avP'
alias hist='cat .history|less'
alias m='make all'
alias mc='make clean'
alias c='clear'
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
alias xfs='xbps-query -R -o'
alias xlist='xbps-query -m'
alias todo='$EDITOR $HOME/TODO'
alias log='$EDITOR $HOME/LOG'
cf() {
        cd $(find . -mindepth 1 -type d | fzf)
}
vf() {
        $EDITOR $(find . -mindepth 1 -type f | fzf)
}
vff() {
        SELECTION=$(find . -mindepth 1 -type f | fzf)
	cd $(dirname $SELECTION)
	$EDITOR $(basename $SELECTION)
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
