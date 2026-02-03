# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"


# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"


export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#5fd7ff'

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-autosuggestions


# Keybindings
bindkey -e

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'


# Aliases
alias ll='ls -lh'
alias ls='ls --color'
alias bye='shutdown now'
alias zzz='systemctl suspend'
export PATH="$HOME/.local/bin:$PATH"
# Shell integrations
# Set up fzf key bindings and fuzzy completion
#eval "$(fzf --zsh)"



[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi





export PATH=$PATH:$HOME/.nvm/versions/node/v22.11.0/bin



eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/zen.toml)"
eval "$(zoxide init zsh)"



# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"
# pyenv
export PYENV_ROOT="/home/ugi/.pyenv"
export PATH="/bin:/home/ugi/.nvm/versions/node/v20.19.6/bin:/home/ugi/.local/bin:/home/ugi/.config/Code/User/globalStorage/github.copilot-chat/debugCommand:/home/ugi/.config/Code/User/globalStorage/github.copilot-chat/copilotCli:/home/ugi/.nvm/versions/node/v20.19.6/bin:/home/ugi/.local/bin:/home/ugi/.local/share/zinit/polaris/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/snap/bin:/home/ugi/.nvm/versions/node/v22.11.0/bin:/home/ugi/.vscode/extensions/ms-python.debugpy-2025.18.0-linux-x64/bundled/scripts/noConfigScripts:/home/ugi/.nvm/versions/node/v22.11.0/bin"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi
