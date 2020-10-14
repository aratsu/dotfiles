#!/bin/bash

scp mac/{.vimrc,.zshrc,.tmux.conf} yj-yudarats01:~/
ssh yj-yudarats01 "rm -rf .vim .zplug .zcompdump"
