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

# vim --------------------------------------

# vimの設定ディレクトリが存在しない場合は作成する
if [ ! -d ${HOME}/.vim ]; then
  mkdir ${HOME}/.vim
fi

if [ ! -d ${HOME}/.vim/colors ]; then
  mkdir ${HOME}/.vim/colors
fi

create_ln ".vim/colors/hybrid.vim"

# fish -------------------------------------

# fishの設定ディレクトリが存在しない場合は作成する
if [ ! -d ${HOME}/.config/fish ]; then
  mkdir ${HOME}/.config/fish
fi

if [ ! -d ${HOME}/.config/fish/functions ]; then
  mkdir ${HOME}/.config/fish/functions
fi

create_ln ".config/fish/config.fish"
create_ln ".config/fish/functions/fish_prompt.fish"

exit 0
