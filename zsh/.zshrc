# Environment setting
export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin
export ZSH=$HOME/.oh-my-zsh
export EDITOR='vim'
export PAGER='less'
export LANG=en_US.UTF-8

# Oh-my-zsh config and activate
DISABLE_AUTO_TITLE='true'
CASE_SENSITIVE='true'
plugins=(git)
source $ZSH/oh-my-zsh.sh

# Zsh prompt setting
PROMPT='%F{222}(%T)-%F{215}(%n)-%F{173}(%m)-%F{101}(%~)$(git_prompt_info) %F{59}%# %f'
ZSH_THEME_GIT_PROMPT_PREFIX='%F{101}-%F{59}('
ZSH_THEME_GIT_PROMPT_SUFFIX='%f'
ZSH_THEME_GIT_PROMPT_DIRTY='*%F{59})'
ZSH_THEME_GIT_PROMPT_CLEAN='%F{59})'

# Zsh setting
setopt noautomenu

# Key binding
bindkey '\e\eOC' forward-word   # for tmux
bindkey '\e\eOD' backward-word  # for tmux
bindkey '\e\e[C' forward-word
bindkey '\e\e[D' backward-word

# Aliases setting
alias ll='ls -lhA'
alias la='ls -A'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias du='du -h'
alias df='df -h'
alias h='history'
alias more='less'
alias python='python3'
alias pip='pip3'
alias vim='nvim'

# Python pipenv
export PIPENV_VENV_IN_PROJECT=1
