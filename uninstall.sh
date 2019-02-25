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

# fishの設定ディレクトリがある場合のみfishディレクトリ配下を削除
if [ -d ${HOME}/.config/fish ]; then
  rm -i ${HOME}/.config/fish/config.fish
fi
