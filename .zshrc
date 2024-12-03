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
export SPACESHIP_GOLANG_SYMBOL=" "
export SPACESHIP_NODE_SYMBOL=" "

# ZSH plugins
plugins=(
	git 
	zsh-syntax-highlighting 
	zsh-autosuggestions
	docker
   tmux
)

# tmux plugin configuration
ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOCONNECT=false
ZSH_TMUX_AUTOQUIT=true

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Aliases
alias zshconfig="nvim ~/.zshrc"
alias gac="ga -A && gc"
alias gacm="ga -A && gc -m"
alias gaca="ga -A && gc --amend"
alias explorer="explorer.exe ."
alias ls="eza --icons -T -L=1"
alias python="python3"
alias tmux="tmux -f ~/.tmux.conf"

# Make Home and End keys work with tmux and nvim
bindkey "\E[1~" beginning-of-line
bindkey "\E[4~" end-of-line

# Functions
# Load environment variables from file
load-env-file() {
	local env_file="$1"
	if [ -f "$env_file" ]; then
		export $(grep -v '^#' $env_file | xargs -d '\n')
	fi
}
# Unset environment variables from file
unset-env-file() {
	local env_file="$1"
	if [ -f "$env_file" ]; then
		unset $(grep -v '^#' $env_file | sed -E 's/(.*)=.*/\1/' | xargs)
	fi
}

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
  ssh-add ~/.ssh/id_github_ed25519 > /dev/null 2>&1
fi

# Load GPG keys
export GPG_TTY=$(tty)

