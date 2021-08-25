# basic settings
export PROMPT='$(vi_mode_status)'
export SAVEHIST=1000000
export HISTFILE=$HOME/.history
export HISTSIZE=1000000
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'
export MANPAGER='less -R --use-color -Dd+g -Du+b'
export LESS='-R'
export TERM='xterm-256color'
export GPG_TTY=$(tty)
export NNN_OPTS='arcC'
export NNN_COLORS='4444'
export NNN_BMS="d:$HOME/docs;h:$HOME;g:$HOME/g;t:$HOME/tmp;m:/run/media/kota"
export NNN_PLUG="x:!chmod +x $nnn;r:fixname;d:xdgdefault;p:preview-tui"
export PF_INFO="ascii title os kernel uptime pkgs memory editor palette"
export CGO_ENABLED=1
export PCFSERVER='https://paste.nilsu.org:21/incoming'
export JAVA_HOME='/home/kota/.local'
export FZF_DEFAULT_COMMAND='rg --files'
export AART_VIEWER='sxiv -b -g 640x640'
export GOPATH="$HOME/go"
export PATH=$GOPATH/bin:$HOME/.yarn/bin:$HOME/.cargo/bin:$HOME/bin:$HOME/.local/bin:$HOME/.luarocks/bin:$PATH
unsetopt beep nomatch menu_complete flowcontrol
setopt appendhistory autocd extendedglob auto_menu complete_in_word always_to_end notify
bindkey -v
zstyle :compinstall filename '/home/kota/.zshrc'
autoload -Uz compinit
compinit

# plugins
source /home/kota/.local/share/zsh/plugins/kota-prompt/kota-prompt.zsh

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

cf() {
	cd "$(fd --type d | fzf)" || exit
}

cfh() {
	cd "$(fd -H --type d | fzf)" || exit
}

of() {
	SELECTION=$(fd --type f | fzf)
	xdg-open "$SELECTION" >/dev/null 2>&1 &
}

ofh() {
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

    tmux new-session 'nnn "$@"'

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}
