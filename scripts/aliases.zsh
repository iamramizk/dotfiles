#!/bin/zsh

# TERMINAL
alias v='lvim'
alias bk='cd ..'
alias q='exit'
alias rm='trash'
alias rmf='rm -fr'
alias space='echo ""'

# NAVIGATION LS
alias te='space && eza -T -L 1 --icons=always --group-directories-first --sort=name'
alias te2='space && eza -T -L 2 --icons=always --group-directories-first --sort=name'
alias te3='space && eza -T -L 3 --icons=always --group-directories-first --sort=name'
alias tea='space && eza -Ta -L 1 --icons=always --group-directories-first --sort=name'
alias tea2='space && eza -Ta -L 2 --icons=always --group-directories-first --sort=name'
alias tea3='space && eza -Ta -L 3 --icons=always --group-directories-first --sort=name'
alias tte='space && eza -T -L 1 --icons=always --group-directories-first --sort=modified --reverse'
alias tte2='space && eza -T -L 2 --icons=always --group-directories-first --sort=modified --reverse'
alias tte3='space && eza -T -L 3 --icons=always --group-directories-first --sort=modified --reverse'
alias ttea='space && eza -Ta -L 1 --icons=always --group-directories-first --sort=modified --reverse'
alias ttea2='space && eza -Ta -L 2 --icons=always --group-directories-first --sort=modified --reverse'
alias ttea3='space && eza -Ta -L 3 --icons=always --group-directories-first --sort=modified --reverse'

# FILES CONFIG
alias zrc="v ~/.zshrc"
alias vrc="v ~/.config/lvim/config.lua"
alias zalias="v $DOTFILESDIR/scripts/aliases.zsh"
alias zfunc="v $DOTFILESDIR/scripts/functions.zsh"
alias vconfig="cd ~/.config/lvim/lua/user"
alias sconfig="v $HOME/.config/starship.toml"

# GIT
alias gs="git status"
alias gd="git diff"
alias gls="git ls-files"
alias gi="v .gitignore"
alias ga="git add ."
alias gc="git commit -m"
alias gl="git log --oneline"
alias gb="git branch"
alias gco="git checkout -b"
alias gp="git push"

# FOLDERS
alias dotfiles="cd $DOTFILESDIR"
alias dls='cd ~/Downloads/'
alias dtop='cd ~/Desktop'
alias dev='cd ~/Dev/'
alias pyd="cd $PYTHONDIR"
alias vconfig="cd ~/.config/lvim/"
alias docs="cd ~/Documents"

# PYTHON
alias py='python3'
alias pyi='python3 -i'
alias pyw='python3 -W ignore'
alias pyiw='python3 -W ignore -i'
alias pys="open 'http://[::]:8888/' && live-server" # Start Python server and launch
alias ucd='brew upgrade --cask chromedriver'
alias deact='deactivate'
alias upip="python3 -m pip install --upgrade pip"

# PYTHON GLOBAL
alias pyg="cd $PYGLOBAL"
alias csvprint="python3 $PYGLOBAL/print_csv.py"
alias pys="python3 $PYGLOBAL/server_hotreload.py"
alias passgen="python3 $PYGLOBAL/passgen.py"
alias cc="python3 $PYGLOBAL/clearclipboard.py"

# FUZZING
alias se='fzf --reverse --multi'
