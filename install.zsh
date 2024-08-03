#!/usr/bin/env zsh

BOLD='\033[1m'
CYAN='\033[36m'
RESET='\033[0m'
PREFIX="${BOLD}${CYAN}[>]${RESET}"

### CREATE SYMLINKS
DOTFILES="$HOME/.dotfiles"

if [ -e "$HOME/.config/starship.toml" ]; then
	echo -e "$PREFIX starship.toml found. Creating backup"
	mv "$HOME/.config/starship.toml" "$HOME/.config/starship.toml.bak"
fi
ln -s "$DOTFILES/starship.toml" "$HOME/.config/starship.toml"

if [ -d "$HOME/.config/iterm2-config" ]; then
	echo -e "$PREFIX iterm2-config/ found. Creating backup"
	mv "$HOME/.config/iterm2-config" "$HOME/.config/iterm2-config.bak/"
fi
ln -s "$DOTFILES/iterm2-config" "$HOME/.config/iterm2-config"

if [ -d "$HOME/.config/lvim" ]; then
	echo -e "$PREFIX lvim/ found. Creating backup"
	mv "$HOME/.config/lvim" "$HOME/.config/lvim.bak"
fi
ln -s "$DOTFILES/lvim" "$HOME/.config/lvim"

if [ -e "$HOME/.zshrc" ]; then
	echo -e "$PREFIX .zshrc found. Creating backup"
	mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
fi
ln -s "$DOTFILES/.zshrc" "$HOME/.zshrc"

### Create Folders
if [ ! -d "$HOME/Dev" ]; then
	mkdir -p $HOME/Dev
fi
if [ ! -d "$HOME/Dev/Python" ]; then
	mkdir -p $HOME/Dev/Python
fi

### INSTALL HOMEBREW
if ! command -v brew &>/dev/null; then
	echo -e "$PREFIX Installing Homebrew"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	exit 1
else
	echo -e "$PREFIX Homebrew found. Skipping installation."
fi

### FONTS
# Tap the Homebrew Fonts Cask if not already tapped
font_installed() {
	local font_file="$1"
	local font_dir="$HOME/Library/Fonts"
	local system_font_dir="/Library/Fonts"

	echo -e "$PREFIX Checking if font is installed..."
	# echo -e "$PREFIX Looking for font file: $font_file"

	if [[ -f "$font_dir/$font_file" || -f "$system_font_dir/$font_file" ]]; then
		# echo -e "$PREFIX Font found."
		return 0
	else
		# echo -e "$PREFIX Font not found."
		return 1
	fi
}
if font_installed "SauceCodeProNerdFontMono-Regular.ttf"; then
	echo -e "$PREFIX SauceCodePro Nerd Font Mono is already installed."
else
	echo -e "$PREFIX Installing fonts"
	brew install --cask font-sauce-code-pro-nerd-font
fi

### INSTALL HOMEBREW FORMULAE AND CASKS
formulae=(
	"fzf"
	"cmake"
	"eza"
	"htop"
	"lua"
	"lua-language-server"
	"ninja"
	"node"
	"wget"
	"git"
	"sqlite"
	"tldr"
	"ruff"
	"ruby"
	"shellcheck"
	"shfmt"
	"trash"
	"make"
	"ripgrep"
	"fd"
	"exploitdb"
)

# List of casks
casks=(
	"chromedriver"
	"iterm2"
	"rectangle"
	"figma"
	"protonvpn"
	"stats"
	"notion"
)

# Function to check if a formula is installed
is_formula_installed() {
	brew list --formula | grep -q "^$1$"
}

# Function to check if a cask is installed
is_cask_installed() {
	brew list --cask | grep -q "^$1$"
}

# Function to install a formula or cask
install_package() {
	local package_type=$1
	local package_name=$2
	local count=$3
	local total=$4

	if [[ -z "$package_name" ]]; then
		return
	fi

	if [[ "$package_type" = "formula" ]]; then
		if is_formula_installed "$package_name"; then
			echo -e "$PREFIX Formula $package_name is already installed."
		else
			echo -e "$PREFIX Installing formula $count/$total: $package_name"
			brew install "$package_name"
		fi
	elif [[ "$package_type" = "cask" ]]; then
		if is_cask_installed "$package_name"; then
			echo -e "$PREFIX Cask $package_name is already installed."
		else
			echo -e "$PREFIX Installing cask $count/$total: $package_name"
			brew install --cask "$package_name"
		fi
	fi
}

# Install formulae
total_formulae=${#formulae[@]}
for i in {1..$total_formulae}; do
	install_package "formula" "${formulae[$i - 1]}" "$i" "$total_formulae"
done

# Install casks
total_casks=${#casks[@]}
for i in {1..$total_casks}; do
	install_package "cask" "${casks[$i - 1]}" "$i" "$total_casks"
done

brew update && brew upgrade && brew cleanup

echo -e "\n$PREFIX Installation process complete!"
