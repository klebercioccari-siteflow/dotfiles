export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="fino-time"

plugins=(
    ansible
    colored-man-pages
    docker
    dotenv
    emoji
    fzf
    git
    gitignore
    history
    macos
    terraform
    vscode
    fast-syntax-highlighting
    zsh-autosuggestions
)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Aliases
alias ll='ls -lahF'
alias gs='git status'
alias gp='git pull'
alias gc='git checkout'
alias ..='cd ..'
alias ...='cd ../..'

# fzf configuration
export FZF_BASE=/opt/homebrew/bin/fzf

# History configuration
HISTSIZE=10000
HISTCONTROL=ignoredups