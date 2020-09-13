# zplug ================================
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
fi
source ~/.zplug/init.zsh

# install plugins ----------------------

# 補完強化
zplug "zsh-users/zsh-completions"
# コマンドを種類ごとに色付け
zplug "zsh-users/zsh-syntax-highlighting", defer:2
# cd-gitroot コマンド
zplug "mollifier/cd-gitroot"
# fizzy function
zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
zplug "junegunn/fzf", as:command, use:bin/fzf-tmux

# --------------------------------------

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    zplug install
fi
# Then, source plugins and add commands to $PATH
zplug load #--verbose

# end zplug ============================


# vim ==================================
if [[ ! -d ~/.vim ]]; then
	mkdir ~/.vim
	curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > ~/.vim/installer.sh
	sh ~/.vim/installer.sh ~/.vim/dein
	rm ~/.vim/installer.sh 
	mkdir ~/.vim/undodir
fi
# end vim ==============================


# fzf ==================================
export FZF_DEFAULT_OPTS='--height 80% --reverse --border'

# fgco - checkout git branch (including remote branches)
fgco() {
  local branches branch
  branches=$(git branch --color=always --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux --ansi -d $(( 2 + $(wc -l <<< "$branches") )) +m --preview "echo {} | sed 's/.* //' | xargs git log --color=always") &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fggr - git commit browser
fggr() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

# fga - git add browser
fga() {
    local selected
    selected=$(git -c color.status=always status -s | fzf -m --ansi --preview='echo {} | cut -c 4- | sed "s/^/\"/" | sed "s/$/\"/" | xargs git diff --color' | cut -c 4- | sed "s/^/\"/" | sed "s/$/\"/")
    if [[ -n "$selected" ]]; then
        echo $selected | sed "/^$/d" | xargs git add
		selected=$(echo $selected | tr '\n' ' ')
        echo "Completed: git add $selected"
    fi
}

# fgrs - git restore --staged browser
fgrs() {
    local selected
    selected=$(git -c color.status=always status -s | fzf -m --ansi | cut -c 4- | sed "s/^/\"/" | sed "s/$/\"/")
    if [[ -n "$selected" ]]; then
        echo $selected | sed "/^$/d" | xargs git restore --staged
		selected=$(echo $selected | tr '\n' ' ')
        echo "Completed: git restore --staged $selected"
    fi
}

# zkill - kill processes
zkill() {
    local pid
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    fi

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi
}

# zhist - insert the selected command from history into the command line/region
zhist() {
	BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER")
	CURSOR=$#BUFFER
	zle reset-prompt
}

# end fzf ==============================


# prompt  ==============================
autoload -Uz vcs_info
# formats 設定項目で %c,%u が使用可
zstyle ':vcs_info:git:*' check-for-changes true
# commit されていないファイルがある
zstyle ':vcs_info:git:*' stagedstr "%F{green}!"
# add されていないファイルがある
zstyle ':vcs_info:git:*' unstagedstr "%F{magenta}+"
# 通常
zstyle ':vcs_info:*' formats "%F{cyan}%c%u(%b)%f"
# rebase 途中,merge コンフリクト等 formats 外の表示
zstyle ':vcs_info:*' actionformats "[%b|%a]"

precmd () { vcs_info }

setopt prompt_subst

PROMPT='
%B%F{green}%n@%m%f%b:%B%F{blue}%~%f%b ${vcs_info_msg_0_} [%*]
$ '
PROMPT2='> '

# end prompt  ==========================


# .ssh/config を読んでホスト名を補完
#_cache_hosts=$(ruby -ne 'if /^Host\s+(.+)$/; print $1.strip, "\n"; end' ~/.ssh/config)
# 補完有効
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
# 補完で小文字でも大文字にマッチさせる
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# 補完候補を詰めて表示する
setopt list_packed

# 色を使用出来るようにする
autoload -Uz colors
colors
# 日本語ファイル名を表示可能にする
setopt print_eight_bit
# ビープ音の停止
setopt no_beep
# ビープ音の停止(補完時)
setopt nolistbeep
# キーバインディングをemacs風にする
bindkey -d
bindkey -e


#aliases
alias ls='ls -G'
alias ll='ls -la -G'
alias la='ls -a -G'
alias cp='cp -i'
alias mv='mv -i'

alias g='git'
alias ga='git add'
alias gb='git branch'
alias gc='git commit'
alias gcm='git commit -m'
alias gco='git checkout'
alias gcom='git checkout master'
alias gd='git diff'
alias gdhu='git diff HEAD @{u} --stat'
alias gfo='git fetch origin'
alias gfu='git fetch upstream'
alias gg='git grep'
alias ggr='git graph'
alias gl='git log'
alias gmod='git merge origin/develop'
alias gmom='git merge origin/master'
alias gmud='git merge upstream/develop'
alias gpo='git push origin'
alias gpoh='git push -u origin HEAD'
alias gpom='git push origin master'
alias grh='git reset --hard'
alias grhu='git reset --hard @{u}'
alias gs='git status'
alias gst='git stash'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gstu='git stash -u'

export GREP_OPTIONS='--color=auto'

# history
LANG=ja_JP.UTF-8
HISTFILE=$HOME/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt no_flow_control
# 複数シェルで履歴を共有
setopt share_history
# 直前と同じコマンドの場合は履歴に追加しない
setopt hist_ignore_dups
# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups
# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space
# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

zle -N zhist
bindkey '^r' zhist

setopt monitor

# ssh 補完
h=()
if [[ -r ~/.ssh/config ]]; then
  h=($h ${${${(@M)${(f)"$(cat ~/.ssh/config)"}:#Host *}#Host }:#*[*?]*})
fi
if [[ -r ~/.ssh/known_hosts ]]; then
  h=($h ${${${(f)"$(cat ~/.ssh/known_hosts{,2} || true)"}%%\ *}%%,*}) 2>/dev/null
fi
if [[ $#h -gt 0 ]]; then
  zstyle ':completion:*:ssh:*' hosts $h
  zstyle ':completion:*:slogin:*' hosts $h
fi

# for golang
export GOPATH=$(go env GOPATH)
PATH=$PATH:$(go env GOPATH)/bin

export sshpass

# path
PATH="$PATH:$HOME/.bin"
typeset -U path PATH

