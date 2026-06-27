# TERMINAL
alias v='nvim'
alias bk='cd ..'
alias q='exit'
alias rm='trash'
alias rmf='rm -fr'
alias uu='brew update && brew upgrade'
alias img='imgcat -W 100%'
alias reload='exec zsh'

# NAVIGATION LS: eza
alias te='eza -T -L 1 --icons=always --group-directories-first --sort=name'
alias te2='eza -T -L 2 --icons=always --group-directories-first --sort=name'
alias te3='eza -T -L 3 --icons=always --group-directories-first --sort=name'
alias tea='eza -Ta -L 1 --icons=always --group-directories-first --sort=name'
alias tea2='eza -Ta -L 2 --icons=always --group-directories-first --sort=name'
alias tea3='eza -Ta -L 3 --icons=always --group-directories-first --sort=name'
alias tte='eza -T -L 1 --icons=always --group-directories-first --sort=modified --reverse'
alias tte2='eza -T -L 2 --icons=always --group-directories-first --sort=modified --reverse'
alias tte3='eza -T -L 3 --icons=always --group-directories-first --sort=modified --reverse'
alias ttea='eza -Ta -L 1 --icons=always --group-directories-first --sort=modified --reverse'
alias ttea2='eza -Ta -L 2 --icons=always --group-directories-first --sort=modified --reverse'
alias ttea3='eza -Ta -L 3 --icons=always --group-directories-first --sort=modified --reverse'

alias tel='eza -T -L 1 -l --total-size --icons=always --group-directories-first --sort=name'
alias te2l='eza -T -L 2 -l --total-size --icons=always --group-directories-first --sort=name'
alias te3l='eza -T -L 3 -l --total-size --icons=always --group-directories-first --sort=name'
alias teal='eza -Ta -L 1 -l --total-size --icons=always --group-directories-first --sort=name'
alias tea2l='eza -Ta -L 2 -l --total-size --icons=always --group-directories-first --sort=name'
alias tea3l='eza -Ta -L 3 -l --total-size --icons=always --group-directories-first --sort=name'
alias ttel='eza -T -L 1 -l --total-size --icons=always --group-directories-first --sort=modified --reverse'
alias tte2l='eza -T -L 2 -l --total-size --icons=always --group-directories-first --sort=modified --reverse'
alias tte3l='eza -T -L 3 -l --total-size --icons=always --group-directories-first --sort=modified --reverse'
alias tteal='eza -Ta -L 1 -l --total-size --icons=always --group-directories-first --sort=modified --reverse'
alias ttea2l='eza -Ta -L 2 -l --total-size --icons=always --group-directories-first --sort=modified --reverse'
alias ttea3l='eza -Ta -L 3 -l --total-size --icons=always --group-directories-first --sort=modified --reverse'

alias teg='eza -L 1 --icons=always --group-directories-first --sort=name'
alias te2g='eza -L 2 --icons=always --group-directories-first --sort=name'
alias te3g='eza -L 3 --icons=always --group-directories-first --sort=name'
alias teag='eza -a -L 1 --icons=always --group-directories-first --sort=name'
alias tea2g='eza -a -L 2 --icons=always --group-directories-first --sort=name'
alias tea3g='eza -a -L 3 --icons=always --group-directories-first --sort=name'
alias tteg='eza -L 1 --icons=always --group-directories-first --sort=modified --reverse'
alias tte2g='eza -L 2 --icons=always --group-directories-first --sort=modified --reverse'
alias tte3g='eza -L 3 --icons=always --group-directories-first --sort=modified --reverse'
alias tteag='eza -a -L 1 --icons=always --group-directories-first --sort=modified --reverse'
alias ttea2g='eza -a -L 2 --icons=always --group-directories-first --sort=modified --reverse'
alias ttea3g='eza -a -L 3 --icons=always --group-directories-first --sort=modified --reverse'

# FILES CONFIG
alias zrc="v ~/.zshrc"
alias zalias="v $DOTFILESDIR/scripts/aliases.zsh"
alias zfunc="v $DOTFILESDIR/scripts/functions.zsh"
alias zapps="v $DOTFILESDIR/scripts/apps.zsh"
alias sconfig="v $HOME/.config/starship.toml"
alias icloud="cd \"$ICLOUDDIR\""
alias notes="cd \"$NOTESDIR\""
alias vault="cd \"Library/Mobile Documents/iCloud~md~obsidian/Documents/Vault\""

# GIT
alias gs="git status"
alias gd="git diff"
alias gls="git ls-files"
alias gi="v .gitignore"
alias ga="git add -A"
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
alias dnsprobe="py $PYGLOBAL/dns-probe.py"

# FUZZING
alias se='fzf --reverse --multi'

# TORRENTS / DOWNLOADING
alias torrent="transmission-cli -w $HOME/Downloads/Torrents -u 100"

#CYBER SEC
alias nscripts="cd /opt/homebrew/opt/nmap/share/nmap"

# AI
alias oc="opencode"

# SYSTEM & NETWORK
alias dns_flush="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
alias reset_audio="sudo killall coreaudiod"
