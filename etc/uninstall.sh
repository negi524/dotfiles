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

# fzfのダウンロードディレクトリがある場合のみ、削除
if [ -d ${HOME}/.fzf ]; then
  rm -i ${HOME}/.fzf
fi
