#!/bin/zsh

function nf() {
  # make and cd into a folder
  mkdir $1
  cd $1
}

function vo() {
  # find file in current dir and open in vim, custom text on binary file
  fd -t f --hidden -d 1 | 
      fzf --height 100% --multi --exact --preview 'if file -b {} | grep -q "text"; then bat -n --color=always --style=plain {}; else echo "[ Binary ]"; fi' | 
      xargs lvim -p
}

function funcs() {
  # Show all functions 
  local funcs_file="$DOTFILESDIR/scripts/functions.zsh"

  grep -E '^function ' "$funcs_file" | awk '{print $2}' | 
  fzf --height 100% --preview="echo 'Function code for {}: '; grep -A 1000 {} '$funcs_file' | bat -n --color=always --style=plain --language=zsh"
}

function apps() {
  # show all apps
  local apps_file="$DOTFILESDIR/scripts/apps.zsh"
  
  if [[ -f "$apps_file" ]]; then
      grep -E '^function ' "$apps_file" | awk '{print $2}' | 
      fzf --height 100% --preview="echo 'Function code for {}: '; grep -A 1000 {} '$apps_file' | bat -n --color=always --style=plain --language=zsh"
  fi
}

function myip() {
  # get public and private ip addresses
  space
  private_ip_wifi=$(ipconfig getifaddr en1)
  if [[ -n $private_ip_wifi ]]; then
    echo "${DARKCYAN}Private IP address (Wi-Fi):${NC} $private_ip_wifi"
  fi
  public_ip=$(curl -s https://api.ipify.org)
  echo "${DARKCYAN}Public IP address:${NC} $public_ip"
}

function nvpyp() {
  # create new python project and env with pip install as args
  echo "${DARKCYAN}\n> Creating virtual env${NC}"
  mkdir ~/Dev/Python/$1
  cd ~/Dev/Python/$1
  python3 -m venv .venv
  act
  echo "\n${DARKCYAN}> Env activated -${NC} $(python --version)"
  pip install --upgrade pip
  touch app.py
  # install packages if entered as args 3+
  if [ -z $2 ]; then  
    echo "${DARKCYAN}\n> Project files created\n${NC}"
  else
    for arg in ${@:2}; do
      echo "${DARKCYAN}\n> Installing $arg ${NC}"
      pip install $arg
    done
    echo "${DARKCYAN}\n> Project files created\n${NC}"
    sleep 1
    v app.py
  fi
}

function nvpyp+() {
  # select py framework and create project with pip install
  local python_versions_path="/Library/Frameworks/Python.framework/Versions"
	local versions=($(find "$python_versions_path" -maxdepth 1 -type d -exec basename {} \; | grep -v "^Versions$" | sort))

	local selected_version=$(gum choose --header="" "${versions[@]}")
  if [[ -z "$selected_version" ]]; then
		return 1
	fi
	if [[ "$selected_version" =~ ^[0-9] ]]; then
		local python_command="python$selected_version"
	else
		local python_command="python3"
	fi

	# Create virtual environment
	if command -v $python_command >/dev/null 2>&1; then
    echo "${DARKCYAN}\n> Creating virtual env${NC}"
    mkdir ~/Dev/Python/$1
    cd ~/Dev/Python/$1
    $python_command -m venv .venv
    act
    echo "\n${DARKCYAN}> Env activated -${NC} $(python --version)"
    pip install --upgrade pip
    touch app.py
    # install packages if entered as args 3+
    if [ -z $2 ]; then  
      echo "${DARKCYAN}\n> Project files created\n${NC}"
    else
      for arg in ${@:2}; do
        echo "${DARKCYAN}\n> Installing $arg ${NC}"
        pip install $arg
      done
      echo "${DARKCYAN}\n> Project files created\n${NC}"
      sleep 1
      v app.py
    fi
	else
		echo "Error: $python_command not found. Please ensure it's installed and in your PATH."
		return 1
	fi
}


function pyda() {
  # FZF python dirs, cd in & activate env
  cd $PYTHONDIR
  selected_dir=$(fd -t d -d 1 | xargs -I {} stat -f '%m %N' {} | sort -nr | cut -d' ' -f2- | sed 's:/$::' | fzf --preview "eza -T -L 1 --icons=always --group-directories-first --sort=name --color=always -- {}" --preview-window=right:50%)

  if [[ -n "$selected_dir" ]]; then
    cd "$selected_dir" && act && te
  fi
}

function act() {
  # Activates Python environment
  local found=false

  if [ -f 'env/bin/activate' ]; then
    source env/bin/activate
    found=true
  elif [ -f '.env/bin/activate' ]; then
    source .env/bin/activate
    found=true
  elif [ -f 'venv/bin/activate' ]; then
    source venv/bin/activate
    found=true
  elif [ -f '.venv/bin/activate' ]; then
    source .venv/bin/activate
    found=true
  fi

  if [ "$found" = false ]; then
    echo "\n${PURPLE}!${NC} No virtual env found"
  fi

  return 0
}

function copypath() {
  # Copy path to clipboard
  # If no argument passed, use current directory
  local file="${1:-.}"

  # If argument is not an absolute path, prepend $PWD
  [[ $file = /* ]] || file="$PWD/$file"

  # Copy the absolute path without resolving symlinks
  # If clipcopy fails, exit the function with an error
  print -n "${file:a}" | pbcopy || return 1

  echo ${(%):-"%B${file:a}%b copied to clipboard."}
}

function cc() {
  # Clear clipboard
  echo "" | pbcopy
  echo ${(%):-"%B>%b Clipboard cleared."}
}

function tef() {
  # tree with grep as arg
  var="${1:- }"
	te | grep -i "$var"
}


function lg() {
  # Live grep and open in lvim on searched line number
  rg --hidden --glob '!.*' --line-number '' . | fzf --delimiter : --preview 'if [ "{}" != "" ]; then start_line=$(echo {} | cut -d: -f2); file=$(echo {} | cut -d: -f1); bat --style=numbers --color=always --highlight-line $start_line --line-range $((start_line>10 ? start_line-10 : 1)):$((start_line+10)) $file; fi' --preview-window=right:50% --bind 'enter:execute($EDITOR +{2} {1} +"normal! zz")'
}

function kps() {
  # kill a process (multi) via fzf
  ps ax | fzf --multi --height=98% | awk '{print $1}' | xargs -I {} sh -c 'gum confirm "Kill process {}?" && kill {} || echo "Process {} not killed"'
}
