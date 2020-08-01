alias cp='cp -i'
alias mv='mv -i'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias gvim='vim -g'

alias pip='python -m pip'
alias pip3='python3 -m pip'

if [[ -x `which colordiff` ]]; then
    alias diff='colordiff'
fi

alias open='xdg-open'
alias udiff='diff --new-line-format="+%L" --old-line-format="-%L" --unchanged-line-format=" %L"'
alias pbcopy='xsel --clipboard --input'

alias tsmuxer='tsMuxeR'
alias topcoder='javaws ContestAppletProd.jnlp'
