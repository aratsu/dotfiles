# prompt
export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00;00m\]\$ '
export PS2='> '

# command
alias ls='ls -G'
alias ll='ls -la -G'
alias la='ls -a -G'
alias cp='cp -i'
alias mv='mv -i'
#alias vim='mvim -v'
alias pip='pip2'
export GREP_OPTIONS='--color=auto'

# history
stty stop undef
shopt -u histappend
export HISTCONTROL=ignoreboth
export HISTSIZE=50000
export HISTFILESIZE=50000
export SHELL_SESSION_HISTORY=0

# bash-completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

export BASH_SILENCE_DEPRECATION_WARNING=1

# path
PATH="$PATH:$HOME/.bin"
