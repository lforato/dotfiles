export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$PATH:/usr/local/go/bin
export PATH="$HOME/go/bin:$PATH"

export EDITOR=nvim

export ZSH="$HOME/.oh-my-zsh"
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_TYPE=wayland

plugins=(
    sudo
    git
    archlinux
    zsh-syntax-highlighting
    zsh-autosuggestions
    command-not-found
    jsontools
    docker
)

eval "$(starship init zsh)"
echo && eval neofetch

source $ZSH/oh-my-zsh.sh
source <(fzf --zsh)

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# change my cd command to zoxide z command
cd() {
  if [ "$#" -eq 0 ]; then
    z || builtin cd
  else
    z "$@" || builtin cd "$@"
  fi
}

eval "$(zoxide init zsh)"

source "$HOME/.config/zsh/alias.sh"
