# === EXPORTS ===
# Custom folders
export DOTFILESDIR=$HOME/.dotfiles
export DEVDIR=$HOME/Dev
export PYTHONDIR=$DEVDIR/Python
export PYGLOBAL=$PYTHONDIR/py-global
export ICLOUDDIR="$HOME/Library/Mobile Documents/com~apple~CloudDocs/"
export NOTESDIR=$ICLOUDDIR/Notes/Vault
export CYBERSECDIR=$HOME/Dev/CyberSec/

export EDITOR="/opt/homebrew/bin/nvim"


# === COLOURS ===
LS_COLORS=$LS_COLORS:'di=1;37:' ; export LS_COLORS

PURPLE='\033[1;35m'
GREEN='\033[1;32m'
# CYAN='\033[1;33m'
BLACK='\033[1;30m'
CYAN='\033[1;36m'
DARKCYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color


# === PATHS ===
# Homebrew
if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi
export HOMEBREW_NO_AUTO_UPDATE=1

# GNU make
if [[ -d /opt/homebrew/opt/make/libexec/gnubin ]]; then
    PATH="/opt/homebrew/opt/make/libexec/gnubin:$PATH"
fi

# Ensure /usr/local/bin is in PATH
# PATH="/usr/local/bin:$PATH"

# User's local bin
if [[ -d "$HOME/.local/bin" ]]; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Flutter SDK
if [[ -d "$HOME/Dev/Flutter/SDK/flutter/bin" ]]; then
    PATH="$PATH:$HOME/Dev/Flutter/SDK/flutter/bin"
fi

# Python
# if [[ -d "/Library/Frameworks/Python.framework/Versions/3.13/bin" ]]; then
#     PATH="$PATH:/Library/Frameworks/Python.framework/Versions/3.13/bin"
# fi

# Bun
BUN_INSTALL="$HOME/Library/Application Support/reflex/bun"
if [[ -d "$BUN_INSTALL/bin" ]]; then
    export BUN_INSTALL
    PATH="$BUN_INSTALL/bin:$PATH"
fi

# GO
if [[ -d "$HOME/go/bin" ]]; then
    PATH="$PATH:$HOME/go/bin"
fi

# Export final PATH
export PATH

# Ruby env
if command -v rbenv 1>/dev/null 2>&1; then
    eval "$(rbenv init - --no-rehash zsh)" # run `rbenv rehash` manually when needed
    # eval "$(rbenv init -)"
fi


# === DOTFILES ===
[[ -f $DOTFILESDIR/scripts/aliases.zsh ]] && source $DOTFILESDIR/scripts/aliases.zsh
[[ -f $DOTFILESDIR/scripts/functions.zsh ]] && source $DOTFILESDIR/scripts/functions.zsh
[[ -f $DOTFILESDIR/scripts/apps.zsh ]] && source $DOTFILESDIR/scripts/apps.zsh

# === KEYBINDS ===
# ctrl+v find file in current dir and open in vim
zle -N vo
bindkey '^V' vo

zle -N fo
bindkey '^F' fo


# === HISTORY ===
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

# === COMPLETIONS ===
# completions setup (must run before compinit)
fpath=("$HOME/.docker/completions" $fpath)

# Hybrid compilation & weekly cache check
autoload -Uz compinit
if [[ -f ~/.zcompdump ]] && ((( $(date +%s) - $(stat -f %m ~/.zcompdump) ) < 604800)); then
    compinit -C
else
    compinit
fi

# Manual force rebuild command, run after new cli installs
zrebuild() {
    rm -f ~/.zcompdump*
    compinit
    compdump
    zcompile ~/.zcompdump
    printf "${CYAN}>${NC} Cache rebuilt successfully. Reloading shell...\n"
    exec zsh
}

# === PLUGINS ===
# FZF
eval "$(fzf --zsh)"
# export FZF_DEFAULT_OPTS="--height 40% --reverse --extended --border --multi --cycle --preview-window=down"
# export FZF_DEFAULT_COMMAND="fd --type f"
# export FZF_DEFAULT_COMMAND="rg --files --sort=modified"
# look into -x stat below
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git -x stat -f '%m %N' {} + | sort -rn | cut -d ' ' -f 2-"
export FZF_DEFAULT_OPTS="\
  --height 40% --reverse --extended --border --multi --cycle \
  --preview 'bat --style=plain --color=always --line-range=:500 {}' \
  --preview-window=right:50%:nowrap"

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"

# === COMPLETION MENU (fzf-tab) & AUTOSUGGESTIONS ===
if [[ "$ITERM_PROFILE" != "rk-light" ]]; then
  # fzf-tab config — set these BEFORE sourcing the plugin
  zstyle ':completion:*' menu no                            # let fzf-tab take over the menu
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}     # colour filenames
  zstyle ':completion:*:descriptions' format '[%d]'         # show group headers
  zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
  zstyle ':fzf-tab:*' switch-group '<' '>'                  # press < / > to switch groups
  zstyle ':fzf-tab:*' continuous-trigger 'tab'
  zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'

  # Must come AFTER compinit (lines 112-117) and BEFORE the two plugins below
  source $DOTFILESDIR/plugins/fzf-tab/fzf-tab.plugin.zsh

  # Autosuggestions (after fzf-tab)
  source $DOTFILESDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# === SYNTAX HIGHLIGHTING ===
source $DOTFILESDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_STYLES[command]='fg=#fab387' # was #53D5BE
ZSH_HIGHLIGHT_STYLES[alias]='fg=#fab387' # was #53D5BE
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#fab387' # was #53D5BE
ZSH_HIGHLIGHT_STYLES[function]='fg=#fab387' # was #53D5BE
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#FF776B'

# === BAT ===
export BAT_THEME="tokyonight"

# === EXA ===
# export EXA_COLORS="*.md=38;5;44:*.txt=38;5;38:*.sh=38;5;39:*.zsh=38;5;39"
# export EZA_COLORS="*.md=38;5;44:*.txt=38;5;38:*.sh=38;5;39:*.zsh=38;5;39"

# === GUM ===
export GUM_CHOOSE_CURSOR_FOREGROUND="14"
export GUM_CHOOSE_HEADER_FOREGROUND="14"
export GUM_CHOOSE_ITEM_FOREGROUND="#ffffff"
export GUM_CONFIRM_SELECTED_BACKGROUND="#3C59A0"
export GUM_CONFIRM_PROMPT_FOREGROUND="#FFFFFF"

# === THEME  ===
# Fix right indent padding
ZLE_RPROMPT_INDENT=0

# Starship
eval "$(starship init zsh)"
precmd() { precmd() { echo "" } } # adds line break between prompts
