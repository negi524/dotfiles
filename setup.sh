#!/bin/bash
set -eu

DOTPATH="${HOME}/dotfiles"

cd ${DOTPATH}


# シンボリックリンクを貼る関数
# $1: 対象ファイル
create_ln () {
  local FILE=$1

  ln -sf ${DOTPATH}/${FILE} ${HOME}/${FILE}
  echo "symbolic link: ${HOME}/${FILE} -> ${DOTPATH}/${FILE}"
  return 0
}

create_ln ".vimrc"
create_ln ".bash_profile"

# vimの設定ディレクトリが存在しない場合は作成する
if [ ! -d ${HOME}/.vim/colors ]; then
  mkdir ${HOME}/.vim/colors
elif [ ! -d ${HOME}/.vim ]; then
  mkdir ${HOME}/.vim
  mkdir ${HOME}/.vim/colors
fi

create_ln ".vim/colors/hybrid.vim"

# fishの設定ディレクトリがある場合のみシンボリックリンクを作成する
if [ -d ${HOME}/.config/fish ]; then
  create_ln ".config/fish/config.fish"
else
  echo "No such directory: ${HOME}/.cofig/fish"
fi

exit 0
