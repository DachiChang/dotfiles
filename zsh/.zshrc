# Environment setting
export ZSH="$HOME/.oh-my-zsh"
export EDITOR='nvim'
export PAGER='less'
export LANG='en_US.UTF-8'

# Oh-my-zsh config and activate
DISABLE_AUTO_TITLE='true'
CASE_SENSITIVE='true'
# brew install kubectl kubectx kube-ps1
# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
#
## kubectx zsh plugin
# curl -L https://raw.githubusercontent.com/ahmetb/kubectx/master/completion/_kubectx.zsh -o ~/.oh-my-zsh/completions/_kubectx.zsh
# curl -L https://raw.githubusercontent.com/ahmetb/kubectx/master/completion/_kubens.zsh -o ~/.oh-my-zsh/completions/_kubens.zsh
plugins=(zsh-autosuggestions git kubectl kube-ps1 fzf)
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

# Key binding
bindkey '\e\eOC' forward-word   # for tmux
bindkey '\e\eOD' backward-word  # for tmux
bindkey '\e\e[C' forward-word   # for original shell
bindkey '\e\e[D' backward-word  # for original shell
bindkey '\e[1;3C' forward-word  # for nvim shell
bindkey '\e[1;3D' backward-word # for nvim shell
bindkey '^f' fzf-file-widget    # for FZF find file

# Aliases setting
alias ls='eza --icons --group-directories-first'
alias ll='eza -lhA --icons --group-directories-first'
alias la='eza -A --icons --group-directories-first'
alias lt='eza -lT --icons --group-directories-first'
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
alias dk='lazydocker'
alias ns='kubens'
alias ctx='kubectx'

# Path append
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin" # system path
export PATH="/opt/homebrew/bin:$PATH" # brew path
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/go/bin:/usr/local/go/bin:$PATH" # go bin path
export PATH="$HOME/.cargo/bin:$PATH" # rust bin path
export PATH="$HOME/.local/bin:$PATH" # local bin path
export PATH="$HOME/bin/nvim-macos/bin:$PATH" # nvim path
export PATH="$PATH:/usr/local/share/dotnet" # dotent path
export PATH="$PATH:/opt/homebrew/opt/mysql-client/bin" # mysql client path

# pyenv usage
# brew install pyenv
# pyenv install 3.14.3
# pyenv install --list (list all python version)
# pyenv versions (list installed python version)
# pyenv global 3.14.3
# pyenv local 3.10.20 (will generate .python-version)
# pyenv shell 3.10.20 (will switch in used shell the python version)
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# nvm usage
# curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash
# nvm (node version manager)
#   -> node version & npm version
#     -> pnpm (npm install -g pnpm)
#       -> pnpm add package
#     -> yarn (npm install -g yarn)
#       -> yarn add package
# nvm ls-remote
# nvm install 25 (will install the latest version of v25)
# nvm use v25.8.1
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# look up .nvmrc to switch node version automatically
# echo "25.9" > PROJECT/.nvmrc
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

# opencode
export OPENCODE_ENABLE_EXA=1
