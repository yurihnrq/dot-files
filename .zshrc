# Environment variables
export GOPATH="$HOME/.go"

# Path configuration
NVIM_BIN="/opt/nvim-linux64/bin"
GO_BIN="/usr/local/go/bin:$GOPATH/bin"
LUA_LSP_BIN="/usr/local/lua-lsp/bin"
export PATH="$PATH:$NVIM_BIN:$GO_BIN:$GOPATH:$LUA_LSP_BIN"

# Path oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme configuration
ZSH_THEME="spaceship"
export SPACESHIP_BATTERY_SHOW=false
export SPACESHIP_USER_SHOW=always
export SPACESHIP_HOST_SHOW=always
export SPACESHIP_PROMPT_ADD_NEWLINE=false
export SPACESHIP_DIR_TRUNC=1
export SPACESHIP_PACKAGE_SHOW=false
export SPACESHIP_DOCKER_COMPOSE_SHOW=false
export SPACESHIP_DOCKER_SHOW=false
export SPACESHIP_ASYNC_SHOW=false
export SPACESHIP_PROMPT_ASYNC=false

# ZSH plugins
plugins=(
	git 
	zsh-syntax-highlighting 
	zsh-autosuggestions
	docker
)

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Aliases
alias zshconfig="nvim ~/.zshrc"
alias gac="ga -A && gc"
alias gacm="ga -A && gc -m"
alias gaca="ga -A && gc --amend"
alias explorer="explorer.exe ."
alias ls="eza --icons -T -L=1"

# NVM
export NVM_DIR="$HOME/.nvm"
# This loads nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# This loads nvm bash_completion
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

autoload -U add-zsh-hook

load-nvmrc() {
  local nvmrc_path
  nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version
    nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc


# Load SSH keys
if [ -z "$SSH_AUTH_SOCK" ] ; then
  eval `ssh-agent -s` > /dev/null 2>&1

  # Add ssh keys here:
  ssh-add ~/.ssh/id_github > /dev/null 2>&1
fi

# Load GPG keys
export GPG_TTY=$(tty)

# Tell the terminal the CWD
keep_current_path() {
  printf "\e]9;9;%s\e\\" "$(wslpath -w "$PWD")"
}
precmd_functions+=(keep_current_path)

