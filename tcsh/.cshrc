# .cshrc - csh resource script, read at beginning of execution by each shell

# csh setting
set path = (/sbin /bin /usr/sbin /usr/bin /usr/games /usr/local/sbin /usr/local/bin $HOME/bin)
set prompt='%{\e[m%}%{\e[38;5;222m%}(%T)-%{\e[38;5;215m%}(%n)-%{\e[38;5;173m%}(%m)-%{\e[38;5;101m%}(%~) %{\e[38;5;59m%}%#%{\e[m%} '
set autolist
set nobeep
set history = 5000
set savehist = 5000
set mail = (/var/mail/$USER)

# custom alias
alias ls    'ls -hF --color=auto'
alias grep  'grep --color=auto'
alias rm    'rm -i'
alias cp    'cp -i'
alias mv    'mv -i'
alias cls   'clear'
alias du    'du -h'
alias df    'df -h'
alias h     history 100
alias j	    jobs -l
alias la    ls -a
alias lf    ls -FA
alias ll    ls -lA
alias more  less

# A righteous umask
umask 22

# custom environment
setenv EDITOR   vim
setenv PAGER    less
setenv BLOCKSIZE	K

# bindkey setting
bindkey '\e[1~' beginning-of-line      # Home
bindkey '\e[3~' delete-char            # Delete
bindkey '\e[4~' end-of-line            # End
bindkey '^W' backward-delete-word      # Delete
bindkey -k up history-search-backward  # PageUp
bindkey -k down history-search-forward # PageDown
bindkey '^[^[[C' forward-word
bindkey '^[^[[D' backward-word

# xterm title setting
if ( $TERM == 'xterm' ) then
    alias precmd 'echo -n "]0;Terminal - $cwd"'
endif
