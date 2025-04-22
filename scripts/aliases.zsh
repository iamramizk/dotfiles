# TERMINAL
alias v='nvim'
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

alias teg='space && eza -L 1 --icons=always --group-directories-first --sort=name'
alias te2g='space && eza -L 2 --icons=always --group-directories-first --sort=name'
alias te3g='space && eza -L 3 --icons=always --group-directories-first --sort=name'
alias teag='space && eza -a -L 1 --icons=always --group-directories-first --sort=name'
alias tea2g='space && eza -a -L 2 --icons=always --group-directories-first --sort=name'
alias tea3g='space && eza -a -L 3 --icons=always --group-directories-first --sort=name'
alias tteg='space && eza -L 1 --icons=always --group-directories-first --sort=modified --reverse'
alias tte2g='space && eza -L 2 --icons=always --group-directories-first --sort=modified --reverse'
alias tte3g='space && eza -L 3 --icons=always --group-directories-first --sort=modified --reverse'
alias tteag='space && eza -a -L 1 --icons=always --group-directories-first --sort=modified --reverse'
alias ttea2g='space && eza -a -L 2 --icons=always --group-directories-first --sort=modified --reverse'
alias ttea3g='space && eza -a -L 3 --icons=always --group-directories-first --sort=modified --reverse'

# FILES CONFIG
alias zrc="v ~/.zshrc"
alias zalias="v $DOTFILESDIR/scripts/aliases.zsh"
alias zfunc="v $DOTFILESDIR/scripts/functions.zsh"
alias sconfig="v $HOME/.config/starship.toml"
alias icloud="cd \"$ICLOUDDIR\""
alias notes="cd \"$NOTESDIR\""
alias vault="cd \"Library/Mobile Documents/iCloud~md~obsidian/Documents/Vault\""

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
alias dev="cd $DEVDIR"
alias pyd="cd $PYTHONDIR"
alias vconfig="cd $DOTFILESDIR/nvim/lua"
alias docs="cd ~/Documents"
alias cyber="cd $CYBERSECDIR"
alias vols="cd /Volumes/"

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
alias csvprint="py $PYGLOBAL/print_csv.py"
alias pys="py $PYGLOBAL/server_hotreload.py"
alias passgen="py $PYGLOBAL/passgen.py"
alias cc="py $PYGLOBAL/clearclipboard.py"
alias cmm="sudo python3 $PYGLOBAL/clean_my_mac.py"
alias bashcolors="py $PYGLOBAL/bash_colors.py"
alias nato="py $PYGLOBAL/nato.py"

# FUZZING
alias se='fzf --reverse --multi'

# TORRENTS / DOWNLOADING
alias torrent="transmission-cli -w $HOME/Downloads/Torrents -u 100"

#CYBER SEC
alias nscripts="cd /opt/homebrew/opt/nmap/share/nmap"
