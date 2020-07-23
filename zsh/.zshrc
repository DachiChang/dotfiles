# Environment setting
export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin
export ZSH=$HOME/.oh-my-zsh
export EDITOR='vim'
export PAGER='less'
export LANG=en_US.UTF-8

# Oh-my-zsh config and activate
ZSH_THEME="dachi"
DISABLE_AUTO_TITLE="true"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# Zsh setting
setopt noautomenu
setopt nomenucomplete

# Key binding
bindkey '\e\eOC' forward-word   # for tmux
bindkey '\e\eOD' backward-word  # for tmux
bindkey '\e\e[C' forward-word
bindkey '\e\e[D' backward-word

# Aliases setting
alias ll='ls -lA'
alias la='ls -A'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias du='du -h'
alias df='df -h'
alias h='history'
alias more='less'
