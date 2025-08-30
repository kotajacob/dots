export PROMPT='$(vi_mode_status)'
export SAVEHIST=1000000
export HISTFILE=$HOME/.history
export HISTSIZE=1000000
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less -FRX --mouse'
export SDCV_PAGER='less -FRX'
export LESS='--use-color -IR'
export GTK_CSD=0

export GUI=1
export NNN_OPTS='aAcC'
export NNN_OPENER="$HOME/.config/nnn/plugins/nuke"
export NNN_COLORS='6666'
export NNN_BMS="d:$HOME/docs;h:$HOME;s:$HOME/src;S:$HOME/src/kota;p:$HOME/pics;t:$HOME/tmp;m:$HOME/docs/memex/;M:$HOME/.local/share/PolyMC/instances"
export NNN_PLUG='r:fixname;x:xdgdefault;j:autojump;p:preview-tui;d:dragdrop'
export PF_INFO="ascii title os kernel uptime pkgs memory editor palette"
export PCFSERVER='https://paste.nilsu.org:21/incoming'
export FZF_DEFAULT_COMMAND='rg --files'
export AART_VIEWER='imv'
export LS_COLORS="$LS_COLORS:di=1;36:ex=0;35"
export PASSWORD_STORE_ENABLE_EXTENSIONS=true

# NOTE: Steam, most games and other (older) binary applications might not work!
# Manual overrides should be used as needed.
# https://github.com/swaywm/sway/wiki/Running-programs-natively-under-wayland
# export SDL_VIDEODRIVER=wayland
export XDG_CURRENT_DESKTOP=sway
export MOZ_ENABLE_WAYLAND=1
export MOZ_DBUS_REMOTE=1 # Workaround for clicking links in electron...
export QT_QPA_PLATFORM=wayland-egl
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1

# export GOPROXY=direct
export CGO_ENABLED=1
export CGO_CFLAGS="-D_LARGEFILE64_SOURCE"
export GODEBUG=goindex=0
export GOPATH="$HOME/.local/go"
export CARGO_HOME="$HOME/.local/cargo"
# export NPM_PACKAGES="$HOME/.local"
# export npm_config_prefix="$HOME/.local"
# export NODE_PATH=$(npm root --quiet -g)
export MANPAGER='nvim +Man!'
export PATH="$HOME/bin:$HOME/.local/bin:$GOPATH/bin:$CARGO_HOME/bin:$PATH"
export LD_LIBRARY_PATH="$HOME/.local/lib:$LD_LIBRARY_PATH"
export XDG_DATA_DIRS="$HOME/.local/share:$XDG_DATA_DIRS"
export MANPATH="$HOME/.local/share/man:$MANPATH"
export AWS_PAGER=""
export AWS_DEFAULT_PROFILE=sso
