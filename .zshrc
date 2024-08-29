# CUSTOM FOLDER PATHS
export DOTFILESDIR=$HOME/.dotfiles
export PYTHONDIR=$HOME/Dev/Python
export PYGLOBAL=$DOTFILESDIR/scripts/py-global
 

# Fix right indent padding
ZLE_RPROMPT_INDENT=0


### EDITOR
export EDITOR="$HOME/.local/bin/lvim"

### DIR coloured
LS_COLORS=$LS_COLORS:'di=1;37:' ; export LS_COLORS

PURPLE='\033[1;35m'
GREEN='\033[1;32m'
# CYAN='\033[1;33m'
BLACK='\033[1;30m'
CYAN='\033[1;36m'
DARKCYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color


### PATHS
# Homebrew
if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

# GNU make
if [[ -d /opt/homebrew/opt/make/libexec/gnubin ]]; then
    PATH="/opt/homebrew/opt/make/libexec/gnubin:$PATH"
fi

# Ensure /usr/local/bin is in PATH
PATH="/usr/local/bin:$PATH"

# User's local bin
if [[ -d "$HOME/.local/bin" ]]; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Flutter SDK
if [[ -d "$HOME/Dev/Flutter/SDK/flutter/bin" ]]; then
    PATH="$PATH:$HOME/Dev/Flutter/SDK/flutter/bin"
fi

# Python 3.12
if [[ -d "/Library/Frameworks/Python.framework/Versions/3.12/bin" ]]; then
    PATH="/Library/Frameworks/Python.framework/Versions/3.12/bin:$PATH"
fi

# Bun
BUN_INSTALL="$HOME/Library/Application Support/reflex/bun"
if [[ -d "$BUN_INSTALL/bin" ]]; then
    export BUN_INSTALL
    PATH="$BUN_INSTALL/bin:$PATH"
fi

# Export final PATH
export PATH


# eval $(/opt/homebrew/bin/brew shellenv)
# PATH="/opt/homebrew/opt/make/libexec/gnubin:$PATH"
# PATH="/usr/local/bin:$PATH"
# export PATH="$HOME/.local/bin:$PATH"
# export PATH="$PATH:$HOME/Dev/Flutter/SDK/flutter/bin"

# PATH="/Library/Frameworks/Python.framework/Versions/3.11/bin:${PATH}"
# export PATH

# export BUN_INSTALL="$HOME/Library/Application Support/reflex/bun"
# export PATH="$BUN_INSTALL/bin:$PATH"


### DOTFILES
reload() {
  [[ -f $DOTFILESDIR/scripts/aliases.zsh ]] && source $DOTFILESDIR/scripts/aliases.zsh
  [[ -f $DOTFILESDIR/scripts/functions.zsh ]] && source $DOTFILESDIR/scripts/functions.zsh
  [[ -f $DOTFILESDIR/scripts/apps.zsh ]] && source $DOTFILESDIR/scripts/apps.zsh
}
reload

# KEYBINDS
# ctrl+v find file in current dir and open in vim
zle -N vo
bindkey '^V' vo

zle -N fo
bindkey '^F' fo


# HISTORY SETTINGS
HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt APPENDHISTORY
setopt SHAREHISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS


### PLUGINS
# FZF
eval "$(fzf --zsh)"
export FZF_DEFAULT_OPTS="--height 40% --reverse --extended --border --multi --cycle --preview-window=down"
export FZF_DEFAULT_COMMAND="fd --type f"
# export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"

# Autocompletion
source $DOTFILESDIR/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
bindkey '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete
zstyle ':autocomplete:*history*:*' insert-unambiguous yes
# bindkey -M menuselect '\r' .accept-line # enter submits command line from menu
zstyle ':autocomplete:history-incremental-search-backward:*' list-lines 5 # History search limit
zstyle ':autocomplete:history-search-backward:*' list-lines 5 # History menu.

# Autosuggestions
source $DOTFILESDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=5'

# Syntax highlighting
source $DOTFILESDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_STYLES[command]='fg=#53D5BE'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#53D5BE'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#53D5BE'
ZSH_HIGHLIGHT_STYLES[function]='fg=#53D5BE'

# bat theme
export BAT_THEME="tokyonight"

# gum theme
export GUM_CHOOSE_CURSOR_FOREGROUND="14"
export GUM_CHOOSE_HEADER_FOREGROUND="14"
export GUM_CHOOSE_ITEM_FOREGROUND="#ffffff"
export GUM_CHOOSE_SELECTED_FOREGROUND="14"


# THEME STARSHIP
eval "$(starship init zsh)"
precmd() { precmd() { echo "" } } # adds line break between prompts


