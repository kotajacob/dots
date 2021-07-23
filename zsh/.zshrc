# basic settings
export PROMPT='$(vi_mode_status)'
export SAVEHIST=1000000
export HISTFILE=$HOME/.history
export HISTSIZE=1000000
export EDITOR='/bin/nvim'
export VISUAL='/bin/nvim'
export PAGER='/bin/less'
export TERM='xterm-256color'
export NNN_OPTS='cC'
export PCFSERVER='https://paste.nilsu.org:21/incoming'
export JAVA_HOME='/home/kota/.local'
export FZF_DEFAULT_COMMAND='rg --files'
export AART_VIEWER='sxiv -b -g 640x640'
export GOPATH="$HOME/go"
export PATH=$GOPATH/bin:$HOME/.yarn/bin:$HOME/bin:$HOME/.local/bin:$HOME/.luarocks/bin:$PATH
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
alias xinfo='xbps-query -R -S'
alias todo='$EDITOR $HOME/TODO'
alias log='$EDITOR $HOME/LOG'
alias mnt='udisksctl mount -b'
alias umnt='udisksctl unmount -b'
alias tide='tide /home/kota/docs/Dunedin2021.csv'
alias mail='mbsync primary'

## functions
readme() {
	if [ -f readme.md ]; then
		NAME="readme.md"
	else
		NAME="README.md"
	fi
	touch "$NAME" && "$EDITOR" "$NAME"
}

record() {
	ffmpeg -f x11grab -video_size 2560x1440 -r 30 -i "$DISPLAY" -f alsa -i default -c:v ffvhuff -an ~/tmp/record.mkv
}

timer() {
	minitimer $1; notify-send "timer finished"; beep -f 500 -l 400 -r 4
}

cf() {
	if [ "$PWD" = "$HOME" ]; then
		cd "$(fzf < "$HOME/.cache/search-cache-dirs")" || exit
	else
		cd "$(fd --type d | fzf)" || exit
	fi
}

cfh() {
	if [ "$PWD" = "$HOME" ]; then
		cd "$(fzf < "$HOME/.cache/search-cache-dirs-hidden")" || exit
	else
		cd "$(fd -H --type d | fzf)" || exit
	fi
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
	if [ "$PWD" = "$HOME" ]; then
		SELECTION=$(fzf < "$HOME/.cache/search-cache-files-hidden")
	else
		SELECTION=$(fd -H --type f | fzf)
	fi
	xdg-open "$SELECTION" >/dev/null 2>&1 &
}

vf() {
	if [ "$PWD" = "$HOME" ]; then
		SELECTION=$(fzf < "$HOME/.cache/search-cache-files-hidden")
	else
		SELECTION=$(fd -H --type f | fzf)
	fi
	"$EDITOR" "$SELECTION"
}

vcf() {
	if [ "$PWD" = "$HOME" ]; then
		SELECTION=$(fzf < "$HOME/.cache/search-cache-files-hidden")
	else
		SELECTION=$(fd -H --type f | fzf)
	fi
	cd "$(dirname "$SELECTION")" || exit
	"$EDITOR" "$(basename "$SELECTION")"
}

d () {
	PWD=$(pwd)
	st -e "$SHELL" -c "cd $PWD; $SHELL" > /dev/null 2>&1 &
}

n () {
	. ranger
}
vimcf () {
}
