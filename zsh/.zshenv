export PROMPT='$(vi_mode_status)'
export SAVEHIST=1000000
export HISTFILE=$HOME/.history
export HISTSIZE=1000000
export TERMINAL="/bin/alacritty"
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'
export LESS='--use-color -IR'
export TERM='xterm-256color'
export SVDIR=$HOME/.service/
export GPG_TTY=$(tty)
export NNN_OPTS='arcC'
export NNN_COLORS='4444'
export NNN_BMS="d:$HOME/docs;h:$HOME;g:$HOME/g;t:$HOME/tmp;m:/run/media/kota"
export NNN_PLUG='x:!chmod +x $nnn;r:fixname;d:xdgdefault;j:autojump;p:preview-tui'
export PF_INFO="ascii title os kernel uptime pkgs memory editor palette"
export CGO_ENABLED=1
export PCFSERVER='https://paste.nilsu.org:21/incoming'
export JAVA_HOME='/home/kota/.local/'
export FZF_DEFAULT_COMMAND='rg --files'
export AART_VIEWER='sxiv -b -g 640x640'
export GOPATH="$HOME/go"
export PERL_BASE="$HOME/.local/perl5"
export PERL5LIB="$PERL_BASE/lib/perl5"
export LD_LIBRARY_PATH=/lib:/usr/lib:/usr/local/lib:$HOME/.local/lib:$LD_LIBRARY_PATH
export PATH="$HOME/.local/perl5/bin:$GOPATH/bin:$HOME/.yarn/bin:$HOME/.cargo/bin:$HOME/bin:$HOME/.local/bin:$HOME/.luarocks/bin:$PATH"
export MANPATH="$HOME/.local/perl5/man:$MANPATH"
export MANPAGER='less -Dd+g -Du+b'
