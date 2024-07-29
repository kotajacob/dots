export PROMPT='$(vi_mode_status)'
export SAVEHIST=1000000
export HISTFILE=$HOME/.history
export HISTSIZE=1000000
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'
export SDCV_PAGER='less -FRX'
export LESS='--use-color -IR'

export GUI=1
export NNN_OPTS='aAcC'
export NNN_OPENER="$HOME/.config/nnn/plugins/nuke"
export NNN_COLORS='1111'
export NNN_BMS="d:$HOME/docs;h:$HOME;s:$HOME/src;S:$HOME/src/kota;p:$HOME/pics;t:$HOME/tmp;m:$HOME/docs/memex/;M:$HOME/.local/share/PolyMC/instances"
export NNN_PLUG='r:fixname;x:xdgdefault;j:autojump;p:preview-tui;d:dragdrop'
export PF_INFO="ascii title os kernel uptime pkgs memory editor palette"
export PCFSERVER='https://paste.nilsu.org:21/incoming'
export FZF_DEFAULT_COMMAND='rg --files'
export AART_VIEWER='imv'
export LS_COLORS="$LS_COLORS:di=1;31:ex=0;31:ln=0;31"
export PASSWORD_STORE_ENABLE_EXTENSIONS=true

# Colors
# Use with the palette script!
# Note that programs which have imported
# from the environment require a relog to
# apply any changes.
export FG="DDDCD9"
export BG="181818"
export BLACK="$BG"
export RED="D43949"
export GREEN="57B9AA"
export YELLOW="DBC495"
export BLUE="6FA1C3"
export MAGENTA="B668A0"
export CYAN="9B7BE5"
export WHITE="$FG"
export LIGHT_BLACK="484848"
export LIGHT_RED="D43949"
export LIGHT_GREEN="57B9AA"
export LIGHT_YELLOW="DBC495"
export LIGHT_BLUE="6FA1C3"
export LIGHT_MAGENTA="B668A0"
export LIGHT_CYAN="9B7BE5"
export LIGHT_WHITE="B7B4AE"
export DIM_BLACK="181818"
export DIM_RED="a71657"
export DIM_GREEN="628e33"
export DIM_YELLOW="e1752d"
export DIM_BLUE="327195"
export DIM_MAGENTA="a54093"
export DIM_CYAN="794aff"
export DIM_WHITE="DDDCD9"
export PRIMARY="$RED"
export LIGHT_PRIMARY="$RED"
export SECONDARY="$MAGENTA"

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
export NPM_PACKAGES="$HOME/.local"
export npm_config_prefix="$HOME/.local"
export NODE_PATH=$(npm root --quiet -g)
export MANPAGER='less -Dd+g -Du+b'
export PATH="$HOME/bin:$HOME/.local/bin:$GOPATH/bin:$HOME/.dotnet/tools:$PATH"
export LD_LIBRARY_PATH="$HOME/.local/lib:$LD_LIBRARY_PATH"
export MANPATH="$HOME/.local/share/man:$MANPATH"
