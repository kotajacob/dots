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
export NNN_COLORS='2222'
export NNN_BMS="d:$HOME/docs;h:$HOME;g:$HOME/g;G:$HOME/git;p:$HOME/pics;t:$HOME/tmp;m:/run/media/kota;M:/mnt"
export NNN_PLUG='r:fixname;d:xdgdefault;j:autojump;p:preview-tui'
export PF_INFO="ascii title os kernel uptime pkgs memory editor palette"
export PCFSERVER='https://paste.nilsu.org:21/incoming'
export FZF_DEFAULT_COMMAND='rg --files'
export AART_VIEWER='imv'
export LS_COLORS="$LS_COLORS:di=1;32:ex=0;35"

# NOTE: Steam, most games and other (older) binary applications might not work!
# Manual overrides should be used as needed.
# https://github.com/swaywm/sway/wiki/Running-programs-natively-under-wayland
export SDL_VIDEODRIVER=wayland
export MOZ_ENABLE_WAYLAND=1
export MOZ_DBUS_REMOTE=1 # Workaround for clicking links in electron...
export QT_QPA_PLATFORM=wayland-egl
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1

export GOPATH="$HOME/.local/go"
export GOPROXY=direct
export NPM_PACKAGES="${HOME}/.local/npm"
export MANPAGER='less -Dd+g -Du+b'
export PATH="$HOME/bin:$HOME/.local/bin:$GOPATH/bin:$HOME/$NPM_PACKAGES:$PATH"
# export MANPATH="$NPM_PACKAGES/share/man:$HOME/.local/share/man:$MANPATH"
export LD_LIBRARY_PATH="$HOME/.local/lib:$LD_LIBRARY_PATH"
