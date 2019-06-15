#!/bin/bash
set -eu

DOTPATH="${HOME}/dotfiles"

cd ${DOTPATH}

# main関数
function main () {
  create_ln ".vimrc"
  create_ln ".bash_profile"

  # vim --------------------------------------

  # vimの設定ディレクトリが存在しない場合は作成する
  set_dir ".vim"
  set_dir ".vim/colors"
  set_dir ".vim/autoload"

  create_ln ".vim/colors/hybrid.vim"
  create_ln ".vim/autoload/plug.vim"

  # fish -------------------------------------

  # fishの設定ディレクトリが存在しない場合は作成する
  set_dir ".config/fish"
  set_dir ".config/fish/functions"

  create_ln ".config/fish/config.fish"
  create_ln ".config/fish/functions/fish_prompt.fish"
}

# シンボリックリンクを貼る関数
# 同じファイルが存在する場合、上書きする
# $1: 対象ファイル
function create_ln () {
  local FILE=$1

  ln -vsf ${DOTPATH}/${FILE} ${HOME}/${FILE}
  return 0
}

# 対象のディレクトリがない場合は作成する関数
# $1: 対象ディレクトリ
function set_dir () {
  local DIR=$1

  if [ ! -d ${HOME}/${DIR} ]; then
    mkdir ${HOME}/${DIR}
  fi
  return 0
}

# main関数実行
main


exit 0
