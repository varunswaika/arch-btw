# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# We use oh-my-posh, so we can disable the theme or leave it as default/robbyrussell
ZSH_THEME=""

# Plugins
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Initialize Starship
if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi

# User configuration
export PATH="$HOME/bin:$PATH"

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Completion
autoload -Uz compinit
compinit

# Aliases
alias ls='eza --icons'
alias ll='eza -l --icons'
alias la='eza -la --icons'
alias cat='bat'
alias grep='rg'
alias find='fd'
# cd alias is handled by zoxide

# Init tools
eval "$(zoxide init zsh --cmd cd)"

# Arch Linux Zsh Plugins (sourced manually since they are installed via pacman)
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# FZF
[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

# Fastfetch
fastfetch
