# 配色の設定
export LSCOLORS=gxfxcxdxbxegedabagacad

# aliasの設定
alias ..='cd ..'
alias gs='git status'

# pyenv用の設定
set -x PATH $HOME/.pyenv/bin $PATH
eval (pyenv init - | source)
