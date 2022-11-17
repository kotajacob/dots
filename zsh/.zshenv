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
export NNN_COLORS='6666'
export NNN_BMS="d:$HOME/docs;h:$HOME;s:$HOME/src;S:$HOME/src/kota;p:$HOME/pics;t:$HOME/tmp;m:/run/media/kota;M:$HOME/.local/share/PolyMC/instances"
export NNN_PLUG='r:fixname;d:xdgdefault;j:autojump;p:preview-tui'
export PF_INFO="ascii title os kernel uptime pkgs memory editor palette"
export PCFSERVER='https://paste.nilsu.org:21/incoming'
export FZF_DEFAULT_COMMAND='rg --files'
export AART_VIEWER='imv'
export LS_COLORS="$LS_COLORS:di=1;36:ex=0;35"

# Colors
# Use with the palette script!
# Note that programs which have imported
# from the environment require a relog to
# apply any changes.
export FG="000000"
export BG="ffffff"
export BLACK="$BG"
export RED="bc1854"
export GREEN="769836"
export YELLOW="e4943a"
export BLUE="34859d"
export MAGENTA="bc4a9b"
export CYAN="9b70ff"
export WHITE="$FG"
export LIGHT_BLACK="888888"
export LIGHT_RED="de0051"
export LIGHT_GREEN="9ab738"
export LIGHT_YELLOW="f8b525"
export LIGHT_BLUE="35a0b6"
export LIGHT_MAGENTA="e36da8"
export LIGHT_CYAN="b78ef6"
export LIGHT_WHITE="444444"
export DIM_BLACK="ffffff"
export DIM_RED="a71657"
export DIM_GREEN="628e33"
export DIM_YELLOW="e1752d"
export DIM_BLUE="327195"
export DIM_MAGENTA="a54093"
export DIM_CYAN="794aff"
export DIM_WHITE="000000"
export PRIMARY="$CYAN"
export LIGHT_PRIMARY="f7f1ff"
export SECONDARY="$MAGENTA"

# NOTE: Steam, most games and other (older) binary applications might not work!
# Manual overrides should be used as needed.
# https://github.com/swaywm/sway/wiki/Running-programs-natively-under-wayland
export SDL_VIDEODRIVER=wayland
export XDG_CURRENT_DESKTOP=sway
export MOZ_ENABLE_WAYLAND=1
export MOZ_DBUS_REMOTE=1 # Workaround for clicking links in electron...
export QT_QPA_PLATFORM=wayland-egl
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1

export GOPATH="$HOME/.local/go"
export GOPROXY=direct
export NPM_PACKAGES="${HOME}/.local/npm"
export MANPAGER='less -Dd+g -Du+b'
export PATH="$HOME/bin:$HOME/.local/bin:$GOPATH/bin:$NPM_PACKAGES/bin:$HOME/.local/zig:$PATH"
export LD_LIBRARY_PATH="$HOME/.local/lib:$LD_LIBRARY_PATH"
export MANPATH="$HOME/.local/share/man:$MANPATH"
