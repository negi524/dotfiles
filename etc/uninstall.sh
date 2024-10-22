#!/bin/bash
set -eu

DOTPATH="${HOME}/dotfiles"

cd ${DOTPATH}


if [ -f ${HOME}/.vimrc ]; then
  rm -i ${HOME}/.vimrc
fi

if [ -f $HOME}/.bash_profile ]; then
  rm -i ${HOME}/.bash_profile
fi

# ダウンロードしたgit-prompt.shを削除
if [ -f ${HOME}/.git-prompt.sh ]; then
  rm -i ${HOME}/.git-prompt.sh
fi

# fzfのダウンロードディレクトリがある場合のみ、削除
if [ -d ${HOME}/.fzf ]; then
  rm -i ${HOME}/.fzf
fi
