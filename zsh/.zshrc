# basic settings
unsetopt beep nomatch menu_complete flowcontrol
setopt appendhistory autocd extendedglob auto_menu complete_in_word always_to_end notify auto_continue
bindkey -v
autoload -z edit-command-line
zle -N edit-command-line
bindkey -M vicmd "^V" edit-command-line
zstyle :compinstall filename '/home/kota/.zshrc'
autoload -Uz compinit
compinit

# plugins
source /home/kota/.local/share/zsh/plugins/kota-prompt/kota-prompt.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source /home/kota/.local/share/zsh/plugins/zsh-autoenv/autoenv.zsh

# rebind interupt
stty intr '^j'

# zsh history substring search
setopt HIST_IGNORE_ALL_DUPS
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# initialize jump
eval "$(/home/kota/.local/bin/jump shell)"

# allow foot to jump to the last prompt with Ctrl+Shift+Z.
function xterm_title_precmd () {
	print -Pn -- '\e]2;%~\a'
}

function xterm_title_preexec () {
	print -Pn -- '\e]2;%~ %# ' && print -n -- "${(q)1}\a"
}

if [[ "$TERM" == (Eterm*|alacritty*|aterm*|foot*|gnome*|konsole*|kterm*|putty*|rxvt*|screen*|wezterm*|tmux*|xterm*) ]]; then
	add-zsh-hook -Uz precmd xterm_title_precmd
	add-zsh-hook -Uz preexec xterm_title_preexec
fi

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
alias g='jj'
alias gst='git status'
alias k='kubectl'
alias mc='make clean'
alias calc='fend'
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
alias dmesg='doas dmesg -wH'
alias mnt='udiskie-mount'
alias umnt='udiskie-umount'
alias mail='mbsync primary'
alias weather='metweather forecast | column -t -l3'
alias music='ncmpcpp'
alias mixer='pulsemixer'
alias alert='notify-send "command finished"'

## functions
go() {
	if [[ $1 == "doc" ]]; then
		shift
		command go doc --all "$@" | less -FRX
	else
		command go "$@"
	fi
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

n () {
	# Block nesting of nnn in subshells
	if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
		echo "nnn is already running"
		return
	fi

	# The default behaviour is to cd on quit (nnn checks if NNN_TMPFILE is set)
	# To cd on quit only on ^G, remove the "export" as in:
	# NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
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

bubble_root() {
	doas mount --bind /dev ~/.local/chroots/debian/dev
	doas mount --bind /dev/pts ~/.local/chroots/debian/dev/pts
	doas mount --bind /proc ~/.local/chroots/debian/proc
	doas chroot ~/.local/chroots/debian /bin/bash
	trap 'umount_bubble_root' EXIT SIGINT SIGTERM
}

umount_bubble_root() {
	echo "umounting bwrap filesystems"
	doas umount ~/.local/chroots/debian/dev/pts
	doas umount ~/.local/chroots/debian/proc
	doas umount -flR ~/.local/chroots/debian/dev
}

bubble() {
	if ! xhost | grep -qi "local:"; then
		xhost +local:
		echo "added local: to xhost"
	else
		echo "local: is already present in xhost"
	fi

	echo "running command inside chroot with arguments: $@"

	LANG=en_US.UTF-8 bwrap \
	--bind ~/.local/chroots/debian / \
	--dev-bind /dev /dev \
	--dev-bind /dev/urandom /dev/urandom \
	--proc /proc \
	--bind /sys /sys \
	--bind /run /run \
	--bind /home /home \
	--ro-bind /etc/resolv.conf /etc/resolv.conf \
	--ro-bind /etc/passwd /etc/passwd \
	--ro-bind /etc/group /etc/group \
	--bind /tmp/.X11-unix /tmp/.X11-unix \
	--bind /tmp/.X11-unix/X0 /tmp/.X11-unix/X0 \
	--setenv DISPLAY :0 \
	/bin/bash -c '"$@"' bash "$@"
}

# Secrets
source $HOME/.zshenv-secrets
