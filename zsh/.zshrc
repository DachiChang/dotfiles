# Environment setting
export ZSH=$HOME/.oh-my-zsh
export EDITOR='nvim'
export PAGER='less'
export LANG='en_US.UTF-8'
export TERM='screen-256color'

# Oh-my-zsh config and activate
DISABLE_AUTO_TITLE='true'
CASE_SENSITIVE='true'
# TODO install
# brew install kubectl kubectx kube-ps1
# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
#
## kubectx zsh plugin
# curl -L https://raw.githubusercontent.com/ahmetb/kubectx/master/completion/_kubectx.zsh -o ~/.oh-my-zsh/completions/_kubectx.zsh
# curl -L https://raw.githubusercontent.com/ahmetb/kubectx/master/completion/_kubens.zsh -o ~/.oh-my-zsh/completions/_kubens.zsh
plugins=(zsh-autosuggestions git kubectl kube-ps1)
source $ZSH/oh-my-zsh.sh

# Zsh prompt setting
PROMPT='%F{222}(%T)%F{215}-(%m)$(kube_ps1)%F{101}-(%~)$(git_prompt_info) %F{59}%# %f'
ZSH_THEME_GIT_PROMPT_PREFIX='%F{59}-('
ZSH_THEME_GIT_PROMPT_SUFFIX='%f'
ZSH_THEME_GIT_PROMPT_DIRTY='*%F{59})'
ZSH_THEME_GIT_PROMPT_CLEAN='%F{59})'
KUBE_PS1_PREFIX='-('
KUBE_PS1_SEPARATOR=' '
KUBE_PS1_DIVIDER='.'
KUBE_PS1_PREFIX_COLOR=173
KUBE_PS1_SUFFIX_COLOR=173
KUBE_PS1_CTX_COLOR=173
KUBE_PS1_NS_COLOR=173
KUBE_PS1_SYMBOL_COLOR=173

# Zsh setting
setopt noautomenu

# LS color setting
export LSCOLORS=gxfxcxdxbxegedabagacad

# Key binding
bindkey '\e\eOC' forward-word   # for tmux
bindkey '\e\eOD' backward-word  # for tmux
bindkey '\e\e[C' forward-word   # for original shell
bindkey '\e\e[D' backward-word  # for original shell
bindkey '\e[1;3C' forward-word  # for nvim shell
bindkey '\e[1;3D' backward-word # for nvim shell

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
alias lg='lazygit'
alias ns='kubens'
alias ctx='kubectx'

# Python pipenv
export PIPENV_VENV_IN_PROJECT=1

# Path append
export PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin # system path
export PATH=/opt/homebrew/bin:$PATH # brew path
export PATH=$HOME/bin:$PATH
export PATH=$HOME/go/bin:/usr/local/go/bin:$PATH # go bin path
export PATH=$HOME/bin/nvim-macos/bin:$PATH # nvim path
export PATH=$PATH:/usr/local/share/dotnet # dotent path
export PATH=$PATH:/opt/homebrew/opt/mysql-client/bin # mysql client path

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/dachichang/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/dachichang/Downloads/google-cloud-sdk/path.zsh.inc'; fi
# The next line enables shell command completion for gcloud.
if [ -f '/Users/dachichang/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/dachichang/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
